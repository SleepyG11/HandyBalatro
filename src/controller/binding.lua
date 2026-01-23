Handy.controller.binding = setmetatable({
	current = nil,
}, {})

function Handy.controller.binding.update_keybind_button(text_type, enabled)
	local binding = Handy.controller.binding.current
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

function Handy.controller.binding.start_binding(args, element)
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
	Handy.controller.binding.current = binding

	Handy.controller.binding.update_keybind_button("old_brackets", false)
	Handy.controller.binding.update_binding_buttons_text()
end

function Handy.controller.binding.finish_binding()
	local binding = Handy.controller.binding.current
	if not binding then
		return
	end
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
	Handy.controller.binding.update_keybind_button("new", true)
	Handy.controller.binding.current = nil
end

function Handy.controller.binding.cancel_binding(reason)
	local binding = Handy.controller.binding.current
	if not binding then
		return
	end

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
	Handy.controller.binding.update_keybind_button("new", true)
	Handy.controller.binding.current = nil
end

function Handy.controller.binding.update_binding_buttons_text()
	local binding = Handy.controller.binding.current
	if not binding then
		return
	end
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

function Handy.controller.binding.process_binding(context)
	local binding = Handy.controller.binding.current
	if not binding or context.released then
		return
	end
	if context.back then
		-- User finished entering combination
		Handy.controller.binding.finish_binding()
	elseif binding.only_safe and not context.safe then
		-- Non-safe
		Handy.controller.binding.cancel_binding("no_safe")
	elseif binding.only_holdable and not context.holdable then
		-- Non-hold
		Handy.controller.binding.cancel_binding("no_hold")
	elseif binding.contains_non_holdable and not context.holdable then
		-- This keybind will be unusable since you cannot press 2 non-holdable buttons at the same time
		Handy.controller.binding.cancel_binding("multiple_no_hold")
	elseif binding.buttons_entered[context.key] then
		-- Button already in combination, skip
	else
		binding.contains_non_holdable = binding.contains_non_holdable or not context.holdable
		binding.buttons_entered[context.key] = true
		table.insert(binding.buttons, context.key)
		Handy.utils.sort_keys(binding.buttons)
		-- Update entered buttons display
		if
			binding.allow_multiple
			-- or (binding.allow_multiple == "advanced" and Handy.cc.advanced_mode.enabled)
		then
			Handy.controller.binding.update_binding_buttons_text()
			-- Wait for cancel or finish by back key
		else
			-- Single button was inserted, finish
			Handy.controller.binding.finish_binding()
		end
	end
	Handy.controller.prevent_default()
	Handy.controller.stop_immediate_propagation()
end
