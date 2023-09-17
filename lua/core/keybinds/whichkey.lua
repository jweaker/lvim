local actions = require("telescope.actions")

lvim.builtin.which_key.setup.ignore_missing = true
lvim.builtin.which_key.mappings["S"] = {
	name = "Session",
	c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}
lvim.builtin.which_key.mappings["s"]["s"] = {
	"<cmd>lua require('spectre').toggle()<CR>",
	"Spectre",
}
lvim.builtin.which_key.mappings["l"]["T"] = {
	"<cmd>Trouble workspace_diagnostics<CR>",
	"Trouble",
}
lvim.builtin.which_key.mappings["l"]["t"] = {
	"<cmd>Trouble document_diagnostics<CR>",
	"Trouble",
}

lvim.builtin.which_key.mappings["h"] = {
	"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
	"Harpoon Marks",
}
lvim.builtin.which_key.mappings["m"] = {
	"<cmd>lua require('harpoon.mark').add_file()<cr>",
	"Mark file with harpoon",
}
lvim.builtin.which_key.mappings["u"] = {
	function()
		vim.cmd.UndotreeToggle()
		vim.cmd.UndotreeFocus()
	end,
	"UndoTree",
}

lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope live_grep<CR>", "live grep" }

lvim.builtin.telescope.defaults.mappings.i["<C-BS>"] = function()
	local key = vim.api.nvim_replace_termcodes("<C-W>", true, false, true)
	vim.api.nvim_feedkeys(key, "i", false)
end
lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next

lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
