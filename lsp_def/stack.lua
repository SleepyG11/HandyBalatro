--- @meta

---@alias Handy.StackOperator
---| "free"
---| "all"
---| "none"
---| "while"
---| "until"

---@class Handy.Stack
---@field key string
---@field full_key string
---@field control? string
---@field parent Handy.Stack
---@field operator Handy.StackOperator
---@field order number
---@field global? boolean
---@field items Handy.Stack[]

---@class Handy.CreateStackArgs
---@field key? string
---@field control? boolean | string
---@field parent? Handy.Stack | string
---@field operator? Handy.StackOperator
---@field order? number
---@field global? boolean

--- Add stack layer - objects which determines in which conditions and order each control fires.
--- @param args Handy.CreateStackArgs | table
--- @return Handy.Stack
function Handy.API.Stack(args) end
