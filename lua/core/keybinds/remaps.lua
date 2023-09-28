lvim.keys.normal_mode["<C-p>"] = "<cmd>Telescope git_files<CR>"
lvim.keys.normal_mode["<C-s>"] = "<cmd>w<CR>"
lvim.keys.normal_mode["<Esc>"] = "<cmd>noh <CR>"
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

vim.keymap.set("n", "<M-x>", '"_x')
vim.keymap.set("v", "<M-x>", '"_x')
vim.keymap.set("o", "<M-x>", '"_x')

vim.keymap.set("i", "<C-BS>", "<C-W>")
vim.keymap.set("t", "<C-BS>", "<C-W>")

local success, ui = pcall(require, "harpoon.ui")
if success then
	for i = 1, 9, 1 do
		local i_string = tostring(i)
		lvim.keys.normal_mode["<leader>" .. i_string] = function()
			ui.nav_file(i)
		end
	end
end
