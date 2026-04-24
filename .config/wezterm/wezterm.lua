local wezterm = require("wezterm")
local action = wezterm.action

local config = {}

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.default_cursor_style = "SteadyBar"
-- config.color_scheme = "Google Light (base16)"
config.color_scheme = "AtomOneLight"
config.colors = {
  foreground = "#1f1f1f",

    ansi = {
      "#000000",
      "#c62828",
      "#2e7d32",
      "#b26a00",
      "#1565c0",
      "#6a1b9a",
      "#00838f",
      "#1f1f1f",
    },

    brights = {
      "#555555",
      "#e53935",
      "#43a047",
      "#f9a825",
      "#1e88e5",
      "#8e24aa",
      "#00acc1",
      "#000000",
    },
}

config.keys = {
  {
    key = "c",
    mods = "CTRL",
    action = wezterm.action_callback(function(window, pane)
      local selectionText = window:get_selection_text_for_pane(pane)
      if selectionText ~= "" then
        window:copy_to_clipboard(selectionText, "Clipboard")
        window:perform_action(action.ClearSelection, pane)
        return
      end
      window:perform_action(action.SendKey({ key = "c", mods = "CTRL" }), pane)
    end),
  },
  {
    key = "v",
    mods = "CTRL",
    action = action.PasteFrom("Clipboard"),
  },
  {
    key = "Enter",
    mods = "SHIFT",
    action = action.SendString("\n"),
  },
}

return config
