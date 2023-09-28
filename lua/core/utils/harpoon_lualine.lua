local M = {}

local maxSizeFile = 5

function M.filename()
	local currentFile = vim.fn.split(vim.api.nvim_buf_get_name(0), "/")
	currentFile = currentFile[#currentFile]
	if vim.api.nvim_buf_get_option(0, "buftype") ~= "" then
		return currentFile
	end
	local lenSize = string.len(currentFile)
	if lenSize > maxSizeFile then
		maxSizeFile = lenSize
	end
	if maxSizeFile % 2 == 0 then
		maxSizeFile = maxSizeFile + 1
	end
	local padding = math.floor((maxSizeFile - lenSize) / 2)
	if lenSize % 2 == 0 then
		currentFile = currentFile .. " "
	end
	padding = string.rep(" ", padding)
	return padding .. currentFile .. padding
end

local iconMap = {
	"󰎤",
	"󰎧",
	"󰎪",
	"󰎭",
	"󰎱",
}
function M.harpoonFiles()
	if vim.api.nvim_buf_get_option(0, "buftype") ~= "" then
		return ""
	end
	local tabela = require("harpoon").get_mark_config()["marks"]
	local currentFile = vim.fn.split(vim.api.nvim_buf_get_name(0), "/")
	currentFile = currentFile[#currentFile]
	local ret = {}
	for key, value in pairs(tabela) do
		local file = vim.fn.split(value["filename"], "/")
		file = file[#file]
		file = file == currentFile and file .. "" or file .. " "
		table.insert(ret, " " .. iconMap[key] .. " " .. file)
	end
	return table.concat(ret)
end

return M
