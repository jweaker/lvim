local hline = require("core.utils.harpoon_lualine")
local function macro_recording()
	local mode = require("noice").api.statusline.mode.get()
	if mode then
		return string.match(mode, "^recording @.*") or ""
	end
	return ""
end
lvim.builtin.lualine.sections.lualine_c = {
	{ macro_recording },
	hline.harpoonFiles,
}
