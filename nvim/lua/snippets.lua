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
		{ trig = "dm", name = "Block Math", condition = in_text, priority = 9 },
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
		{ trig = "int", name = "integral", condition = in_math_no_backslash, priority = 9 },
		"\\int_{${1:-\\infty}}^{${2:\\infty}} ${0:${TM_SELECTED_TEXT}}"
	),
	ls.parser.parse_snippet(
		{ trig = "set", name = "bounded set notation", condition = in_math_no_backslash, priority = 9 },
		"{\\{ ${1:${TM_SELECTED_TEXT}} \\\\}}$0"
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
		{ trig = "...", name = "...", condition = in_math, priority = 6 },
		"\\ldots$0"
	),
	ls.parser.parse_snippet(
		{ trig = "+++", name = "+ ... +", condition = in_math_no_backslash, priority = 10 },
		"+ \\cdots + $0"
	),
	ls.parser.parse_snippet(
		{ trig = "000", name = "empty set", condition = in_math, priority = 9 },
		"\\emptyset$0"
	),
	ls.parser.parse_snippet(
		{ trig = "opn", name = "operator name command", condition = in_math, priority = 10 },
		"\\operatorname{${1:${TM_SELECTED_TEXT}}}$0"
	),
	ls.parser.parse_snippet(
		{ trig = "sq", name = "square root", condition = in_math_no_backslash, priority = 9 },
		"\\sqrt{${1:${TM_SELECTED_TEXT}}}$0"
	),
	ls.parser.parse_snippet(
		{ trig = "tild", name = "tilde over text", condition = in_math_no_backslash, priority = 10 },
		"\\tilde{${1:${TM_SELECTED_TEXT}}}$0"
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
