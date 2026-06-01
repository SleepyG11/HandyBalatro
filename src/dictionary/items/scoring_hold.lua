Handy.dictionary.register({
	key = "scoring_hold",
	keywords = { "scoring hold", "pause stop animations before during scoring" },
	get_module = function(self)
		return Handy.cc.scoring_hold
	end,
	checkbox = true,
	no_mp = true,
	keybind = {
		allow_multiple = "advanced",
		only_holdable = true,
	},

	items = {
		{
			key = "scoring_hold_any_moment",
			keywords = { "pause any moment" },
			get_module = function(self)
				return Handy.cc.scoring_hold_any_moment, { Handy.D.dictionary.scoring_hold }
			end,
			checkbox = true,
		},
	},
})
