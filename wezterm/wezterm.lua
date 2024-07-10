-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-------------------------------------------------------------------------------
-- FONT
-------------------------------------------------------------------------------
config.font = wezterm.font_with_fallback({
	-- 'JetBrainsMono Nerd Font', 'Noto Sans CJK SC',
	{ family = "JetBrainsMono Nerd Font", weight = "Medium" },
	{ family = "JetBrainsMono Nerd Font", weight = "Bold" },
	{ family = "Noto Sans CJK SC", weight = "Regular" },
	{ family = "Noto Sans CJK SC", weight = "Bold" },
})
config.font_size = 12
config.line_height = 1.3

--------------------------------------------------------------------------------
-- KEY ASSIGNMENTS
--------------------------------------------------------------------------------
config.keys = {
	{
		key = "F11",
		-- mods = 'SHIFT|CTRL',
		action = wezterm.action.ToggleFullScreen,
	},
}

--------------------------------------------------------------------------------
-- DECORATE
--------------------------------------------------------------------------------
config.window_decorations = "INTEGRATED_BUTTONS"
config.integrated_title_buttons = { "Hide", "Maximize", "Close" }
config.integrated_title_button_style = "Gnome"
-- config.integrated_title_button_color = "green"
--
-- config.color_scheme = 'Material (base16)'
-- config.color_scheme = 'Misterioso'
config.color_scheme = "Rapture" -- Mocha, Macchiato, Frappe, Latte

-- 启用窗口背景模糊效果
config.window_background_opacity = 1.0 -- 设置窗口的不透明度，0 表示完全透明，1 表示完全不透明
config.macos_window_background_blur = 20 -- 设置模糊半径，可以根据需要调整
-- tab-bar
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
-- scroll-bar
config.enable_scroll_bar = false
-- border
local aspect_ratio = 5 / 16
local border_cell_w = 0.40
local border_color = "blue" -- or #00ffff
local border_cell_h = border_cell_w * aspect_ratio
config.window_frame = {
	border_left_width = string.format("%fcell", border_cell_w),
	border_right_width = string.format("%fcell", border_cell_w),
	border_bottom_height = string.format("%fcell", border_cell_h),
	border_top_height = string.format("%fcell", border_cell_h),
	border_left_color = border_color,
	border_right_color = border_color,
	border_bottom_color = border_color,
	border_top_color = border_color,
}
-- padding
local padding_cell_w = 0.5
local padding_cell_h = padding_cell_w * aspect_ratio
config.window_padding = {
	left = string.format("%fcell", padding_cell_w),
	right = string.format("%fcell", padding_cell_w),
	top = string.format("%fcell", padding_cell_h),
	bottom = string.format("%fcell", padding_cell_h),
}

-------------------------------------------------------------------------------
-- LAUNCHING
-------------------------------------------------------------------------------
-- 启动时默认指定程序
-- config.default_prog = {
--   '/home/xia/Software/NeoVim/nvim',
--   ''
-- }

-- 启动时最大化窗口
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-------------------------------------------------------------------------------
-- Mouse Behaviour
-------------------------------------------------------------------------------
config.mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

return config
