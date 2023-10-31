lvim.plugins = {
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
			local newSource = { name = "codeium" }
			table.insert(lvim.builtin.cmp.sources, newSource)
			lvim.builtin.cmp.formatting.kind_icons.Codeium = ""
		end,
	},
	{
		"ThePrimeagen/harpoon",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		lazy = false,
		config = function()
			require("core.plugins.neoscroll")
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust", "rs" }, -- IMPORTANT: re-enabling this seems to break inlay-hints
		config = function()
			require("core.plugins.rust_tools")
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
			{
				"s",
				mode = { "n", "o", "x" },
				function()
					require("flash").jump({
						search = { mode = function(str) return "\\<" .. str end, }, })
				end,
				desc = "Flash"
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function() require("flash").treesitter() end,
				desc =
				"Flash Treesitter"
			},
			{
				"r",
				mode = "o",
				function() require("flash").remote() end,
				desc =
				"Remote Flash"
			},
			{
				"R",
				mode = { "o", "x" },
				function() require("flash").treesitter_search() end,
				desc =
				"Treesitter Search"
			},
			{
				"<c-s>",
				mode = { "c" },
				function() require("flash").toggle() end,
				desc =
				"Toggle Flash Search"
			},
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
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("core.plugins.noice")
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
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
		"andweeb/presence.nvim",
		lazy = false,
		config = function()
			require("core.plugins.nvimcord")
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		config = function()
			require("core.plugins.mason_installer")
		end,
	},
}
