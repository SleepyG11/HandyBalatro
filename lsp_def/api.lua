--- @meta

Handy.API = {}

--- Extend default config
--- @param config any
function Handy.API.DefaultConfig(config) end

--- Add control - object which executes actions on user inputs or game updates.<br/>
function Handy.API.Control(args) end

--- Add stack layer - objects which determines in which conditions and order each control fires.<br/>
function Handy.API.Stack(args) end

--- Add dictionary entry - object which represents configuration.<br/>
--- * Resolves and displays all info from localization file
--- * Resolves keywords to became searchable in "Search" tab
--- * Resolves mod dependencies
--- * Provides all info and handling for creating config UI parts (checkboxes, option cycles, sliders, keybinds)
function Handy.API.Dictionary(args) end
