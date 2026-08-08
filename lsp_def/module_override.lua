--- @meta

---@alias Handy.ModuleOverrideProcessor fun(module: Handy.Config): Handy.Config | nil

---@class Handy.ModuleOverride
---@field key string Unique identifier. *NOT* prefixed by default.
---@field order? number
---@field get_module? fun(self: Handy.ModuleOverride): Handy.Config | nil
---@field func? fun(self: Handy.ModuleOverride, module: Handy.Config, continue: Handy.ModuleOverrideProcessor): Handy.Config | nil

---@class Handy.CreateModuleOverrideArgs: Handy.ModuleOverride

--- @param args Handy.CreateModuleOverrideArgs | table
--- @return Handy.ModuleOverride
function Handy.API.ModuleOverride(args) end
