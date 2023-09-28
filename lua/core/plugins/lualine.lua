local success, hline = pcall(require, "core.utils.harpoon_lualine")
local function macro_recording()
	local mode = require("noice").api.statusline.mode.get()
	if mode then
		return string.match(mode, "^recording @.*") or ""
	end
	return ""
end

local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_b = { components.location }
lvim.builtin.lualine.sections.lualine_x = { components.diff, components.branch[1] }
lvim.builtin.lualine.sections.lualine_y = { components.diagnostics }

if success then
	lvim.builtin.lualine.sections.lualine_c = {
		{ macro_recording },
		{ hline.harpoonFiles, color = { fg = "#00FFFF" } },
	}
end
