local current_binding = nil

local function get_binding()
	return current_binding
end
local function set_binding(b)
	current_binding = b
	return b
end

local function update_keybind_button(text_type, enabled)
	local binding = get_binding()
	if binding and binding.element then
		local button_text = binding.element.children[1]
		button_text.config.text_drawable = nil
		if text_type == "old_brackets" then
			button_text.config.text = Handy.L.brackets(button_text.config.text)
		elseif text_type == "new" then
			button_text.config.text = Handy.L.keys(binding.module[binding.key])
		end
		button_text:update_text()
		button_text.UIBox:recalculate()
		binding.element.config.button = enabled and "handy_start_binding" or "handy_noop"
	end
end
local function update_binding_buttons_text()
	local binding = get_binding()
	if binding then
		binding.buttons_entered_text = Handy.L.brackets(Handy.L.keys(binding.buttons))
		Handy.UI.state_panel.display(function(state)
			state.items.binding = {
				text = Handy.L.variable("Handy_binding_progress", { binding.buttons_entered_text }),
				hold = true,
				order = 0,
			}
			state.items.binding_guide = {
				text = Handy.L.variable("Handy_binding_guide"),
				hold = false,
				order = 0.05,
			}
			local save_key = Handy.controller.is_gamepad() and "(Back)" or "Escape"
			state.items.binding_cancel = {
				text = Handy.L.variable("Handy_binding_esc_hint", { Handy.L.brackets(Handy.L.keys(save_key)) }),
				hold = false,
				order = 0.1,
			}
			return true
		end, "override")
	end
end

local function start_binding(args, element)
	args = args or {}

	local binding = {
		-- Module we're set keybind on (ref_table)
		module = args.module,
		-- Key we're updating (ref_value)
		key = args.key,

		-- Allow assign combination of keybinds here
		allow_multiple = args.allow_multiple or false,
		-- Allow only safe keybinds (so user will not softlock youself by assigning crash on left click)
		only_safe = args.only_safe or false,
		-- Allow only holdable keybinds (in case when control require a button which user can hold, wheel for example cannot be holded)
		only_holdable = args.only_holdable or false,

		-- Call UI when finished
		rerender = args.rerender or false,

		-- Button we entered so far
		buttons = {},
		buttons_entered = {},
		buttons_entered_text = "",

		hold_duration = args.module.hold_duration or 0,

		element = element,
	}

	set_binding(binding)

	update_keybind_button("old_brackets", false)
	update_binding_buttons_text()
end
local function cancel_binding(reason)
	local binding = get_binding()
	if binding then
		Handy.UI.state_panel.display(function(state)
			state.items.binding = {
				text = Handy.L.variable("Handy_binding_canceled"),
				hold = false,
				order = 0,
			}
			if reason then
				local context = Handy.controller.get_input_context()
				state.items.binding_cancel = {
					text = Handy.L.variable(
						"Handy_binding_cancel_reason_" .. reason,
						{ Handy.L.brackets(Handy.L.keys(context.key)) }
					),
					hold = false,
					order = 0.1,
				}
			end
			return true
		end, "override")

		update_keybind_button("new", true)
		set_binding(nil)
	end
end
local function finish_binding()
	local binding = get_binding()
	if binding then
		binding.buttons_entered_text = Handy.L.brackets(Handy.L.keys(binding.buttons))
		binding.module[binding.key] = binding.buttons
		Handy.config.request_save()

		Handy.UI.state_panel.display(function(state)
			state.items.binding = {
				text = Handy.L.variable("Handy_binding_finished", { binding.buttons_entered_text }),
				hold = false,
				order = 0,
			}
			return true
		end, "override")

		update_keybind_button("new", true)
		set_binding(nil)
	end
end

local function process_binding(ctx)
	local binding = get_binding()
	if not binding or not ctx.input or not ctx.press then
		return
	end
	if ctx.back then
		-- User finished entering combination
		finish_binding()
	elseif binding.only_safe and not ctx.safe then
		-- Non-safe
		cancel_binding("no_safe")
	elseif binding.only_holdable and not ctx.holdable then
		-- Non-hold
		cancel_binding("no_hold")
	elseif binding.contains_non_holdable and not ctx.holdable then
		-- This keybind will be unusable since you cannot press 2 non-holdable buttons at the same time
		cancel_binding("multiple_no_hold")
	elseif binding.buttons_entered[ctx.key] then
		-- Button already in combination, skip
	else
		binding.contains_non_holdable = binding.contains_non_holdable or not ctx.holdable
		binding.buttons_entered[ctx.key] = true
		table.insert(binding.buttons, ctx.key)
		Handy.utils.sort_keys(binding.buttons)
		-- Update entered buttons display
		if
			binding.allow_multiple
			-- or (binding.allow_multiple == "advanced" and Handy.cc.advanced_mode.enabled)
		then
			update_binding_buttons_text()
			-- Wait for cancel or finish by back key
		else
			-- Single button was inserted, finish
			finish_binding()
		end
	end
	ctx:prevent_default()
	ctx:stop_propagation()
end

---

local binding = {
	get_current = get_binding,
	set_current = set_binding,

	process_binding = process_binding,

	start_binding = start_binding,
	cancel_binding = cancel_binding,
	finish_binding = finish_binding,
}

Handy.controller_v2.binding = binding
