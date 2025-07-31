local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 19

config.color_scheme = "Kanagawa"

config.window_background_opacity = 0.7
config.macos_window_background_blur = 40

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

return config
