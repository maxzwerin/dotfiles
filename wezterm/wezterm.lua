local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 13
config.line_height = 1

config.color_scheme = "Dracula"
config.enable_tab_bar = false
config.window_background_opacity = 1.0
config.text_background_opacity = 1.0

config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false

config.default_cursor_style = "BlinkingBlock"
config.scrollback_lines = 3500

return config
