local buffer = {}
Handy.buffer = buffer

function Handy.buffered(key, func)
	if buffer[key] ~= nil then
		return buffer[key]
	end
	buffer[key] = func()
	return buffer[key]
end

Handy.e_mitter.on("update", function(dt)
	buffer = {}
	Handy.buffer = buffer
end)
