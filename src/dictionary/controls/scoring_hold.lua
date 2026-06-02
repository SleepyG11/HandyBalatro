Handy.dictionary.register({
	key = "scoring_hold",
	order = 12,

	keywords = { "scoring hold", "pause stop animations before during scoring" },
	get_module = function(self)
		return Handy.cc.scoring_hold
	end,
	no_mp = true,

	checkbox = true,
	keybind = {
		allow_multiple = "advanced",
		only_holdable = true,
	},
})

Handy.dictionary.register({
	key = "scoring_hold_any_moment",
	parent = "scoring_hold",
	order = 1,

	keywords = { "pause any moment" },
	get_module = function(self)
		return Handy.cc.scoring_hold_any_moment
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	checkbox = true,
})
