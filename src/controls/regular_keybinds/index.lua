Handy.regular_keybinds = {
	shop_reroll_blocker = false,
	play_blocker = false,
	discard_blocker = false,
	reload_run_blocker = false,

	shop_loaded = false,

	on_shop_loaded = function()
		if not G.shop then
			return
		end
		Handy.regular_keybinds.shop_loaded = true
		local remove_func_ref = G.shop.remove
		function G.shop:remove(...)
			Handy.regular_keybinds.shop_loaded = false
			return remove_func_ref(self, ...)
		end
	end,

	restart_lock = nil,
	bypass_restart = false,
	can_restart = function()
		if Handy.ARGS.hold_update_from_controller then
			return not Handy.b_is_mod_active() and not G.SETTINGS.paused
		end
		return true
	end,

	show_deck_preview_hold = false,
	booster_pack_skipped = false,

	can_skip_cashout = false,
	cashout_skipped = false,
}
