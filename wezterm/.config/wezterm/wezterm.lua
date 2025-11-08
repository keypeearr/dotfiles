local wezterm = require("wezterm")
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local gpus = wezterm.gui.enumerate_gpus()
config.webgpu_preferred_adapter = gpus[1]
config.front_end = "WebGpu"

config.color_scheme = "Black Metal (Burzum) (base16)"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 17

config.window_background_opacity = 0.7
config.macos_window_background_blur = 10
config.window_decorations = "RESIZE"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

config.enable_wayland = false

return config
