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

	is_new_stable = false,
	is_current_stable = false,
	is_new_pre_release = false,
	is_current_pre_release = false,

	installed_update = nil,

	loc_state = "",

	localize_state = function() end,
	set_state = function(state)
		Handy.updater.STATE = state
		Handy.updater.localize_state()
	end,

	releases = nil,
	request_releases = request_releases,

	check_is_new_version_available = function()
		if not Handy.updater.releases then
			Handy.updater.is_new_stable = false
			Handy.updater.is_new_pre_release = false
			Handy.updater.is_current_stable = false
			Handy.updater.is_current_pre_release = false
		else
			local current_v = Handy.updater.V(Handy.version)
			if Handy.updater.releases.stable and not Handy.updater.releases.stable.draft then
				local stable_version = Handy.updater.releases.stable.tag_name
				stable_version = stable_version:gsub("^v", "")
				Handy.updater.is_new_stable = Handy.updater.V(stable_version) > current_v
				Handy.updater.is_current_stable = stable_version == Handy.version
			end
			if Handy.updater.releases.pre_release and not Handy.updater.releases.pre_release.draft then
				local pre_release_version = Handy.updater.releases.pre_release.tag_name
				pre_release_version = pre_release_version:gsub("^v", ""):gsub("-", "~", 1)
				Handy.updater.is_new_pre_release = Handy.updater.V(pre_release_version) > current_v
				Handy.updater.is_current_pre_release = pre_release_version == Handy.version
			end
		end
	end,

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
					Handy.updater.check_is_new_version_available()
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
			Handy.UI.state_panel.display(function(state)
				state.items.updater = {
					text = Handy.L.variable("Handy_updater_finish_" .. (message or "success")),
					hold = false,
					order = -1,
				}
				return true
			end)
			callback(message)
		end

		if Handy.updater.STATE ~= Handy.updater.STATES.IDLE then
			return exit("busy", true)
		end

		local download = function(url)
			Handy.updater.set_state(Handy.updater.STATES.DOWNLOADING)
			Handy.UI.state_panel.display(function(state)
				state.items.updater = {
					text = Handy.L.variable("Handy_updater_downloading"),
					hold = true,
					order = -1,
				}
				return true
			end)
			download_release(url, function(download_event)
				if not download_event.success then
					return exit("download_error")
				end
				Handy.updater.set_state(Handy.updater.STATES.INSTALLING)
				Handy.UI.state_panel.display(function(state)
					state.items.updater = {
						text = Handy.L.variable("Handy_updater_installing"),
						hold = true,
						order = -1,
					}
					return true
				end)
				unzip_archive(function(unzip_event)
					if not unzip_event.success then
						return exit("unzip_error")
					end
					replace_mod(function(replace_event)
						if not replace_event.success then
							return exit("replace_error")
						end
						Handy.updater.installed_update = args.release_type
						exit(nil)
					end)
				end)
			end)
		end

		if args.release_type then
			Handy.UI.state_panel.display(function(state)
				state.items.updater = {
					text = Handy.L.variable("Handy_updater_getting_updates"),
					hold = true,
					order = -1,
				}
				return true
			end)
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

	can_install_release = function(release_type)
		local release = (Handy.updater.releases or {})[release_type]
		-- no release to install
		if not release then
			return false, "no_data"
		end
		-- already installed
		if Handy.updater.installed_update == release_type then
			return false, "already_installed"
		end
		-- busy
		if Handy.updater.STATE ~= Handy.updater.STATES.IDLE then
			return false, "busy"
		end
		-- already installed even before updating
		if Handy.updater["is_current_" .. release_type] then
			return false, "already_installed"
		end
		return true
	end,
}

Handy.load_file("src/updater/versioner.lua")

Handy.e_mitter.on("game_start", function()
	Handy.updater.get_releases()
end)
