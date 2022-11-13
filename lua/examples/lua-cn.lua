-- number = 42
-- s = "walternate"
-- t = nil
-- num = 9
-- while num < 40 do
--   num = num + 1
-- end
-- print(num)

-- -- if num > 40 then
-- --   print("num > 40")
-- -- elseif s ~= "walternate" then
-- --   io.write("not over 40")
-- -- else
-- --   thisIsGlobal = 5
-- --   local line = io.read()
-- --   print("Winter is coming, " .. line)
-- -- end

-- -- foo = an

-- -- print(foo)

-- function fib(n)
--   if n < 2 then
--     return n
--   end
--   return fib(n - 2) + fib(n - 1)
-- end

-- print("hello")

-- print({})

-- -- table

-- t = { key1 = "value1", key2 = false }
-- print(t.key1)

-- t.newkey = {}
-- t.key2 = nil
-- print(t.newkey)

-- a = {}
-- u = { [a] = 1 }
-- print(u[a])

-- function h(x)
--   print(x.key1)
-- end

-- h({ key1 = "lua" })

-- print(_G["_G"] == _G)
-- print(_G["number"])

-- v = { "value1", "value2", 1.21, "gigawatts" }

-- for i = 1, #v do
--   print(v[i])
-- end

-- module
local M = {}
print("lua-cn.lua")

local function sayMyName()
  print("Hrunkner")
end

function M.sayHello()
  print("Hello")
  sayMyName()
end

return M
