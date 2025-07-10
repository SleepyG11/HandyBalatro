to_big = to_big or function(x)
	return x
end

if not Handy then
	Handy = setmetatable({
		version = "1.5.1c",

		last_clicked_area = nil,
		last_clicked_card = nil,

		last_hovered_area = nil,
		last_hovered_card = nil,

		modules = {},

		meta = {
			["1.4.1b_patched_select_blind_and_skip"] = true,
			["1.5.0_update"] = true,
			["1.5.1a_multiplayer_check"] = true,
		},
	}, {})

	function Handy.is_stop_use()
		return G.CONTROLLER.locked or G.CONTROLLER.locks.frame or (G.GAME and (G.GAME.STOP_USE or 0) > 0)
	end

	function Handy.is_in_multiplayer()
		return not not (MP and MP.LOBBY and MP.LOBBY.code)
	end

	function Handy.register_module(key, mod_module)
		Handy.modules[key] = mod_module
	end

	--

	require("handy/utils")
	require("handy/config")
	require("handy/fake_events")
	require("handy/controller")
	require("handy/ui")
	require("handy/presets")

	require("handy/controls/presets_switch")
	require("handy/controls/insta_cash_out")
	require("handy/controls/insta_booster_skip")
	require("handy/controls/deselect_hand")
	require("handy/controls/show_deck_preview")
	require("handy/controls/regular_keybinds")
	require("handy/controls/insta_highlight")
	require("handy/controls/insta_highlight_entire_f_hand")
	require("handy/controls/insta_actions")
	require("handy/controls/move_highlight")
	require("handy/controls/speed_multiplier")
	require("handy/controls/nopeus_interaction")
	require("handy/controls/not_just_yet_interaction")
	require("handy/controls/animation_skip")
	require("handy/controls/scoring_hold")

	require("handy/controls/dangerous_actions")

	require("handy/controls/misc")

	--

	local init_localization_ref = init_localization
	function init_localization(...)
		if not G.localization.__handy_injected then
			local en_loc = require("handy/localization/en-us")
			Handy.utils.table_merge(G.localization, en_loc)
			Handy.UI.cache_config_dictionary_search()
			if G.SETTINGS.language ~= "en-us" then
				local success, current_loc = pcall(function()
					return require("handy/localization/" .. G.SETTINGS.language)
				end)
				-- local missing_keys = Handy.utils.deep_missing_keys(en_loc, current_loc)
				-- for _, missing_key in ipairs(missing_keys) do
				-- 	print("Missing key: " .. missing_key)
				-- end
				if success and current_loc then
					Handy.utils.table_merge(G.localization, current_loc)
					Handy.UI.cache_config_dictionary_search(true)
				end
			end
			G.localization.__handy_injected = true
		end
		return init_localization_ref(...)
	end

	local card_area_emplace_ref = CardArea.emplace
	function CardArea:emplace(...)
		self.cards = self.cards or {}
		return card_area_emplace_ref(self, ...)
	end

	local card_area_align_cards_ref = CardArea.align_cards
	function CardArea:align_cards(...)
		self.children = self.children or {}
		return card_area_align_cards_ref(self, ...)
	end

	local game_start_up_ref = Game.start_up
	function Game:start_up(...)
		local result = game_start_up_ref(self, ...)
		G.E_MANAGER:add_event(Event({
			no_delete = true,
			blocking = false,
			func = function()
				G.E_MANAGER:add_event(Event({
					no_delete = true,
					blocking = false,
					func = function()
						Handy.speed_multiplier.load_default_value()
						Handy.animation_skip.load_default_value()
						return true
					end,
				}))
				return true
			end,
		}))
		return result
	end

	--

	function Handy.emplace_steamodded()
		if Handy.current_mod then
			return
		end
		Handy.current_mod = (Handy_Preload and Handy_Preload.current_mod) or SMODS.current_mod
		Handy.UI.show_options_button = not Handy.cc.hide_options_button.enabled

		-- Config tabs
		Handy.current_mod.config_tab = function()
			return Handy.UI.get_options_tabs()[1].tab_definition_function
		end
		Handy.current_mod.extra_tabs = function()
			local result = Handy.UI.get_options_tabs()
			table.remove(result, 1)
			return result
		end

		-- NotJustYet
		G.E_MANAGER:add_event(Event({
			func = function()
				G.njy_keybind = nil
				return true
			end,
		}))

		-- Animation skip setup
		local smods_calculate_effect_ref = SMODS.calculate_effect or function() end
		function SMODS.calculate_effect(effect, ...)
			if Handy.animation_skip.should_skip_animation() then
				effect.juice_card = nil
			end
			return smods_calculate_effect_ref(effect, ...)
		end
		if (SMODS.Mods and SMODS.Mods["Talisman"] or {}).can_load then
			local nuGC_ref = nuGC
			function nuGC(time_budget, ...)
				if G.STATE == G.STATES.HAND_PLAYED then
					time_budget = 0.0333
				end
				return nuGC_ref(time_budget, ...)
			end
		end

		if Handy_Preload then
			Handy_Preload = nil
		end
	end

	if Handy_Preload then
		Handy.emplace_steamodded()
	end
end
