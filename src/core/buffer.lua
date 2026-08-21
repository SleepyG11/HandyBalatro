local buffer = {}
Handy.buffer = buffer

function Handy.buffered(key, func)
	return function()
		if buffer[key] ~= nil then
			return buffer[key]
		end
		buffer[key] = func()
		return buffer[key]
	end
end

Handy.e_mitter.on("update", function(dt)
	EMPTY(Handy.buffer)
end)
