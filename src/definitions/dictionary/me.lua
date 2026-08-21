Handy.API.Dictionary({
	key = "me",
	order = 4,

	keywords = { "me sleepy sleepyg11 g11 sprite girl tyan anime self insert author" },
	loc_vars = function()
		return {
			vars = { "@lord.ruby" },
		}
	end,
})

Handy.API.Dictionary({
	key = "me_in_mod_config",
	parent = "me",
	order = 1,

	get_module = function()
		return Handy.cc.me_in_mod_config
	end,

	checkbox = true,
})
Handy.API.Dictionary({
	key = "me_in_game_over",
	parent = "me",
	order = 2,

	get_module = function()
		return Handy.cc.me_in_game_over
	end,

	checkbox = true,
})
Handy.API.Dictionary({
	key = "me_in_game_win",
	parent = "me",
	order = 3,

	get_module = function()
		return Handy.cc.me_in_game_win
	end,

	checkbox = true,
})
Handy.API.Dictionary({
	key = "me_in_screenswipe",
	parent = "me",
	order = 4,

	get_module = function()
		return Handy.cc.me_in_screenswipe
	end,

	checkbox = true,
})
