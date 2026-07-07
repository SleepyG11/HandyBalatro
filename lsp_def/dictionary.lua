---@meta

---@class Handy.DictionaryCheckboxArgs
---@field colour? table
---@field callback? fun()
---@field get_values? fun(self: Handy.DictionaryCheckboxArgs): { disabled?: boolean } | nil

---@class Handy.DictionaryKeybindArgs
---@field colour? table
---@field dangerous? boolean
---@field allow_multiple? boolean
---@field only_safe? boolean
---@field only_holdable? boolean
---@field get_values? fun(self: Handy.DictionaryKeybindArgs): { ref_table?: table, ref_value_1?: string, ref_value_2?: string, disabled?: boolean } | nil

---@class Handy.DictionarySimpleOptionCycleArgs
---@field colour? table
---@field left_callback? fun()
---@field right_callback? fun()
---@field get_values? fun(self: Handy.DictionarySimpleOptionCycleArgs): { ref_table?: table, ref_value?: string, disabled?: boolean } | nil

---@class Handy.DictionaryOptionCycleArgs
---@field colour? table
---@field callback? fun()
---@field get_values? fun(self: Handy.DictionaryOptionCycleArgs): { ref_table?: table, ref_value?: string, options: string[], current_option?: number, disabled?: boolean } | nil

---@class Handy.DictionarySliderArgs
---@field min? number
---@field max? number
---@field decimal_places? number
---@field callback? fun()
---@field colour? table
---@field get_values? fun(self: Handy.DictionarySliderArgs): { ref_table?: table, ref_value?: string, disabled?: boolean } | nil

---@class Handy.Dictionary
---@field key string
---@field order? number
---@field keywords? string[]
---@field get_module? fun(self: Handy.Dictionary): Handy.Config Config to use for check can control be executed by checking enabled status and/or keybinds
---@field get_deps? fun(self: Handy.Dictionary): Handy.Dictionary[] | nil List of configs which needs to be active before control can be executed
---@field checkbox? Handy.DictionaryCheckboxArgs
---@field keybind? Handy.DictionaryKeybindArgs
---@field option_cycle? Handy.DictionaryOptionCycleArgs
---@field simple_option_cycle? Handy.DictionaryCheckboxArgs
---@field slider? Handy.DictionarySliderArgs
---@field parent? Handy.Dictionary
---@field parents? Handy.Dictionary[]
---@field items? Handy.Dictionary[]

---@class Handy.CreateDictionaryArgs: Handy.Dictionary

--- Add dictionary entry - object which represents configuration.<br/>
--- * Resolves and displays all info from localization file
--- * Resolves keywords to became searchable in "Search" tab
--- * Resolves mod dependencies
--- * Provides all info and handling for creating config UI parts (checkboxes, option cycles, sliders, keybinds)
--- @param args Handy.CreateDictionaryArgs | table
--- @return Handy.Dictionary
function Handy.API.Dictionary(args) end
