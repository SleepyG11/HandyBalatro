--- @meta

Handy.API = {}

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

---Definition of control which executes action on user inputs or game updates
---@class Handy.Control
---@field key string Unique identifier. *NOT* prefixed by default.
---@field get_module? fun(self: Handy.Control): Handy.Config Config to use for check can control be executed by checking enabled status and/or keybinds
---@field get_deps? fun(self: Handy.Control): Handy.Config[] | nil List of configs which needs to be active before control can be executed
---@field contexts? table<Handy.AnyContextFlag, boolean> Types of contexts to trigger on
---@field allow_back_input? boolean Allow "back" buttons ([Escape] and [(Start)])
---@field only_safe_input? boolean Prevent "not safe" buttons (buttons which required to move between menus, such as mouse and gamepad buttons)
---@field only_holdable_input? boolean Prevent non-holdable buttons ([Wheel Up] and [Wheel Down])
---@field require_exact_keys_input? boolean Prevent executing if any other keybind which is not in combination pressed
---@field allow_mod_inactive? boolean Allow executing even if mod disabled
---@field allow_any_context? boolean Allow executing on any context (skips any context checks)
---@field allow_disabled? boolean Allow executing even if config/module disabled
---@field only_in_run? boolean Prevent executing if player isn't in game state or game is paused (checks for `G.STAGES.RUN` and not `G.SETTINGS.paused`)
---@field no_stop_use? boolean Prevent executing if player cannot do actions right now (checks `G.GAME.STOP_USE` and G.CONTROLLER.locked)
---@field dangerous? boolean Prevent executing if [Dangerous actions] cannot be executed right now
---@field no_mp? boolean | fun(self: Handy.Control, lobby: table, config: table): boolean Check for Multiplayer. If returned `true`, control will not be executed in MP lobby
---@field can_execute? fun(self: Handy.Control, ctx: Handy.AnyContext, args: table): boolean, any Check can control be executed. As second return, data can be passed to `execute`
---@field execute? fun(self: Handy.Control, ctx: Handy.AnyContext, args: table, data: any): boolean Control logic execution. Returned boolean indicated is execution was successful. `data` is value passed by `can_execute`
---@field update? fun(self: Handy.Control, dt: number) Update function. Runs every frame regardless of game state or control checks

--- Add control - object which executes actions on user inputs or game updates.
--- @param args Handy.Control | table
--- @return Handy.Control
function Handy.API.Control(args) end

--- Add stack layer - objects which determines in which conditions and order each control fires.
function Handy.API.Stack(args) end

--- Add dictionary entry - object which represents configuration.<br/>
--- * Resolves and displays all info from localization file
--- * Resolves keywords to became searchable in "Search" tab
--- * Resolves mod dependencies
--- * Provides all info and handling for creating config UI parts (checkboxes, option cycles, sliders, keybinds)
function Handy.API.Dictionary(args) end
