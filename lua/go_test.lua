local find_test_line = function(bufnr, test)
  for i = 1, vim.api.nvim_buf_line_count(bufnr) do
    local line = vim.api.nvim_buf_get_lines(bufnr, i - 1, i, false)[1]
    if line:find(test) then
      return i - 1
    end
  end
end

local make_key = function(entry)
  assert(entry.Package, "Must have package:" .. vim.inspect(entry))
  assert(entry.Test, "Must have Test:" .. vim.inspect(entry))
  return string.format("%s/%s", entry.Package, entry.Test)
end

local function add_golang_output(state, entry)
  assert(state.tests, vim.inspect(state))
  table.insert(state.tests[make_key(entry)].output, vim.trim(entry.Output))
end

local add_golang_test = function(state, entry)
  local key = make_key(entry)
  if state.tests[key] then
    return
  end
  state.tests[key] = {
    name = entry.Test,
    line = find_test_line(state.bufnr, entry.Test),
    output = {},
  }
end

local add_golang_elapsed = function(state, entry)
  local key = make_key(entry)
  local test = state.tests[key]
  if not test then
    return
  end
  test.elapsed = entry.Elapsed
end

local mark_success = function(state, entry)
  if entry.Action == "pass" then
    -- remove all output
    state.tests[make_key(entry)].output = {}
  end
  state.tests[make_key(entry)].success = entry.Action == "pass"
end

local ns = vim.api.nvim_create_namespace("live-tests")
local skip = function()
  return
end

function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

local state = {
  bufnr = -1,
  tests = {},
}

local function go_test(bufnr, command)
  state.bufnr = bufnr
  -- change directory to the directory of the filetypes
  local dir = vim.fn.expand("%:p:h")
  -- get pwd
  local pwd = vim.fn.getcwd()
  vim.fn.chdir(dir)
  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function(_, data, _)
      if not data then
        print("No data")
        return
      end
      -- check ipairs lentgh
      local count = 0
      for _ in pairs(data) do
        count = count + 1
      end
      if count < 2 then
        print("you may run test in wrong path")
        return
      end

      for _, line in ipairs(data) do
        local decoded = vim.json.decode(line)
        -- check length of decoded
        if decoded.Action == "run" then
          add_golang_test(state, decoded)
        elseif decoded.Action == "output" then
          if not decoded.Test then
            return
          end
          add_golang_output(state, decoded)
        elseif decoded.Action == "pass" or decoded.Action == "fail" then
          if decoded.Elapsed ~= nil then
            add_golang_elapsed(state, decoded)
          end
          mark_success(state, decoded)
        elseif decoded.Action == "pause" or decoded.Action == "cont" then
          skip()
        else
          error("Failed to handle " .. vim.inspect(data))
        end
      end
    end,

    on_exit = function()
      vim.fn.chdir(pwd)
      local test_results = {}
      local passed = 0
      local failed = 0
      local failed_tests = {}

      for _, test in pairs(state.tests) do
        if test.line then
          if test.success == false then
            failed = failed + 1
            local str = string.format("%s:%s", test.name, test.line)
            table.insert(failed_tests, str)
          else
            passed = passed + 1
          end

          local message = ""
          if test.success then
            message = string.format("Test Passed in %s s", test.elapsed)
          else
            message =
            string.format("Test Failed in %s s: %s", test.elapsed, table.concat(test.output, "\n"))
          end

          table.insert(test_results, {
            bufnr = bufnr,
            lnum = test.line,
            col = 0,
            severity = test.success and vim.diagnostic.severity.INFO or vim.diagnostic.severity.ERROR,
            source = "go-test",
            message = message,
            user_data = {},
          })
        end
      end

      vim.diagnostic.set(ns, bufnr, test_results, {})
      -- check test pased
      -- create new split window
      if failed > 0 then
        vim.cmd("split")
        local win = vim.api.nvim_get_current_win()
        local buf = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_win_set_buf(win, buf)
        for _, test in pairs(state.tests) do
          if test.success == false then
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, test.output)
          end
        end
      end
      -- print failed tests
      if failed > 0 then
        print("failed tests:")
        -- string join
        local failed_tests_str = table.concat(failed_tests, ",")
        print(
          string.format("%d/%d tests passed, failed test name %s", passed, passed + failed, failed_tests_str)
        )
      else
        print(string.format("%d/%d tests passed", passed, passed + failed))
      end
    end,
  })
end

vim.api.nvim_create_user_command("GoTestFunc", function()
  if vim.bo.filetype ~= "go" or string.find(vim.fn.expand("%"), "_test") == nil then
    print("Not a go test file")
    return
  end
  local func_name = get_cur_go_func_name()
  local bufnr = vim.api.nvim_get_current_buf()
  go_test(bufnr, {
    "go",
    "test",
    "-run",
    func_name,
    "-v",
    "-json",
    "-count=1",
  })
end, {})

vim.api.nvim_create_user_command("GoTestFile", function()
  if vim.bo.filetype ~= "go" or string.find(vim.fn.expand("%"), "_test") == nil then
    print("Not a go test file")
    return
  end
  local bufnr = vim.api.nvim_get_current_buf()
  local dir = vim.fn.expand("%:p:h")
  -- filename
  local filename = vim.fn.expand("%:t:r")
  local test_name = string.format("%s/%s.go", dir, filename)

  -- cat test file and use go test -run to run tests

  -- alias testcases="sed -n 's/func.*\(Test.*\)(.*/\1/p' | xargs | sed 's/ /|/g'"

  --  $(cat coordinator_test.go | sed -n 's/func.*\(Test.*\)(.*/\1/p' | xargs | sed 's/ /|/g'
  local cmd = string.format("cat %s | sed -n 's/func.*\\(Test.*\\)(.*/\\1/p' | xargs | sed 's/ /|/g'", test_name)
  local handle = io.popen(cmd)
  if handle == nil then
    print("Failed to run command")
    return
  end
  local result = handle:read("*a")
  handle:close()
  -- remove new line
  result = string.gsub(result, "\n", "")

  go_test(bufnr, {
    "go",
    "test",
    "-run",
    result,
    "-json",
    "-count=1",
  })
end, {})
