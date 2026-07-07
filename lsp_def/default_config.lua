--- @meta

---Config/Module which holds keys and variables for control
---@class Handy.Config
---@field enabled boolean Is current module enabled (can be adjusted by `checkbox`)
---@field keys_1? string[] Conbination [1] of keys assigned to this control on Mouse + Keyboard input device (can be adjusted by `keybind`)
---@field keys_2? string[] Conbination [2] of keys assigned to this control on Mouse + Keyboard input device (can be adjusted by `keybind`)
---@field keys_1_gamepad? string[] Conbination [1] of keys assigned to this control on Gamepad input device (can be adjusted by `keybind`)
---@field keys_2_gamepad? string[] Conbination [2] of keys assigned to this control on Gamepad input device (can be adjusted by `keybind`)
---@field value? number Numerical value (can be adjusted by `option_cycle` or `slider`)

--- Extend default config
--- @param config table<string, Handy.Config>
function Handy.API.DefaultConfig(config) end
