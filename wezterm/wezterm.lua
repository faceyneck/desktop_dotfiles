-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

-- This is where you actually apply your config choices.


-- Trying to add background transparency via
-- ChatGPT recommendation
config.window_background_opacity = 0.9

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- Here's me trying to disable window re-size when changing font size:
config.adjust_window_size_when_changing_font_size = false

-- Here's me trying to darken the inactive panes:
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.3,
}

-- or, changing the font size and color scheme.
config.font_size = 12
-- config.color_scheme = 'Dimmed Monokai (Gogh)'
-- config.color_scheme = 'Dotshare (terminal.sexy)'
-- config.color_scheme = 'Macintosh (base16)'
-- config.color_scheme = 'Material Darker (base16)'
config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'Batman'




-- Setting JetBrains as the font. I dunno why it went away:
config.font = wezterm.font 'JetBrains Mono'

-- Adding interactive tab renaming:

config.keys = {
  {
    key = 'E',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      initial_value = '',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}



-- Finally, return the configuration to wezterm:
return config
