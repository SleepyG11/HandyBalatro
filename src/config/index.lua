Handy.config = setmetatable({}, {})
Handy.load_file("src/config/default_config.lua")

-- Save/load

Handy.config.save_event = nil

function Handy.config.save()
	if SMODS and SMODS.save_mod_config and Handy.current_mod then
		Handy.current_mod.config = Handy.config.current
		SMODS.save_mod_config(Handy.current_mod)
	else
		love.filesystem.createDirectory("config")
		local serialized = "return " .. Handy.utils.serialize(Handy.config.current)
		love.filesystem.write("config/Handy.jkr", serialized)
	end
	Handy.e_mitter.emit("settings_save")
end
function Handy.config.load()
	Handy.config.current = Handy.utils.table_merge({}, Handy.config.default)
	local lovely_mod_config = get_compressed("config/Handy.jkr")
	if lovely_mod_config then
		Handy.config.current = Handy.utils.table_merge_limit(
			1,
			Handy.config.current,
			Handy.config.actualize(STR_UNPACK(lovely_mod_config))
		)
	end
	Handy.cc = Handy.config.current
end
function Handy.config.request_save(delay)
	if Handy.config.save_event and not Handy.config.save_event.complete then
		Handy.config.save_event.time = G.TIMERS[Handy.config.save_event.timer]
	else
		local event = Event({
			no_delete = true,
			blocking = false,
			blockable = false,
			timer = "REAL",
			trigger = "after",
			delay = delay or 1,
			func = function()
				Handy.config.save()
				return true
			end,
		})
		Handy.config.save_event = event
		G.E_MANAGER:add_event(event, "other", true)
	end
end

function Handy.config.actualize(config)
	local target_version = 2
	local current_version = config.version or 1
	while current_version < target_version do
		current_version = current_version + 1
		config = Handy.config.migrate(config, current_version)
		config.version = current_version
	end
	return config
end
function Handy.config.migrate(old_config, to)
	if to == 2 then
		local config = Handy.utils.table_merge({}, Handy.config.old_defaults[1], old_config)
		local new_config = {}

		local merge_keys = function(target, ...)
			local r1 = {}
			local r2 = {}
			local rg1 = {}
			local rg2 = {}
			for _, module in ipairs({ ... }) do
				table.insert(r1, module.key_1 or "None")
				table.insert(r2, module.key_2 or "None")
				table.insert(rg1, module.key_1_gamepad or "None")
				table.insert(rg2, module.key_2_gamepad or "None")
			end
			target.keys_1 = Handy.utils.normalize_keys(r1)
			target.keys_2 = Handy.utils.normalize_keys(r2)
			target.keys_1_gamepad = Handy.utils.normalize_keys(rg1)
			target.keys_2_gamepad = Handy.utils.normalize_keys(rg2)
			target.key_1 = nil
			target.key_2 = nil
			target.key_1_gamepad = nil
			target.key_2_gamepad = nil
		end

		-- Values
		for _, key in ipairs({
			"notifications_level",
			"keybinds_trigger_mode",
			"insta_actions_trigger_mode",
			"current_device",
		}) do
			new_config[key] = {
				value = config[key],
			}
		end
		new_config.hide_options_button = {
			enabled = config.hide_in_menu,
		}
		new_config.controller_sensitivity = {
			enabled = config.controller_sensivity.enabled,
			value = config.controller_sensivity.mult,
		}

		-- presets
		for _, key in ipairs({ "1", "2", "3", "next" }) do
			new_config["presets_load_" .. key] = config.presets["load_" .. key]
		end

		-- hand selection
		new_config.hand_selection_insta_highlight = config.insta_highlight
		new_config.hand_selection_insta_highlight_allow_deselect = config.insta_highlight.allow_deselect
		new_config.hand_selection_insta_highlight.allow_deselect = nil
		new_config.hand_selection_entire_f_hand = config.insta_highlight_entire_f_hand
		new_config.hand_selection_deselect_hand = config.deselect_hand

		-- insta actions
		new_config.insta_actions_buy_or_sell = config.insta_buy_or_sell
		new_config.insta_actions_buy_n_sell = config.insta_buy_n_sell
		new_config.insta_actions_use = config.insta_use
		new_config.insta_actions_cryptid_code_use_last_interaction = config.cryptid_code_use_last_interaction

		-- move highlight
		new_config.move_highlight = {
			enabled = config.move_highlight.enabled,
		}
		new_config.move_highlight_dx_one_left = config.move_highlight.dx.one_left
		new_config.move_highlight_dx_one_right = config.move_highlight.dx.one_right
		new_config.move_highlight_swap = config.move_highlight.swap
		new_config.move_highlight_to_end = config.move_highlight.to_end

		-- speed multiplier
		new_config.speed_multiplier = {
			enabled = config.speed_multiplier.enabled,
		}
		new_config.speed_multiplier_default_value = {
			enabled = true,
			value = config.speed_multiplier.default_value,
		}
		new_config.speed_multiplier_settings_toggle = config.speed_multiplier.settings_toggle
		new_config.speed_multiplier_multiply = config.speed_multiplier.multiply
		new_config.speed_multiplier_divide = config.speed_multiplier.divide
		merge_keys(
			new_config.speed_multiplier_multiply,
			config.speed_multiplier.multiply,
			(not config.speed_multiplier.no_hold.enabled) and config.speed_multiplier or nil
		)
		merge_keys(
			new_config.speed_multiplier_divide,
			config.speed_multiplier.divide,
			(not config.speed_multiplier.no_hold.enabled) and config.speed_multiplier or nil
		)
		merge_keys(
			new_config.speed_multiplier_toggle_temp_disabled,
			(not config.speed_multiplier.no_hold.enabled) and config.speed_multiplier or nil,
			{
				key_1 = "]",
				key_2 = "None",
			}
		)

		-- animation skip
		new_config.animation_skip = {
			enabled = config.animation_skip.enabled,
		}
		new_config.animation_skip_default_value = {
			enabled = true,
			value = config.animation_skip.default_value,
		}
		new_config.animation_skip_settings_toggle = config.animation_skip.settings_toggle
		new_config.animation_skip_increase = config.animation_skip.increase
		new_config.animation_skip_decrease = config.animation_skip.decrease
		merge_keys(
			new_config.animation_skip_increase,
			config.animation_skip.increase,
			(not config.animation_skip.no_hold.enabled) and config.animation_skip or nil
		)
		merge_keys(
			new_config.animation_skip_decrease,
			config.animation_skip.decrease,
			(not config.animation_skip.no_hold.enabled) and config.animation_skip or nil
		)
		merge_keys(
			new_config.animation_skip_toggle_temp_disabled,
			(not config.animation_skip.no_hold.enabled) and config.animation_skip or nil,
			{
				key_1 = "]",
				key_2 = "None",
			}
		)

		-- scoring hold
		new_config.scoring_hold = config.scoring_hold
		new_config.scoring_hold_any_moment = config.scoring_hold.any_moment
		new_config.scoring_hold.any_moment = nil

		-- regular keybinds
		new_config.regular_keybinds = {
			enabled = config.regular_keybinds.enabled,
		}

		new_config.regular_keybinds_quick_restart = config.misc.quick_restart
		new_config.regular_keybinds_save_run = config.misc.save_run

		new_config.regular_keybinds_play = config.regular_keybinds.play
		new_config.regular_keybinds_discard = config.regular_keybinds.discard
		new_config.regular_keybinds_sort_by_rank = config.regular_keybinds.sort_by_rank
		new_config.regular_keybinds_sort_by_suit = config.regular_keybinds.sort_by_suit
		new_config.regular_keybinds_toggle_sort = config.regular_keybinds.toggle_sort
		new_config.regular_keybinds_start_fantoms_preview = config.misc.start_fantoms_preview

		new_config.regular_keybinds_skip_booster = config.insta_booster_skip
		new_config.regular_keybinds_reroll_shop = config.regular_keybinds.reroll_shop
		new_config.regular_keybinds_leave_shop = config.regular_keybinds.leave_shop

		new_config.regular_keybinds_select_blind = config.regular_keybinds.select_blind
		new_config.regular_keybinds_skip_blind = config.regular_keybinds.skip_blind
		new_config.regular_keybinds_reroll_boss = config.regular_keybinds.reroll_boss

		new_config.regular_keybinds_run_info = config.regular_keybinds.run_info
		new_config.regular_keybinds_run_info_blinds = config.regular_keybinds.run_info_blinds
		new_config.regular_keybinds_view_deck = config.regular_keybinds.view_deck
		new_config.regular_keybinds_lobby_info = config.regular_keybinds.lobby_info
		new_config.regular_keybinds_show_deck_preview = config.show_deck_preview
		new_config.regular_keybinds_mod_settings = config.misc.open_mod_settings

		new_config.regular_keybinds_not_just_yet_interaction = config.not_just_yet_interaction
		new_config.regular_keybinds_cash_out = config.insta_cash_out

		-- dangerous
		new_config.dangerous_actions = {
			enabled = config.dangerous_actions.enabled,
		}
		new_config.dangerous_actions_speed_multiplier_uncap = config.dangerous_actions.speed_multiplier_uncap
		new_config.dangerous_actions_animation_skip_unsafe = config.dangerous_actions.animation_skip_unsafe
		new_config.dangerous_actions_crash = config.misc.crash

		-- new_config.dangerous_actions_sell_one = config.dangerous_actions.immediate_buy_and_sell
		-- new_config.dangerous_actions_sell_one.queue = nil
		-- new_config.dangerous_actions_sell_all_same = config.dangerous_actions.sell_all_same
		-- new_config.dangerous_actions_sell_all = config.dangerous_actions.sell_all
		-- merge_keys(
		-- 	new_config.dangerous_actions_sell_all_same,
		-- 	config.dangerous_actions.immediate_buy_and_sell,
		-- 	config.dangerous_actions.sell_all_same
		-- )
		-- merge_keys(
		-- 	new_config.dangerous_actions_sell_all,
		-- 	config.dangerous_actions.immediate_buy_and_sell,
		-- 	config.dangerous_actions.sell_all
		-- )
		-- merge_keys(
		-- 	new_config.dangerous_actions_remove_one or {},
		-- 	config.dangerous_actions.immediate_buy_and_sell,
		-- 	config.dangerous_actions.card_remove
		-- )
		-- merge_keys(
		-- 	new_config.dangerous_actions_remove_all_same or {},
		-- 	config.dangerous_actions.immediate_buy_and_sell,
		-- 	config.dangerous_actions.card_remove,
		-- 	config.dangerous_actions.sell_all_same
		-- )
		-- merge_keys(
		-- 	new_config.dangerous_actions_remove_all or {},
		-- 	config.dangerous_actions.immediate_buy_and_sell,
		-- 	config.dangerous_actions.card_remove,
		-- 	config.dangerous_actions.sell_all
		-- )

		-- all old keys
		for key, module in pairs(new_config) do
			if module.key_1 and not module.keys_1 then
				module.keys_1 = { module.key_1 }
				module.key_1 = nil
			end
			if module.key_2 and not module.keys_2 then
				module.keys_2 = { module.key_2 }
				module.key_2 = nil
			end
			if module.key_1_gamepad and not module.keys_1_gamepad then
				module.keys_1_gamepad = { module.key_1_gamepad }
				module.key_1_gamepad = nil
			end
			if module.key_2_gamepad and not module.keys_2_gamepad then
				module.keys_2_gamepad = { module.key_2_gamepad }
				module.key_2_gamepad = nil
			end
		end
		return new_config
	end
	return old_config
end

-- Getting calculated module data

function Handy.config.get_module(module)
	if not module then
		return nil
	end
	local override = Handy.get_module_override(module)
	if override then
		return Handy.utils.table_merge({}, module, override)
	end
	return module
end
function Handy.get_module_override(module)
	return nil
end
function Handy.m(module)
	return Handy.config.get_module(module)
end

Handy.config.load()
