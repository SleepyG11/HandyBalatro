Handy.controls.register({
	key = "scoring_hold",
	get_module = function()
		return Handy.cc.scoring_hold
	end,

	only_holdable_input = true,
	no_mp = true,
	only_in_run = true,

	-- TODO: use hold context
	update = function(self, dt)
		local t = Handy.scoring_hold.update_values(self)

		if t.is_hold and t.is_hand_played and Handy.controls.is_module_enabled(Handy.cc.scoring_hold_any_moment) then
			Handy.scoring_hold.create_hold_event(true, t.preview)
		end

		Handy.scoring_hold.show_notif(t)
	end,
})
