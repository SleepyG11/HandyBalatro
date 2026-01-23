Handy.e_mitter = setmetatable({}, {})
Handy.e_mitter.queues = {}

function Handy.e_mitter.on(type, callback, args)
	args = args or {}
	if not Handy.e_mitter.queues[type] then
		Handy.e_mitter.queues[type] = {}
	end
	local result = {
		callback = callback or function() end,
		key = args.key,
	}
	if args.before then
		for index, item in ipairs(Handy.e_mitter.queues[type]) do
			if item.key and item.key == args.before then
				table.insert(Handy.e_mitter.queues[type], index, result)
				return
			end
		end
	elseif args.after then
		for index, item in ipairs(Handy.e_mitter.queues[type]) do
			if item.key and item.key == args.after then
				table.insert(Handy.e_mitter.queues[type], index + 1, result)
				return
			end
		end
	elseif args.start then
		table.insert(Handy.e_mitter.queues[type], 1, result)
	else
		table.insert(Handy.e_mitter.queues[type], result)
	end
end
function Handy.e_mitter.emit(type, ...)
	if Handy.e_mitter.queues[type] then
		for _, item in ipairs(Handy.e_mitter.queues[type]) do
			if item.callback(...) then
				return true
			end
		end
	end
	return false
end
