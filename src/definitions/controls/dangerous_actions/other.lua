Handy.controls.register({
	key = "dangerous_actions_crash",
	get_module = function()
		return Handy.cc.dangerous_actions_crash
	end,

	contexts = {
		input_trigger = true,
	},

	dangerous = true,
	only_safe_input = true,
	no_mp = true,
	require_exact_keys = true,

	execute = function()
		local key_1, key_2 = "keys_1", "keys_2"
		if Handy.controller.is_gamepad() then
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
Handy.controls.register({
	key = "dangerous_actions_stack_overflow",
	get_module = function()
		return Handy.cc.dangerous_actions_stack_overflow
	end,

	contexts = {
		input_trigger = true,
	},

	dangerous = true,
	only_safe_input = true,
	no_mp = true,
	require_exact_keys = true,

	execute = function()
		local t = {
			a = 1,
		}
		t.b = t
		Handy.utils.table_merge(t, t)
		return true
	end,
})
