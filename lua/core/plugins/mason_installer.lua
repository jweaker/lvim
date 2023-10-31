require("mason-tool-installer").setup({
  ensure_installed = {
    "typescript-language-server",
    "jsonls",
    "lua_ls",
    "emmet_ls",
    "sumenko_lua",
    "bash-language-server",
    "css-lsp",
    "cssmodules-language-server",
    "svelte-language-server",
    "eslint_d",
    "jsonlint",
    "shellcheck",
    "prettierd",
    "stylua",
    "rust_analyzer",
  },
  auto_update = true,
  run_on_start = true,
  start_delay = 3000, -- 3 second delay
  debounce_hours = 5, -- at least 5 hours between attempts to install/update
})
