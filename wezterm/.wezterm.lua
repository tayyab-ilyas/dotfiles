local wezterm = require 'wezterm';

return {
  color_scheme = 'Gruvbox dark, hard (base16)',

  font = wezterm.font_with_fallback({
    "JetBrains Mono",
    "EmojiOne Color",  -- Fallback font for emojis
  }),
  font_size = 11.0,

  enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
  },

  window_background_opacity = 1.0,
  text_background_opacity = 1.0,
};

