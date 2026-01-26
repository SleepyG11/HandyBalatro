local debugplus_module = {
	config_imported = false,
	config = nil,

	console_imported = false,
	console = nil,
}

local function get_dp_config()
	if debugplus_module.config_imported then
		return debugplus_module.config
	end
	local success, dpconfig = pcall(function()
		return require("debugplus-config")
	end)
	if not success then
		success, dpconfig = pcall(function()
			return require("debugplus.config")
		end)
	end
	debugplus_module.config_imported = true
	debugplus_module.config = success and dpconfig or nil
	return debugplus_module.config
end
local function get_dp_console()
	if debugplus_module.console_imported then
		return debugplus_module.console
	end
	local console_success, dpconsole = pcall(function()
		return require("debugplus.console")
	end)
	debugplus_module.console_imported = true
	debugplus_module.console = console_success and dpconsole or nil
	return debugplus_module.console
end

local console_open_timer = 0
local function is_dp_console_opened()
	return Handy.b_is_mod_active() and console_open_timer > G.TIMERS.UPTIME
end
local function b_is_dp_console_opened()
	return Handy.buffered("v2_dp_is_console_opened", is_dp_console_opened)
end
local function update_dp_console_opened()
	local dpconsole = get_dp_console()
	if dpconsole and dpconsole.isConsoleFocused and dpconsole.isConsoleFocused() then
		console_open_timer = G.TIMERS.UPTIME + 1
	end
end

local function should_prevent_input()
	local dpconfig = get_dp_config()
	if dpconfig and Handy.b_is_mod_active() and Handy.cc.prevent_if_debugplus.enabled then
		local success, is_enabled = pcall(function()
			return dpconfig.getValue("ctrlKeybinds")
		end)
		return success and is_enabled and Handy.controller_v2.key_states.real_hold["Ctrl"] and true or false
	end
	return false
end
local function b_should_prevent_input()
	return Handy.buffered("dp_prevent_if_ctrl", should_prevent_input)
end
local function notify_about_prevented_input()
	Handy.UI.state_panel.display(function(state)
		state.items.dp_prevent = {
			text = Handy.L.variable("Handy_prevented_by_debugplus"),
			hold = false,
			order = 0,
		}
		return true
	end, nil, 3)
end

debugplus_module.is_console_opened = b_is_dp_console_opened
debugplus_module.should_prevent_input = b_should_prevent_input
debugplus_module.notify_about_prevented_input = notify_about_prevented_input
debugplus_module.update_console_opened = update_dp_console_opened

Handy.controller_v2.dp = debugplus_module
