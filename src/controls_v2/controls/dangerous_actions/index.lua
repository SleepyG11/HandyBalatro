Handy.load_file("src/controls_v2/controls/dangerous_actions/logic.lua")

-- One-by-one
Handy.controls_v2.register("dangerous_actions_sell_one", {
	get_module = function()
		return Handy.cc.dangerous_actions_sell_one
	end,

	context_type = {
		input = true,
		card = true,
	},

	require_exact_keys = true,

	dangerous = true,
	no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,
	in_run = true,
	no_stop_use = true,

	can_execute = function(...)
		return Handy.dangerous_actions.can_execute(false, false, false, ...)
	end,
	execute = function(...)
		return Handy.dangerous_actions.execute(false, false, false, ...)
	end,
})
Handy.controls_v2.register("dangerous_actions_remove_one", {
	get_module = function()
		return Handy.cc.dangerous_actions_remove_one
	end,

	context_type = {
		input = true,
		card = true,
		tag = true,
	},

	require_exact_keys = true,

	dangerous = true,
	no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,
	in_run = true,
	no_stop_use = true,

	can_execute = function(...)
		return Handy.dangerous_actions.can_execute(true, false, false, ...)
	end,
	execute = function(...)
		return Handy.dangerous_actions.execute(true, false, false, ...)
	end,
})

-- All same
Handy.controls_v2.register("dangerous_actions_sell_all_same", {
	get_module = function()
		return Handy.cc.dangerous_actions_sell_all_same
	end,

	context_type = {
		input = true,
		card = true,
	},

	require_exact_keys = true,

	dangerous = true,
	no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,
	in_run = true,
	no_stop_use = true,

	can_execute = function(...)
		return Handy.dangerous_actions.can_execute(false, true, false, ...)
	end,
	execute = function(...)
		return Handy.dangerous_actions.execute(false, true, false, ...)
	end,
})
Handy.controls_v2.register("dangerous_actions_remove_all_same", {
	get_module = function()
		return Handy.cc.dangerous_actions_remove_all_same
	end,

	context_type = {
		input = true,
		card = true,
		tag = true,
	},

	require_exact_keys = true,

	dangerous = true,
	no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,
	in_run = true,
	no_stop_use = true,

	can_execute = function(...)
		return Handy.dangerous_actions.can_execute(true, true, false, ...)
	end,
	execute = function(...)
		return Handy.dangerous_actions.execute(true, true, false, ...)
	end,
})

-- All
Handy.controls_v2.register("dangerous_actions_sell_all", {
	get_module = function()
		return Handy.cc.dangerous_actions_sell_all
	end,

	context_type = {
		input = true,
		card = true,
	},

	require_exact_keys = true,

	dangerous = true,
	no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,
	in_run = true,
	no_stop_use = true,

	can_execute = function(...)
		return Handy.dangerous_actions.can_execute(false, false, true, ...)
	end,
	execute = function(...)
		return Handy.dangerous_actions.execute(false, false, true, ...)
	end,
})
Handy.controls_v2.register("dangerous_actions_remove_all", {
	get_module = function()
		return Handy.cc.dangerous_actions_remove_all
	end,

	context_type = {
		input = true,
		card = true,
		tag = true,
	},

	require_exact_keys = true,

	dangerous = true,
	no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,
	in_run = true,
	no_stop_use = true,

	can_execute = function(...)
		return Handy.dangerous_actions.can_execute(true, false, true, ...)
	end,
	execute = function(...)
		return Handy.dangerous_actions.execute(true, false, true, ...)
	end,
})

local items = {
	"dangerous_actions_sell_one",
	"dangerous_actions_remove_one",
	"dangerous_actions_sell_all_same",
	"dangerous_actions_remove_all_same",
	"dangerous_actions_sell_all",
	"dangerous_actions_remove_all",
}

Handy.e_mitter.on("update", function(dt)
	Handy.UI.state_panel.display(function(state)
		local holded = nil
		local append_queue = false
		if
			Handy.utils.alive_element(Handy.UI.data.dangerous_actions_preview_area)
			or (Handy.b_is_mod_active() and Handy.b_is_dangerous_actions_active() and Handy.b_is_in_run())
		then
			if not Handy.controller_v2.binding.get_current() then
				for index, item_key in ipairs(items) do
					local item = Handy.controls_v2.dictionary[item_key]
					local module = item:get_module()
					if
						Handy.controls_v2.is_module_enabled(module)
						and Handy.controls_v2.is_module_keys_hold(module, {
							require_exact = true,
						})
					then
						holded = item
						if index < 3 then
							append_queue = true
						end
						break
					end
				end
			end
		end
		if holded then
			if not Handy.cc.dangerous_actions.enabled then
				state.items.prevented_dangerous_actions = {
					text = Handy.L.dictionary("ph_handy_notif_unsafe_disabled"),
					hold = false,
					order = 99999999,
				}
				return true
			elseif not Handy.b_is_dangerous_actions_active() then
				state.items.prevented_dangerous_actions = {
					text = Handy.L.dictionary("ph_handy_notif_unsafe_disabled_by_other_mod"),
					hold = false,
					order = 99999999,
				}
				return true
			else
				local text = Handy.L.dictionary("ph_handy_" .. holded.key)
				local queue = Handy.utils.alive_element(Handy.UI.data.dangerous_actions_preview_area)
						and Handy.dangerous_actions.preview_sell_queue
					or Handy.dangerous_actions.sell_queue

				if append_queue then
					text = text .. " " .. Handy.L.variable("Handy_items_in_queue", {
						#queue,
					})
				end
				state.items.dangerous_actions = {
					text = text,
					hold = true,
					order = 11,
					dangerous = true,
					level = 2,
				}
				state.items.dangerous_hint = {
					text = Handy.L.dictionary("ph_handy_notif_unsafe"),
					dangerous = true,
					hold = true,
					order = 99999999,
					level = 2,
				}
				return true
			end
		elseif state.items.dangerous_actions and state.items.dangerous_actions.hold then
			state.items.dangerous_actions.hold = false
			state.items.dangerous_hint.hold = false
			return true
		end
	end, nil, 2)
end)

---

Handy.controls_v2.register("dangerous_actions_crash", {
	get_module = function()
		return Handy.cc.dangerous_actions_crash
	end,

	context_type = {
		input = true,
	},

	trigger = "trigger",

	dangerous = true,
	only_safe = true,
	no_mp = true,
	require_exact_keys = true,

	execute = function()
		local key_1, key_2 = "keys_1", "keys_2"
		if Handy.controller_v2.is_gamepad() then
			key_1, key_2 = "keys_1_gamepad", "keys_2_gamepad"
		end
		error(
			'Crashed by "Crash a game" keybind in Handy v'
				.. Handy.version
				.. " ("
				.. Handy.L.brackets(Handy.L.keys(Handy.cc.dangerous_actions_crash[key_1]))
				.. " or "
				.. Handy.L.brackets(Handy.L.keys(Handy.cc.dangerous_actions_crash[key_2]))
				.. ")"
		)
		return true
	end,
})
