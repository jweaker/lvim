local linters = require("lvim.lsp.null-ls.linters")
local formatters = require("lvim.lsp.null-ls.formatters")

linters.setup({
	{ command = "eslint_d", filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
	{ command = "jsonlint", filetypes = { "json" } },
	{ command = "shellcheck", filetypes = { "dash", "bash", "sh" } },
})

formatters.setup({
	{
		command = "prettierd",
		filetypes = {
			"html",
			"markdown",
			"css",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"tsx",
		},
	},
	{
		command = "stylua",
		filetypes = { "lua" },
	},
})
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
