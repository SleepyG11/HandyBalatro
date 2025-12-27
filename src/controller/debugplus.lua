Handy.controller.dp = setmetatable({
	console_opened_timer = 0,
	module = nil,
}, {})

function Handy.controller.dp.get_module()
	local success, dpconfig, dputils = pcall(function()
		return require("debugplus-config"), require("debugplus-util")
	end)
	if not success then
		success, dpconfig, dputils = pcall(function()
			return require("debugplus.config"), require("debugplus.util")
		end)
	end
	local console_success, dpconsole = pcall(function()
		return require("debugplus.console")
	end)
	local result
	if not success then
		result = {
			installed = false,
			config = nil,
			utils = nil,
			console = console_success and dpconsole or nil,
		}
	else
		result = {
			installed = true,
			config = dpconfig,
			utils = dputils,
			console = console_success and dpconsole or nil,
		}
	end
	Handy.controller.dp.module = result
	function Handy.controller.dp.get_module()
		return Handy.controller.dp.module
	end
	if console_success and dpconsole and dpconsole.isConsoleFocused then
		function Handy.controller.dp.update_is_console_opened()
			if dpconsole.isConsoleFocused() then
				Handy.controller.dp.console_opened_timer = G.TIMERS.UPTIME + 1
			end
		end
	end
	return result
end

function Handy.controller.dp.update_is_console_opened() end

function Handy.controller.dp.is_console_opened()
	return Handy.b_is_mod_active() and Handy.controller.dp.console_opened_timer > G.TIMERS.UPTIME
end
function Handy.controller.dp.b_is_console_opened()
	return Handy.buffered("dp_is_console_opened", Handy.controller.dp.is_console_opened)
end

function Handy.controller.dp.should_prevent()
	if not Handy.b_is_mod_active() then
		return false
	end
	local dp = Handy.controller.dp.get_module()
	if not (dp.installed and Handy.cc.prevent_if_debugplus.enabled) then
		return false
	end
	local success, is_triggered = pcall(function()
		return dp.config.getValue("ctrlKeybinds") and dp.utils.isCtrlDown()
	end)
	if success and is_triggered then
		Handy.controller.stop_propagation()
		Handy.UI.state_panel.display(function(state)
			state.items.dp_prevent = {
				text = Handy.L.variable("Handy_prevented_by_debugplus"),
				hold = false,
				order = 0,
			}
			return true
		end, nil, 3)
	end
end

Handy.e_mitter.on("update", function()
	Handy.controller.dp.update_is_console_opened()
end)
