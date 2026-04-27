-- Purple theme from waybar config
return {
  black = 0xff1e142d,      -- Dark purple background
  white = 0xffc8aae6,      -- Main text (lavender)
  red = 0xffff6b8a,        -- Soft red
  green = 0xff00ff00,      -- Charging green
  blue = 0xffa064c8,       -- Purple accent
  yellow = 0xffe6d08a,     -- Soft yellow
  orange = 0xffe6a064,     -- Soft orange
  magenta = 0xffc8aae6,    -- Lavender
  grey = 0xff5a4670,       -- Muted purple-grey
  transparent = 0x00000000,

  -- Theme accent colors
  lavender = 0xffc8aae6,   -- rgba(200, 170, 230, 1) - main text
  purple = 0xffa064c8,     -- rgba(160, 100, 200, 1) - highlight/active
  mauve = 0xffa064c8,      -- Same as purple for compatibility
  peach = 0xffe6a064,      -- Soft orange
  teal = 0xff64c8a0,       -- Complementary teal
  sky = 0xff8ab4e6,        -- Soft blue
  sapphire = 0xff6496c8,   -- Deeper blue
  pink = 0xffe6aac8,       -- Soft pink
  rosewater = 0xffe6c8d2,  -- Light pink
  flamingo = 0xffe6b4be,   -- Warm pink
  maroon = 0xffc86478,     -- Muted red

  bar = {
    bg = 0xf01e142d,       -- rgba(30, 20, 45, 1) with slight transparency
    border = 0xff2d1b3d,   -- rgba(45, 27, 61, 1)
  },
  popup = {
    bg = 0xe01e142d,       -- Dark purple with transparency
    border = 0xff5a4670,   -- Muted purple border
  },
  bg1 = 0xff2d1b3d,        -- Slightly lighter purple
  bg2 = 0xff3d2850,        -- Even lighter purple

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
