require("nvimcord").setup({
	autostart = true,
})
vim.api.nvim_create_autocmd("DirChanged", {
	callback = function()
		local Discord = require("nvimcord.discord")
		Discord.config.workspace_name = vim.fs.basename(vim.v.event.cwd)
	end,
})
