local prevents = {}
Handy.controller.preventers = prevents

function Handy.controller.reset_prevents()
	prevents = {}
	Handy.controller.preventers = prevents
end

-- I'm web dev, after all

function Handy.controller.prevent_default()
	prevents.default = true
end
function Handy.controller.is_default_prevented()
	return prevents.default
end

function Handy.controller.stop_propagation()
	prevents.propagation = true
end
function Handy.controller.is_propagation_stopped()
	return prevents.propagation
end

function Handy.controller.stop_immediate_propagation()
	prevents.immadiate_propagation = true
	prevents.propagation = true
end
function Handy.controller.is_propagation_immediately_stopped()
	return prevents.immadiate_propagation
end

--

function Handy.controller.is_trigger_on_release()
	return Handy.cc.keybinds_trigger_mode.value == 2
end
function Handy.controller.b_is_trigger_on_release()
	return Handy.buffered("is_trigger_on_release", Handy.controller.is_trigger_on_release)
end
function Handy.controller.is_triggered(released)
	if Handy.controller.b_is_trigger_on_release() then
		return released
	else
		return not released
	end
end
