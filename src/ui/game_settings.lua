function Handy.UI.settings_speed_multiplier()
	if
		Handy.b_is_mod_active()
		and not Handy.disabled_in_mp_check(Handy.speed_multiplier.is_disabled_by_mp)
		and Handy.controls.is_module_enabled(Handy.cc.speed_multiplier)
		and Handy.controls.is_module_enabled(Handy.cc.speed_multiplier_settings_toggle)
	then
		return {
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					config = {},
					nodes = {
						create_toggle({
							scale = 0.65,
							ref_table = setmetatable({}, {
								__index = function()
									return not Handy.speed_multiplier.temp_disabled
								end,
							}),
							ref_value = "temp_disabled",
							label = "",
							w = 0,
							label_scale = 0,
							callback = function(b)
								Handy.speed_multiplier.toggle_temp_disabled(not b)
							end,
						}),
					},
				},
				{
					n = G.UIT.C,
					config = {},
					nodes = {
						Handy.UI.CP.settings_simple_option_cycle(Handy.D.dictionary.speed_multiplier_current_value),
					},
				},
				Handy.UI.CP.c_sep(0.8),
			},
		}
	end
end
function Handy.UI.settings_animation_skip()
	if
		Handy.b_is_mod_active()
		and not Handy.disabled_in_mp_check(Handy.animation_skip.is_disabled_by_mp)
		and Handy.controls.is_module_enabled(Handy.cc.animation_skip)
		and Handy.controls.is_module_enabled(Handy.cc.animation_skip_settings_toggle)
	then
		return {
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = {
						create_toggle({
							scale = 0.65,
							ref_table = setmetatable({}, {
								__index = function()
									return not Handy.animation_skip.temp_disabled
								end,
							}),
							ref_value = "temp_disabled",
							label = "",
							w = 0,
							label_scale = 0,
							callback = function(b)
								Handy.animation_skip.toggle_temp_disabled(not b)
							end,
						}),
					},
				},
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = {
						Handy.UI.CP.settings_simple_option_cycle(Handy.D.dictionary.animation_skip_current_value),
					},
				},
				Handy.UI.CP.c_sep(0.8),
			},
		}
	end
end
