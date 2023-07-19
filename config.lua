-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

local linters = require "lvim.lsp.null-ls.linters"
local formatters = require "lvim.lsp.null-ls.formatters"
local lsp_manager = require("lvim.lsp.manager")
local actions = require "telescope.actions"

vim.opt.relativenumber = true

lvim.format_on_save = true
lvim.transparent_window = false
lvim.colorscheme = "onedark"
lvim.keys.normal_mode["<Esc>"] = ":noh <CR>"
lvim.keys.normal_mode["<Tab>"] = "<cmd>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = "<cmd>BufferLineCyclePrev<CR>"

lvim.keys.normal_mode["<C-p>"] = "<cmd>Telescope git_files<CR>"
lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope live_grep<CR>", "live grep" }

lvim.keys.insert_mode["<C-BS>"] = "<C-W>"
lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.autotag.filetypes = { "html", "xml", "typescript", "typescriptreact", "javascript",
  "javascriptreact" }

vim.api.nvim_create_autocmd('DirChanged', {
  callback = function()
    local Discord = require 'nvimcord.discord'
    Discord.config.workspace_name = vim.fs.basename(vim.v.event.cwd)
  end,
})
lvim.builtin.cmp.sources[#lvim.builtin.cmp.sources + 1] = { name = "cmp_tabnine" }
lsp_manager.setup("tsserver", {
  single_file_support = true,
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
})
lsp_manager.setup("jsonls", {
  single_file_support = true,
  filetypes = { "json" }
})
lsp_manager.setup("lua_ls", {
  single_file_support = true,
  filetypes = { "lua" }
})
lsp_manager.setup("emmet_ls", {
  single_file_support = true,
  filetypes = { "xml", "html" }
})
lsp_manager.setup("bashls", {
  single_file_support = true,
  filetypes = { "zsh", "bash", "sh", "dash" }
})

linters.setup {
  { command = "eslint_d",   filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
  { command = "jsonlint",   filetypes = { "json" } },
  { command = "shellcheck", filetypes = { "dash", "bash", "sh" } }
}

formatters.setup {
  {
    command = "prettierd",
    filetypes = { "html", "markdown", "css", "javascript", "javascriptreact", "typescript", "typesriptreact" },
  },
}


lvim.plugins = {
  {
    "navarasu/onedark.nvim",
    config = function()
      require('onedark').setup {
        style = 'dark'
      }
      require('onedark').load()
    end
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },
  {
    "ObserverOfTime/nvimcord",
    lazy = false,
    config = function()
      -- NOTE: these are the defaults
      require('nvimcord').setup {
        autostart = true,
      }
    end
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    lazy = false,
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          "typescript-language-server",
          "jsonls",
          "lua_ls",
          "emmet_ls",
          "bash-language-server",
          "eslint_d",
          "prettierd",
          "jsonlint",
          "shellcheck"
        },
        auto_update = true,
        run_on_start = true,
        start_delay = 3000, -- 3 second delay
        debounce_hours = 5, -- at least 5 hours between attempts to install/update
      }
    end

  }
  -- {
  --   "andweeb/presence.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     -- The setup config table shows all available config options with their default values:
  --     require("presence").setup {
  --       -- General options
  --       auto_update = true,                             -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
  --       neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
  --       main_image = "neovim",                          -- Main image display (either "neovim" or "file")
  --       client_id = "793271441293967371",               -- Use your own Discord application client id (not recommended)
  --       log_level = nil,                                -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
  --       debounce_timeout = 10,                          -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
  --       enable_line_number = false,                     -- Displays the current line number instead of the current project
  --       blacklist = {},                                 -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
  --       buttons = false,                                -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
  --       file_assets = {},                               -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
  --       show_time = true,                               -- Show the timer

  --       -- Rich Presence text options
  --       editing_text = "Editing %s",              -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
  --       file_explorer_text = "Browsing %s",       -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
  --       git_commit_text = "Committing changes",   -- Format string rendered when committing changes in git (either string or function(filename: string): string)
  --       plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
  --       reading_text = "Reading %s",              -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
  --       workspace_text = "Working on %s",         -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
  --       line_number_text = "Line %s out of %s",   -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
  --     }
  --   end,
  -- },

}
