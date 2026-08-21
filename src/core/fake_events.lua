Handy.fake_events = {
	check = function(arg)
		if type(arg.func) ~= "function" then
			return false, nil
		end
		if arg.node then
			arg.func(arg.node)
			return arg.node.config.button ~= nil, arg.node.config.button
		else
			local fake_event = {
				UIBox = arg.UIBox,
				config = arg.config or {
					ref_table = arg.card,
					button = arg.button,
					id = arg.id,
				},
			}
			arg.func(fake_event)
			return fake_event.config.button ~= nil, fake_event.config.button
		end
	end,
	execute = function(arg)
		if type(arg.func) == "function" then
			if arg.node then
				arg.func(arg.node)
			else
				arg.func({
					UIBox = arg.UIBox,
					config = arg.config or {
						ref_table = arg.card,
						button = arg.button,
						id = arg.id,
					},
				})
			end
		end
	end,
	check_button = function(selector, options)
		options = options or {}
		local success, button = pcall(selector)
		if not success or not button or not button.config or not button.states then
			return false, button and button.config and button.config.button or nil
		end
		if options.visible and not button.states.visible then
			return false, button.config.button
		end
		local check_func = button.config.func
		if (options.require_func or options.require_exact_func) and not check_func then
			return false, button.config.button
		end
		if options.require_exact_func and check_func ~= options.require_exact_func then
			return false, button.config.button
		end
		if check_func then
			return Handy.fake_events.check({
				func = G.FUNCS[check_func],
				node = button,
			})
		else
			return true, button.config.button
		end
	end,
	execute_button = function(selector)
		local success, button = pcall(selector)
		if not success or not button or not button.config then
			return
		end
		if type(button.click) == "function" then
			button:click()
		else
			if button.config.button then
				Handy.fake_events.execute({
					func = G.FUNCS[button.config.button],
					node = button,
				})
			end
		end
	end,
}
