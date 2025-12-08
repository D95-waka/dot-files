local ls = require("luasnip")
local utils = require("luasnip-latex-snippets.util.utils")
local ts_utils = require("luasnip-latex-snippets.util.ts_utils")
local in_math = ts_utils.in_mathzone
local in_text = ts_utils.in_text
local pipe, no_backslash = utils.pipe, utils.no_backslash
local in_math_no_backslash = pipe({ in_math, no_backslash })

ls.add_snippets("tex", {
	ls.parser.parse_snippet(
		{ trig = "mk", name = "Math inline mode", condition = in_text, priority = 10 },
		"$${1:${TM_SELECTED_TEXT}}$$0"
	),
	ls.parser.parse_snippet(
		{ trig = "$", name = "Math inline mode", condition = in_text, priority = 10 },
		"$${1:${TM_SELECTED_TEXT}}$$0"
	),
	ls.parser.parse_snippet(
		{ trig = "dm", name = "Block Math", condition = in_text, priority = 11 },
		"\\[\n\t${1:${TM_SELECTED_TEXT}}\n.\\]$0"
	),
	ls.parser.parse_snippet(
		{ trig = "bold", name = "bold text", condition = in_text, priority = 10 },
		"\\textbf{${1:${TM_SELECTED_TEXT}}$0"
	),
	ls.parser.parse_snippet(
		{ trig = "pow", name = "expression powered by", condition = in_math, priority = 10 },
		"{(${1:${TM_SELECTED_TEXT}})}^${2:2}$0"
	),
	ls.parser.parse_snippet(
		{ trig = "sum", name = "summation", condition = in_math_no_backslash, priority = 10 },
		"\\sum_{${1:${TM_SELECTED_TEXT}}}^${2:\\infty} $0"
	),
	ls.parser.parse_snippet(
		{ trig = "int", name = "integral", condition = in_math_no_backslash, priority = 11 },
		"\\int_{${1:-\\infty}}^{${2:\\infty}} ${0:${TM_SELECTED_TEXT}}"
	),
	ls.parser.parse_snippet(
		{ trig = "set", name = "bounded set notation", condition = in_math_no_backslash, priority = 10 },
		"{\\{ ${1:${TM_SELECTED_TEXT}} \\\\}}$0"
	),
	ls.parser.parse_snippet(
		{ trig = "seq", name = "sequence notation", condition = in_math_no_backslash, priority = 10 },
		"{(${1:${TM_SELECTED_TEXT}})}_{${2:n = 1}}^{${3:\\infty}}$0"
	),
	ls.parser.parse_snippet(
		{ trig = "ovs", name = "element overset", condition = in_math, priority = 10 },
		"\\overset{${1:${TM_SELECTED_TEXT}}}{${2:=}} $0"
	),
	ls.parser.parse_snippet(
		{ trig = "se ", name = "⊆", condition = in_math, priority = 10 },
		"\\subseteq $0"
	),
	ls.parser.parse_snippet(
		{ trig = "in ", name = "∈", condition = in_math, priority = 10 },
		"\\in $0"
	),
	ls.parser.parse_snippet(
		{ trig = "nin", name = "∉", condition = in_math, priority = 10 },
		"\\notin $0"
	),
	ls.parser.parse_snippet(
		{ trig = "|=", name = "⊨", condition = in_math, priority = 10 },
		"\\models$0"
	),
	ls.parser.parse_snippet(
		{ trig = "|-", name = "⊢", condition = in_math, priority = 10 },
		"\\vdash$0"
	),
	ls.parser.parse_snippet(
		{ trig = "...", name = "...", condition = in_math, priority = 101 },
		"\\ldots$0"
	),
	ls.parser.parse_snippet(
		{ trig = ",,,", name = ", ...,", condition = in_math_no_backslash, wordTrig = false, priority = 10 },
		", \\ldots, $0"
	),
	ls.parser.parse_snippet(
		{ trig = "+++", name = "+ ... +", condition = in_math_no_backslash, priority = 10 },
		"+ \\cdots + $0"
	),
	ls.parser.parse_snippet(
		{ trig = "^^", name = "superscript", condition = in_math_no_backslash, wordTrig = false, priority = 10 },
		"^{${1:-1}}$0"
	),
	ls.parser.parse_snippet(
		{ trig = "000", name = "empty set", condition = in_math, priority = 11 },
		"\\emptyset$0"
	),
	ls.parser.parse_snippet(
		{ trig = "opn", name = "operator name command", condition = in_math, priority = 10 },
		"\\operatorname{${1:${TM_SELECTED_TEXT}}}$0"
	),
	ls.snippet(
		{
			trig = "(%a+)opn",
			name = "operatoname notation for text",
			wordTrig = false,
			condition = in_math_no_backslash,
			regTrig = true,
			priority = 101
		},
		ls.function_node(function(_, snip)
			return string.format("\\operatorname{%s}", snip.captures[1])
		end, {})
	),
	ls.parser.parse_snippet(
		{ trig = "sq", name = "square root", condition = in_math_no_backslash, priority = 11 },
		"\\sqrt{${1:${TM_SELECTED_TEXT}}}$0"
	),
	ls.parser.parse_snippet(
		{ trig = "tild", name = "tilde over text", condition = in_math_no_backslash, priority = 10 },
		"\\tilde{${1:${TM_SELECTED_TEXT}}}$0"
	),
	ls.parser.parse_snippet(
		{ trig = "bar", name = "bar notation over text", condition = in_math_no_backslash, priority = 11 },
		"\\bar{${1:${TM_SELECTED_TEXT}}}$0"
	),
	ls.snippet(
		{
			trig = "(%a+)bar",
			name = "bar notation over text",
			wordTrig = false,
			condition = in_math_no_backslash,
			regTrig = true,
			priority = 101
		},
		ls.function_node(function(_, snip)
			return string.format("\\bar{%s}", snip.captures[1])
		end, {})
	),
	ls.parser.parse_snippet(
		{ trig = "ovl", name = "overline over text", condition = in_math_no_backslash, priority = 10 },
		"\\overline{${1:${TM_SELECTED_TEXT}}}$0"
	),
	ls.snippet(
		{
			trig = "(%a+)ovl",
			name = "overline notation over text",
			wordTrig = false,
			condition = in_math_no_backslash,
			regTrig = true,
			priority = 101
		},
		ls.function_node(function(_, snip)
			return string.format("\\overline{%s}", snip.captures[1])
		end, {})
	),
	ls.parser.parse_snippet(
		{ trig = "unl", name = "underline under text", condition = in_math_no_backslash, priority = 10 },
		"\\underline{${1:${TM_SELECTED_TEXT}}}$0"
	),

	-- Greek letters
	ls.parser.parse_snippet(
		{ trig = ".a", name = "alpha", condition = in_math, priority = 10 },
		"\\alpha"
	),
	ls.parser.parse_snippet(
		{ trig = ".b", name = "beta", condition = in_math, priority = 10 },
		"\\beta"
	),
	ls.parser.parse_snippet(
		{ trig = ".g", name = "gamma", condition = in_math, priority = 10 },
		"\\gamma"
	),
	ls.parser.parse_snippet(
		{ trig = ".G", name = "Gamma", condition = in_math, priority = 10 },
		"\\Gamma"
	),
	ls.parser.parse_snippet(
		{ trig = ".d", name = "delta", condition = in_math, priority = 10 },
		"\\delta"
	),
	ls.parser.parse_snippet(
		{ trig = ".D", name = "Delta", condition = in_math, priority = 10 },
		"\\Delta"
	),
	ls.parser.parse_snippet(
		{ trig = ".e", name = "epsilon", condition = in_math, priority = 10 },
		"\\epsilon"
	),
	ls.parser.parse_snippet(
		{ trig = ".z", name = "zeta", condition = in_math, priority = 10 },
		"\\zeta"
	),
	ls.parser.parse_snippet(
		{ trig = ".h", name = "eta", condition = in_math, priority = 10 },
		"\\eta"
	),
	ls.parser.parse_snippet(
		{ trig = ".y", name = "theta", condition = in_math, priority = 10 },
		"\\theta"
	),
	ls.parser.parse_snippet(
		{ trig = ".Y", name = "Theta", condition = in_math, priority = 10 },
		"\\Theta"
	),
	ls.parser.parse_snippet(
		{ trig = ".i", name = "iota", condition = in_math, priority = 10 },
		"\\iota"
	),
	ls.parser.parse_snippet(
		{ trig = ".k", name = "kappa", condition = in_math, priority = 10 },
		"\\kappa"
	),
	ls.parser.parse_snippet(
		{ trig = ".l", name = "lambda", condition = in_math, priority = 10 },
		"\\lambda"
	),
	ls.parser.parse_snippet(
		{ trig = ".L", name = "Lambda", condition = in_math, priority = 10 },
		"\\Lambda"
	),
	ls.parser.parse_snippet(
		{ trig = ".m", name = "mu", condition = in_math, priority = 10 },
		"\\mu"
	),
	ls.parser.parse_snippet(
		{ trig = ".n", name = "nu", condition = in_math, priority = 10 },
		"\\nu"
	),
	ls.parser.parse_snippet(
		{ trig = ".x", name = "xi", condition = in_math, priority = 10 },
		"\\xi"
	),
	ls.parser.parse_snippet(
		{ trig = ".X", name = "Xi", condition = in_math, priority = 10 },
		"\\Xi"
	),
	ls.parser.parse_snippet(
		{ trig = ".p", name = "pi", condition = in_math, priority = 10 },
		"\\pi"
	),
	ls.parser.parse_snippet(
		{ trig = ".P", name = "Pi", condition = in_math, priority = 10 },
		"\\Pi"
	),
	ls.parser.parse_snippet(
		{ trig = ".r", name = "rho", condition = in_math, priority = 10 },
		"\\rho"
	),
	ls.parser.parse_snippet(
		{ trig = ".s", name = "sigma", condition = in_math, priority = 10 },
		"\\sigma"
	),
	ls.parser.parse_snippet(
		{ trig = ".S", name = "Sigma", condition = in_math, priority = 10 },
		"\\Sigma"
	),
	ls.parser.parse_snippet(
		{ trig = ".t", name = "tau", condition = in_math, priority = 10 },
		"\\tau"
	),
	ls.parser.parse_snippet(
		{ trig = ".f", name = "phi", condition = in_math, priority = 10 },
		"\\phi"
	),
	ls.parser.parse_snippet(
		{ trig = ".F", name = "Phi", condition = in_math, priority = 10 },
		"\\Phi"
	),
	ls.parser.parse_snippet(
		{ trig = ".c", name = "chi", condition = in_math, priority = 10 },
		"\\chi"
	),
	ls.parser.parse_snippet(
		{ trig = ".v", name = "psi", condition = in_math, priority = 10 },
		"\\psi"
	),
	ls.parser.parse_snippet(
		{ trig = ".V", name = "Psi", condition = in_math, priority = 10 },
		"\\Psi"
	),
	ls.parser.parse_snippet(
		{ trig = ".o", name = "omega", condition = in_math, priority = 10 },
		"\\omega"
	),
	ls.parser.parse_snippet(
		{ trig = ".O", name = "Omega", condition = in_math, priority = 10 },
		"\\Omega"
	),
}, {
	type = "autosnippets",
})

local function environment_s(env_name)
	return ls.parser.parse_snippet(
		{ trig = env_name, name = env_name .. " environment", condition = in_text, priority = 10 },
		"\\begin{" .. env_name .. "}\n\t${1:${TM_SELECTED_TEXT}}\n\\end{" .. env_name .. "}$0"
	)
end

local function named_environment_s(env_name)
	return ls.parser.parse_snippet(
		{ trig = env_name, name = env_name .. " environment", condition = in_text, priority = 10 },
		"\\begin{" .. env_name .. "}[$2]\n\t${1:${TM_SELECTED_TEXT}}\n\\end{" .. env_name .. "}$0"
	)
end

ls.add_snippets("tex", {
	environment_s('example'),
	environment_s('remark'),
	environment_s('proposition'),
	environment_s('corollary'),
	environment_s('proof'),
	environment_s('solution'),
	environment_s('lemma'),
	environment_s('enumerate'),
	named_environment_s('theorem'),
	named_environment_s('definition'),
}, {
	type = "snippets",
})
