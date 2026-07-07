---@meta

---@class Handy.PreventableContext: Object
---@field default_prevented boolean
---@field propagation_stopped boolean
---@field prevent_default fun(self: Handy.PreventableContext)
---@field stop_propagation fun(self: Handy.PreventableContext)
---@field is_empty fun(self: Handy.PreventableContext): boolean
---@field none? boolean

--------------------------------

---@alias Handy.InputType
---| "mouse"
---| "keyboard"
---| "wheel"
---| "gamepad"
---| "touch"
---| "none"

---@alias Handy.InputAction
---| "press"
---| "release"
---| "none"

---@alias Handy.InputContextFlag
---| "input_press"
---| "input_release"
---| "input_trigger"
---| "input_mouse"
---| "input_press_mouse"
---| "input_release_mouse"
---| "input_trigger_mouse"
---| "input_keyboard"
---| "input_press_keyboard"
---| "input_release_keyboard"
---| "input_trigger_keyboard"
---| "input_wheel"
---| "input_press_wheel"
---| "input_trigger_wheel"
---| "input_gamepad"
---| "input_press_gamepad"
---| "input_release_gamepad"
---| "input_trigger_gamepad"
---| "input_touch"
---| "input_press_touch"
---| "input_release_touch"
---| "input_trigger_touch"

---@class Handy.InputContext: Handy.PreventableContext, table<Handy.InputContextFlag | Handy.InputType | Handy.InputAction, boolean>
---@field type "input"
---@field input true
---@field raw_key string
---@field key Handy.ButtonKey
---@field input_type Handy.InputType
---@field action Handy.InputAction
---@field trigger boolean Is action alignes with selected trigger mode
---@field hold_duration number How long pressed button is held
---@field real_hold_duration number How long pressed button is held (excluding time in pause)
---@field back boolean Is pressed key a Back key ([Escape] or [(Start)])
---@field safe boolean Is pressed key a safe key (non-safe keys are keys which considered essential for moving in game's UI, such as [Left Mouse] or gamepad buttons)
---@field holdable boolean Is pressed key can be holded ([Wheel Up] and [Wheel Down] cannot be holded)

--------------------------------

---@alias Handy.CardAction
---| "hover"
---| "stop_hover"
---| "click"
---| "stop_click"
---| "none"

---@alias Handy.CardContextFlag
---| "card_hover"
---| "card_stop_hover"
---| "card_click"
---| "card_stop_click"
---| "none"

---@class Handy.CardContext: Handy.PreventableContext, table<Handy.CardContextFlag | Handy.CardAction, boolean>
---@field type "card"
---@field card true
---@field target Card
---@field action Handy.CardAction
---@field hovered_current? Card
---@field hovered_previous? Card
---@field clicked_current? Card
---@field clicked_previous? Card

--------------------------------

---@alias Handy.TagAction
---| "hover"
---| "stop_hover"
---| "click"
---| "stop_click"
---| "none"

---@alias Handy.TagContextFlag
---| "tag_hover"
---| "tag_stop_hover"
---| "tag_click"
---| "tag_stop_click"

---@class Handy.TagContext: Handy.PreventableContext, table<Handy.TagContextFlag | Handy.TagAction, boolean>
---@field type "tag"
---@field tag true
---@field target Tag
---@field action Handy.TagAction
---@field hovered_current? Tag
---@field hovered_previous? Tag
---@field clicked_current? Tag
---@field clicked_previous? Tag

--------------------------------

---@class Handy.HoldContext: Handy.PreventableContext
---@field type "hold"
---@field hold true
---@field dt number
---@field real_dt number 0 if game paused
---@field holded_size number Amount of keys hold
---@field keeped_alive boolean Indicated that context fired when all keys was released

--------------------------------

---@class Handy.MoveContext: Handy.PreventableContext
---@field type "move"
---@field move true
---@field dx number In pixels
---@field dy number In pixels
---@field sdx number In game units (scaled)
---@field sdy number In game units (scaled)

--------------------------------

---@alias Handy.AnyContextFlag
---| "input"
---| "card"
---| "tag"
---| "hold"
---| "move"
---| Handy.InputContextFlag
---| Handy.CardContextFlag
---| Handy.TagContextFlag

---@alias Handy.AnyContext
---| Handy.InputContext
---| Handy.CardContext
---| Handy.TagContext
---| Handy.HoldContext
---| Handy.MoveContext
