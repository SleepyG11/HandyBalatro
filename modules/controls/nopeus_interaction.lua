Handy.nopeus_interaction = {
	is_present = function()
		return type(Nopeus) == "table"
	end,

	get_actions = function(key)
		return {
			increase = Handy.controller.is_module_key(Handy.cc.nopeus_interaction.increase, key),
			decrease = Handy.controller.is_module_key(Handy.cc.nopeus_interaction.decrease, key),
		}
	end,

	can_dangerous = function()
		return not not (
			Handy.is_dangerous_actions_active()
			and Handy.controller.is_module_enabled(Handy.cc.dangerous_actions.nopeus_unsafe)
		)
	end,
	can_execute = function(key)
		return not not (
			Handy.nopeus_interaction.is_present()
			and Handy.controller.is_module_enabled(Handy.cc.nopeus_interaction)
			and not Handy.is_in_multiplayer()
			and (
				Handy.controller.is_module_enabled(Handy.cc.nopeus_interaction.no_hold)
				or Handy.controller.is_module_key_down(Handy.cc.nopeus_interaction)
			)
		)
	end,
	execute = function(key)
		local actions = Handy.nopeus_interaction.get_actions(key)
		if actions.increase then
			Handy.nopeus_interaction.increase()
			Handy.nopeus_interaction.show_notif(key)
			return not Handy.controller.is_module_enabled(Handy.cc.nopeus_interaction.no_hold)
		end
		if actions.decrease then
			Handy.nopeus_interaction.decrease()
			Handy.nopeus_interaction.show_notif(key)
			return not Handy.controller.is_module_enabled(Handy.cc.nopeus_interaction.no_hold)
		end
		return false
	end,

	show_notif = function(key)
		if not Handy.nopeus_interaction.is_present() then
			return
		end
		Handy.UI.state_panel.display(function(state)
			local actions = Handy.nopeus_interaction.get_actions(key)

			if actions.increase or actions.decrease then
				local states = {
					Nopeus.Off,
					Nopeus.Planets,
					Nopeus.On,
					Nopeus.Unsafe,
				}
				if Nopeus.Optimised then
					states = {
						Nopeus.Off,
						Nopeus.Planets,
						Nopeus.On,
						Nopeus.Optimised,
						Nopeus.Unsafe,
					}
				end

				local is_dangerous = G.SETTINGS.FASTFORWARD == (#states - 1)

				if is_dangerous then
					if Handy.cc.notifications_level < 2 then
						return false
					end
				else
					if Handy.cc.notifications_level < 3 then
						return false
					end
				end

				state.items.change_nopeus_fastforward = {
					text = localize({
						type = "variable",
						key = "Handy_nopeus_fastforward",
						vars = { states[(G.SETTINGS.FASTFORWARD or 0) + 1] },
					}),
					hold = false,
					order = 4,
					dangerous = is_dangerous,
				}
				if
					not Handy.nopeus_interaction.can_dangerous()
					and actions.increase
					and G.SETTINGS.FASTFORWARD == (#states - 2)
				then
					state.items.prevent_nopeus_unsafe = {
						text = localize("ph_handy_notif_nopeus_unsafe_disabled"),
						hold = false,
						order = 4.05,
					}
				end
				return true
			end
			return false
		end)
	end,

	change = function(dx)
		if not Handy.nopeus_interaction.is_present() then
			G.SETTINGS.FASTFORWARD = 0
		else
			local increment = Nopeus.Optimised and 1 or 0
			if G.SETTINGS.FASTFORWARD == (3 + increment) and dx > 0 then
				-- It's already unsafe, so leave it as it is
			else
				G.SETTINGS.FASTFORWARD = math.min(
					(Handy.nopeus_interaction.can_dangerous() and 3 or 2) + increment,
					math.max(0, (G.SETTINGS.FASTFORWARD or 0) + dx)
				)
			end
		end
	end,
	increase = function()
		Handy.nopeus_interaction.change(1)
	end,
	decrease = function()
		Handy.nopeus_interaction.change(-1)
	end,

	use = function(key)
		return Handy.nopeus_interaction.can_execute(key) and Handy.nopeus_interaction.execute(key) or false
	end,
}

Handy.register_module("nopeus_interaction", Handy.nopeus_interaction)
