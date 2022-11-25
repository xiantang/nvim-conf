local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.i

local s = ls.s
-- ls.add_snippets("lua", {
--   s("req", fmt("fmt.Println({})", { i(1, "Hello World") })),
-- })

-- function with comment
local f = ls.function_node
local function same(index)
	return f(function(args)
		return args[1]
	end, { index })
end

ls.add_snippets("go", {
	s(
		"func",
		fmt(
			[[
    // {}...
    func {}({}) {} {{
      {}
    }}
    ]],
			{
				same(1),
				i(1),
				i(2),
				i(3),
				i(4),
			}
		)
	),
})
