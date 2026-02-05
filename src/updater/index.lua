local updater_thread_file = Handy.read_file("src/updater/updater_thread.lua")

local https_updater_input = love.thread.getChannel("handy_updater_input")
local https_updater_output = love.thread.getChannel("handy_updater_output")

local https_updater_thread =
	love.thread.newThread(love.filesystem.newFileData(updater_thread_file, '=[SMODS Handy "threads/updater"]'))

local function send_to_updater(data, response_event, callback)
	callback = callback or function() end

	Handy.e_mitter.on("update", function(dt)
		local event = https_updater_output:pop()
		if event then
			if event[response_event] then
				https_updater_thread:wait()
				Handy.e_mitter.off("update", "handy_updater")
				callback(event)
			end
		end
	end, {
		key = "handy_updater",
	})

	https_updater_thread:start()
	data.use_smods = SMODS and true or false
	https_updater_input:push(data)
end

local function request_releases(callback)
	send_to_updater({ check_update = true }, "check_update_complete", callback)
end
local function download_release(url, callback)
	send_to_updater({ download_release = true, url = url }, "download_release_complete", callback)
end
local function unzip_archive(callback)
	send_to_updater({ unzip_archive = true }, "unzip_archive_complete", callback)
end
local function replace_mod(callback)
	send_to_updater({
		replace_mod = true,
		mod_path = Handy.PATH,
	}, "replace_mod_complete", callback)
end

Handy.updater = {
	STATES = {
		IDLE = 1,
		CHECKING = 2,
		DOWNLOADING = 3,
		INSTALLING = 4,
	},
	STATE = 1,

	loc_state = "",

	localize_state = function() end,
	set_state = function(state)
		Handy.updater.STATE = state
		Handy.updater.localize_state()
	end,

	releases = nil,
	request_releases = request_releases,

	get_releases = function(args, callback)
		-- TODO: stale check

		args = args or {}
		callback = callback or function() end

		if Handy.updater.releases and not args.no_cache then
			callback(nil, Handy.updater.releases)
			return Handy.updater.releases
		elseif Handy.updater.STATE ~= Handy.updater.STATES.IDLE then
			callback("busy")
		else
			Handy.updater.set_state(Handy.updater.STATES.CHECKING)
			request_releases(function(releases)
				if not args.no_idle_state then
					Handy.updater.set_state(Handy.updater.STATES.IDLE)
				end
				if releases and releases.success then
					Handy.updater.releases = releases
					callback(nil, releases)
				else
					callback("fetch_error")
				end
			end)
		end
	end,

	install_release = function(args, callback)
		args = args or {}
		callback = callback or function() end

		local function exit(message, no_set_state)
			if not no_set_state then
				Handy.updater.set_state(Handy.updater.STATES.IDLE)
			end
			callback(message)
		end

		if Handy.updater.STATE ~= Handy.updater.STATES.IDLE then
			return exit("busy", true)
		end

		local download = function(url)
			Handy.updater.set_state(Handy.updater.STATES.DOWNLOADING)
			download_release(url, function(download_event)
				if not download_event.success then
					return exit("download_error")
				end
				Handy.updater.set_state(Handy.updater.STATES.INSTALLING)
				unzip_archive(function(unzip_event)
					if not unzip_event.success then
						return exit("unzip_error")
					end
					replace_mod(function(replace_event)
						if not replace_event.success then
							return exit("replace_error")
						end
						exit(nil)
					end)
				end)
			end)
		end

		if args.url then
			download(args.url)
		elseif args.release_type then
			Handy.updater.get_releases({
				no_idle_state = true,
				no_cache = args.no_cache,
			}, function(error, releases)
				if error then
					exit(error)
				end
				if not (releases and releases.success and releases[args.release_type]) then
					return exit("not_found")
				end
				download(releases[args.release_type].zipball_url)
			end)
		else
			exit("invalid_args")
		end
	end,
}
