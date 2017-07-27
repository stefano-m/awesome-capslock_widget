# A simple CAPS LOCK widget for Awesome

Useful when you have a keyboard that does not have a CAPS LOCK indicator.

This widget is really simple and parses the output of `xset` to figure out
whether CAPS LOCK is active or not. (Hint: you need the `xset` utility for this
widget to work)

# Installation

1. Ensure that `xset` is available to you on your system.
2. Copy `capslock.lua` in your `~/.config/awesome/ folder` (e.g. by cloning this
   repository).
3. Restart Awesome (e.g. press `modkey + Control` or run `awesome-client
   "awesome.restart()"` from a terminal).

# Usage

For **Awesome 4.x**, add the following to your `~/.config/awesome/rc.lua`:

``` lua
-- If you just copied the file in ~/.config/awesome
local capslock = require("capslock")

-- If you cloned the repo as a submodule in
-- ~/.config/awesome/external/capslock
-- local capslock = require("external.capslock.capslock")

-- more config here

    -- Add widgets to the wibox
    s.mywibox:setup {
-- more config here
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        wibox.widget.systray(),
        capslock,
-- more config here
-- {{{ Key bindings
local globalkeys = awful.util.table.join(
  capslock.key,
-- more config follows
```

Now, when CAPS LOCK is active, an uppercase letter **A** will be displayed

![active_capslock screenshot](/screenshots/active_capslock_widget.png?raw=true)

when CAPS LOCK is inactive, a lowecase letter **a** will be displayed:

![inactive_capslock screenshot](/screenshots/inactive_capslock_widget.png?raw=true)

These can be changed by changing the `activated` and `deactivated`
attributes of the widget
as
[Pango markup](https://developer.gnome.org/pango/stable/PangoMarkupFormat.html)
strings. You will probably need to adjust the `forced_width` attribute too.

For example:

``` lua
local capslock = require("capslock")
capslock.forced_width = 35
capslock.activated = "<u>CAPS</u>"
capslock.deactivated = "<u>caps</u>"
```

When the mouse is over the widget, a tooltip that says `Caps Lock on`/`Caps
Lock off` is also shown.

# Contributing

If you have ideas about how to make this better, feel free to open an issue or
submit a pull request.
