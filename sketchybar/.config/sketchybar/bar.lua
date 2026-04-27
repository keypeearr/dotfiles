local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  height = 40,
  color = colors.bar.bg,
  border_color = colors.bar.border,
  border_width = 1,
  corner_radius = 10,
  margin = 10,
  y_offset = 10,
  padding_right = 10,
  padding_left = 10,
})
