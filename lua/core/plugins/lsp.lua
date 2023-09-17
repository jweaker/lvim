local linters = require("lvim.lsp.null-ls.linters")
local formatters = require("lvim.lsp.null-ls.formatters")
local lsp_manager = require("lvim.lsp.manager")
lvim.builtin.cmp.sources[#lvim.builtin.cmp.sources + 1] = { name = "cmp_tabnine" }

lsp_manager.setup("tsserver", {
	single_file_support = true,
})
lsp_manager.setup("jsonls", {
	single_file_support = true,
})
lsp_manager.setup("lua_ls", {
	single_file_support = true,
})
lsp_manager.setup("emmet_ls", {
	single_file_support = true,
})
lsp_manager.setup("bashls", {
	single_file_support = true,
})
lsp_manager.setup("cssls", {
	single_file_support = true,
})
lsp_manager.setup("cssmodules_ls", {
	single_file_support = true,
})
lsp_manager.setup("svelte", { single_file_support = true })

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
