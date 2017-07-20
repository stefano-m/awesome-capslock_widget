--[[

  Copyright 2017 Stefano Mazzucco <stefano AT curso DOT re>

  This program is free software: you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free Software
  Foundation, either version 3 of the License, or (at your option) any later
  version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  You should have received a copy of the GNU General Public License along with
  this program.  If not, see <https://www.gnu.org/licenses/gpl-3.0.html>.

]]

--[[
  A simple widget to show whether Caps Lock is active.
  Requirements:
  - Awesome 4.x
  - xset

  @usage
  capslock = require("capslock")
  -- Add widget to wibox
  s.mywibox:setup {
  layout = wibox.layout.align.horizontal,
  { -- Left widgets
    layout = wibox.layout.fixed.horizontal,
    capslock
  }
  -- more stuff
  }
  -- Add key to globalkeys
  globalkeys = awful.util.table.join(globalkeys, capslock.key)

]]

local math = math
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local checkbox = wibox.widget {
  checked = false,
  border_width = 0,
  paddings = 2,
  check_shape = function (cr, w, h)
    gears.shape.transform(gears.shape.powerline)
      :rotate(-math.pi/2)
      :translate(-h, 0)(cr, w, h)
  end,
  widget = wibox.widget.checkbox
}

local function check_caps_lock()
  awful.spawn.with_line_callback(
    "bash -c 'sleep 0.2 && xset q'",
    {
      stdout = function (line)
        if line:match("Caps Lock") then
          local status = line:gsub(".*(Caps Lock:%s+)(%a+).*", "%2")
          if status == "on" then
            checkbox.checked = true
          else
            checkbox.checked = false
          end
        end
      end
    }
  )
end

local capslock = awful.key({}, "Caps_Lock", check_caps_lock)
checkbox.key = capslock

check_caps_lock()

return checkbox
