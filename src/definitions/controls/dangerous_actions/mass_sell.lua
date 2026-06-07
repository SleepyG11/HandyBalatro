-- One-by-one
Handy.controls.register({
	key = "dangerous_actions_sell_one",
	get_module = function()
		return Handy.cc.dangerous_actions_sell_one
	end,

	contexts = {
		input = true,
		card = true,
	},

	require_exact_keys_input = true,

	dangerous = true,
	no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,
	only_in_run = true,
	no_stop_use = true,

	can_execute = Handy.dangerous_actions.create_can_execute(false, false, false),
	execute = Handy.dangerous_actions.create_execute(false, false, false),
})
Handy.controls.register({
	key = "dangerous_actions_remove_one",
	get_module = function()
		return Handy.cc.dangerous_actions_remove_one
	end,

	contexts = {
		input = true,
		card = true,
		tag = true,
	},

	require_exact_keys_input = true,

	dangerous = true,
	no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,
	only_in_run = true,
	no_stop_use = true,

	can_execute = Handy.dangerous_actions.create_can_execute(true, false, false),
	execute = Handy.dangerous_actions.create_execute(true, false, false),
})

-- All same
Handy.controls.register({
	key = "dangerous_actions_sell_all_same",
	get_module = function()
		return Handy.cc.dangerous_actions_sell_all_same
	end,

	contexts = {
		input = true,
		card = true,
	},

	require_exact_keys_input = true,

	dangerous = true,
	no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,
	only_in_run = true,
	no_stop_use = true,

	can_execute = Handy.dangerous_actions.create_can_execute(false, true, false),
	execute = Handy.dangerous_actions.create_execute(false, true, false),
})
Handy.controls.register({
	key = "dangerous_actions_remove_all_same",
	get_module = function()
		return Handy.cc.dangerous_actions_remove_all_same
	end,

	contexts = {
		input = true,
		card = true,
		tag = true,
	},

	require_exact_keys_input = true,

	dangerous = true,
	no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,
	only_in_run = true,
	no_stop_use = true,

	can_execute = Handy.dangerous_actions.create_can_execute(true, true, false),
	execute = Handy.dangerous_actions.create_execute(true, true, false),
})

-- All
Handy.controls.register({
	key = "dangerous_actions_sell_all",
	get_module = function()
		return Handy.cc.dangerous_actions_sell_all
	end,

	contexts = {
		input = true,
		card = true,
	},

	require_exact_keys_input = true,

	dangerous = true,
	no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,
	only_in_run = true,
	no_stop_use = true,

	can_execute = Handy.dangerous_actions.create_can_execute(false, false, true),
	execute = Handy.dangerous_actions.create_execute(false, false, true),
})
Handy.controls.register({
	key = "dangerous_actions_remove_all",
	get_module = function()
		return Handy.cc.dangerous_actions_remove_all
	end,

	contexts = {
		input = true,
		card = true,
		tag = true,
	},

	require_exact_keys_input = true,

	dangerous = true,
	no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,
	only_in_run = true,
	no_stop_use = true,

	can_execute = Handy.dangerous_actions.create_can_execute(true, false, true),
	execute = Handy.dangerous_actions.create_execute(true, false, true),
})
