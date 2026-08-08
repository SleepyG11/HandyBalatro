--- @meta

---@alias Handy.ModuleOverrideProcessor fun(module: Handy.Config): Handy.Config | nil

---@class Handy.ModuleOverride
---@field key string Unique identifier. *NOT* prefixed by default.
---@field order? number
---@field get_module? fun(self: Handy.ModuleOverride): Handy.Config | nil Module to apply override on
---@field func? fun(self: Handy.ModuleOverride, module: Handy.Config, continue: Handy.ModuleOverrideProcessor): Handy.Config | nil Apply override to module

---@class Handy.CreateModuleOverrideArgs: Handy.ModuleOverride

--- Create module override - a way to conditionally extending and/or overriding config entry before processing
--- Can be used to disable enrite mod modules or force specific keybinds on controls
--- @param args Handy.CreateModuleOverrideArgs | table
--- @return Handy.ModuleOverride
function Handy.API.ModuleOverride(args) end
