-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

local linters = require("lvim.lsp.null-ls.linters")
local formatters = require("lvim.lsp.null-ls.formatters")
local lsp_manager = require("lvim.lsp.manager")
local actions = require("telescope.actions")

vim.opt.relativenumber = true
vim.opt.spell = true
if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font:h13"
	vim.g.neovide_hide_mouse_when_typing = true
end

lvim.format_on_save = true
lvim.transparent_window = true

lvim.colorscheme = "onedark"
lvim.keys.normal_mode["<Esc>"] = ":noh <CR>"
lvim.keys.normal_mode["<Tab>"] = "<cmd>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = "<cmd>BufferLineCyclePrev<CR>"

vim.keymap.set("n", "H", "^")
vim.keymap.set("v", "H", "^")
vim.keymap.set("o", "H", "^")

vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "L", "$")
vim.keymap.set("o", "L", "$")

vim.keymap.set("n", "<M-d>", '"_d')
vim.keymap.set("v", "<M-d>", '"_d')
vim.keymap.set("o", "<M-d>", '"_d')

vim.keymap.set("n", "<M-c>", '"_c')
vim.keymap.set("v", "<M-c>", '"_c')
vim.keymap.set("o", "<M-c>", '"_c')

vim.keymap.set("n", "<M-P>", '"_dP')
vim.keymap.set("v", "<M-P>", '"_dP')
vim.keymap.set("o", "<M-P>", '"_dP')

vim.keymap.set("i", "<C-BS>", "<C-W>")

lvim.builtin.which_key.mappings["S"] = {
	name = "Session",
	c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}
lvim.builtin.which_key.mappings["s"]["s"] = {
	"<cmd>lua require('spectre').toggle()<CR>",
	"Spectre",
}
lvim.builtin.which_key.mappings["l"]["D"] = lvim.builtin.which_key.mappings["l"]["d"]
lvim.builtin.which_key.mappings["l"]["d"] = {
	"<cmd>Trouble<CR>",
	"Trouble",
}
lvim.builtin.which_key.mappings["u"] = {
	function()
		vim.cmd.UndotreeToggle()
		vim.cmd.UndotreeFocus()
	end,
	"UndoTree",
}

lvim.keys.normal_mode["<C-p>"] = "<cmd>Telescope git_files<CR>"
lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope live_grep<CR>", "live grep" }

local trouble = require("trouble.providers.telescope")

lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next

lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous

lvim.builtin.telescope.defaults.mappings.i["<C-t>"] = trouble.open_with_trouble
lvim.builtin.telescope.defaults.mappings.n["<C-t>"] = trouble.open_with_trouble

lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.autotag.filetypes =
	{ "html", "xml", "typescript", "typescriptreact", "javascript", "javascriptreact" }

vim.api.nvim_create_autocmd("DirChanged", {
	callback = function()
		local Discord = require("nvimcord.discord")
		Discord.config.workspace_name = vim.fs.basename(vim.v.event.cwd)
	end,
})
lvim.builtin.cmp.sources[#lvim.builtin.cmp.sources + 1] = { name = "cmp_tabnine" }
local function lsp_setup()
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
end

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

lvim.plugins = {

	"ThePrimeagen/vim-be-good",
	{
		"karb94/neoscroll.nvim",
		lazy = false,
		config = function()
			local neoscroll = require("neoscroll")

			local easing = "sine"
			local zz_time_ms = 300
			local jump_time_ms = 300

			neoscroll.setup({
				post_hook = function(info)
					if info ~= "center" then
						return
					end

					-- The `defer_fn` is a bit of a hack.
					-- We use it so that `neoscroll.init.scroll` will be false when we call `neoscroll.zz`
					-- As long as we don't input another neoscroll mapping in the timeout,
					-- we should be able to center the cursor.
					local defer_time_ms = 10
					vim.defer_fn(function()
						neoscroll.zz(zz_time_ms, easing)
					end, defer_time_ms)
				end,
			})

			local mappings = {}

			mappings["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", jump_time_ms, easing, "'center'" } }
			mappings["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", jump_time_ms, easing, "'center'" } }

			require("neoscroll.config").set_mappings(mappings)
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = { flavour = "mocha" },
		config = function() end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust", "rs" }, -- IMPORTANT: re-enabling this seems to break inlay-hints
		config = function()
			require("rust-tools").setup({
				tools = {
					executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
					reload_workspace_from_cargo_toml = true,
					inlay_hints = {
						auto = true,
						only_current_line = false,
						show_parameter_hints = true,
						parameter_hints_prefix = "<-",
						other_hints_prefix = "=>",
						max_len_align = false,
						max_len_align_padding = 1,
						right_align = false,
						right_align_padding = 7,
						highlight = "Comment",
					},
					hover_actions = {
						border = {
							{ "╭", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╮", "FloatBorder" },
							{ "│", "FloatBorder" },
							{ "╯", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╰", "FloatBorder" },
							{ "│", "FloatBorder" },
						},
						auto_focus = true,
					},
				},
				server = {
					on_init = require("lvim.lsp").common_on_init,
					on_attach = function(client, bufnr)
						require("lvim.lsp").common_on_attach(client, bufnr)
						local rt = require("rust-tools")
						-- Hover actions
						-- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
						-- Code action groups
						vim.keymap.set("n", "<leader>lA", rt.code_action_group.code_action_group, { buffer = bufnr })
					end,
				},
			})
		end,
	},
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				transparent = true,
				style = "warmer",
			})
			require("onedark").load()
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
	},

	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file sas opened
		lazy = true,
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
				options = { "buffers", "curdir", "tabpages", "winsize" },
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			-- `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
	},
	{
		"windwp/nvim-spectre",
		event = "BufRead",
		config = function()
			require("spectre").setup()
		end,
	},
	{
		"mbbill/undotree",
		event = "BufRead",
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		filetypes = { "html", "xml", "typescript", "typescriptreact", "javascript", "javascriptreact" },
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
			require("nvimcord").setup({
				autostart = true,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"typescript-language-server",
					"jsonls",
					"lua_ls",
					"emmet_ls",
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
		end,
	},
}
lsp_setup()
