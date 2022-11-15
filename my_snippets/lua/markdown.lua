local ls = require("luasnip")

ls.add_snippets("markdown", {
	-- todo date of today
	ls.parser.parse_snippet("todo", "# todo ${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE}"),
})

ls.add_snippets("markdown", {
	ls.parser.parse_snippet("-", "- [ ] ${1}"),
})

ls.add_snippets("gitcommit", {
	ls.parser.parse_snippet("dai", "update daily ${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE}"),
})
