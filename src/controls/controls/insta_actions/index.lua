Handy.load_files({
	"logic.lua",
}, "src/controls/controls/insta_actions/")

Handy.controls.register("insta_actions", {
	get_module = function()
		return Handy.cc.insta_actions
	end,

	context_types = {
		input = true,
		card = true,
	},

	trigger = "trigger",

	can_execute = Handy.insta_actions.can_execute,
	execute = Handy.insta_actions.execute,

	update = function(self, dt)
		if
			not (
				Handy.b_is_mod_active()
				and Handy.b_is_in_run()
				and Handy.controller.key_states.get_hold_size() > 0
				and Handy.controls.is_module_enabled(Handy.cc.insta_actions)
			)
		then
			return
		end

		local is_alt_mode = Handy.controller.is_gamepad() or trigger_mode == 2
		if is_alt_mode then
			return
		end

		Handy.insta_actions.show_notif(Handy.insta_actions.get_actions())
	end,
})
