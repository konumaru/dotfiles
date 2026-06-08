local wezterm = require("wezterm")

return {
  font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font",
  }),
  font_size = tonumber(os.getenv("DOTFILES_FONT_SIZE")) or 14.0,
}
