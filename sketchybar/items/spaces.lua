local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local aerospace = "/opt/homebrew/bin/aerospace"

-- Register the aerospace workspace change event
sbar.add("event", "aerospace_workspace_change")

local spaces = {}
local space_brackets = {}
local space_paddings = {}

-- Create workspace items for workspaces 1-9 (initially hidden)
for i = 1, 9, 1 do
  local space = sbar.add("item", "space." .. i, {
    drawing = false,
    icon = {
      font = { family = settings.font.numbers },
      string = i,
      padding_left = 15,
      padding_right = 8,
      color = colors.white,
      highlight_color = colors.purple,
    },
    label = {
      padding_right = 20,
      color = colors.grey,
      highlight_color = colors.white,
      font = "sketchybar-app-font:Regular:16.0",
      y_offset = -1,
    },
    padding_right = 1,
    padding_left = 1,
    background = {
      color = colors.bg1,
      border_width = 1,
      height = 26,
      border_color = colors.bg2,
    },
  })

  spaces[i] = space

  -- Single item bracket for space items to achieve double border on highlight
  local space_bracket = sbar.add("bracket", { space.name }, {
    drawing = false,
    background = {
      color = colors.transparent,
      border_color = colors.bg2,
      height = 28,
      border_width = 2
    }
  })
  space_brackets[i] = space_bracket

  -- Padding item
  local space_padding = sbar.add("item", "space.padding." .. i, {
    drawing = false,
    width = settings.group_paddings,
  })
  space_paddings[i] = space_padding

  -- Click handler - use aerospace to switch workspaces
  space:subscribe("mouse.clicked", function(env)
    if env.BUTTON == "left" then
      sbar.exec(aerospace .. " workspace " .. i)
    end
  end)
end

-- Update all workspace visuals based on focused and non-empty workspaces
local function update_spaces(focused_ws)
  sbar.exec(aerospace .. " list-workspaces --monitor all --empty no", function(result)
    -- Build set of non-empty workspaces
    local non_empty = {}
    for ws in string.gmatch(result, "[^\r\n]+") do
      non_empty[ws] = true
    end

    -- Update each workspace
    for i = 1, 9, 1 do
      local ws_str = tostring(i)
      local is_focused = (ws_str == focused_ws)
      local has_windows = non_empty[ws_str] == true
      local visible = is_focused or has_windows

      -- Set visibility
      spaces[i]:set({ drawing = visible })
      space_brackets[i]:set({ drawing = visible })
      space_paddings[i]:set({ drawing = visible })

      -- Set highlighting
      spaces[i]:set({
        icon = { highlight = is_focused },
        label = { highlight = is_focused },
        background = { border_color = is_focused and colors.purple or colors.bg2 }
      })
      space_brackets[i]:set({
        background = { border_color = is_focused and colors.lavender or colors.bg2 }
      })

      -- Update app icons for visible workspaces
      if visible then
        sbar.exec(aerospace .. " list-windows --workspace " .. i .. " --format '%{app-name}'", function(win_result)
          local icon_line = ""
          for app in string.gmatch(win_result, "[^\r\n]+") do
            local lookup = app_icons[app]
            local icon = lookup or app_icons["Default"]
            icon_line = icon_line .. icon
          end
          spaces[i]:set({ label = icon_line })
        end)
      end
    end
  end)
end

-- Observer for workspace changes
local observer = sbar.add("item", { drawing = false, updates = true })

observer:subscribe("aerospace_workspace_change", function(env)
  local focused = env.FOCUSED
  if focused and focused ~= "" then
    update_spaces(focused)
  else
    -- Fallback: query aerospace
    sbar.exec(aerospace .. " list-workspaces --focused", function(result)
      update_spaces(result:gsub("%s+", ""))
    end)
  end
end)

observer:subscribe("front_app_switched", function(env)
  sbar.exec(aerospace .. " list-workspaces --focused", function(result)
    update_spaces(result:gsub("%s+", ""))
  end)
end)

-- Spaces indicator toggle
local spaces_indicator = sbar.add("item", {
  padding_left = -3,
  padding_right = 0,
  icon = {
    padding_left = 8,
    padding_right = 9,
    color = colors.grey,
    string = icons.switch.on,
  },
  label = {
    width = 0,
    padding_left = 0,
    padding_right = 8,
    string = "Spaces",
    color = colors.bg1,
  },
  background = {
    color = colors.with_alpha(colors.grey, 0.0),
    border_color = colors.with_alpha(colors.bg1, 0.0),
  }
})

spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
  local currently_on = spaces_indicator:query().icon.value == icons.switch.on
  spaces_indicator:set({
    icon = currently_on and icons.switch.off or icons.switch.on
  })
end)

spaces_indicator:subscribe("mouse.entered", function(env)
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 1.0 },
        border_color = { alpha = 1.0 },
      },
      icon = { color = colors.bg1 },
      label = { width = "dynamic" }
    })
  end)
end)

spaces_indicator:subscribe("mouse.exited", function(env)
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 0.0 },
        border_color = { alpha = 0.0 },
      },
      icon = { color = colors.grey },
      label = { width = 0, }
    })
  end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
  sbar.trigger("swap_menus_and_spaces")
end)

-- Initialize on startup
sbar.exec(aerospace .. " list-workspaces --focused", function(result)
  update_spaces(result:gsub("%s+", ""))
end)

