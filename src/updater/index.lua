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
		INSTALLING = 3,
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
				Handy.updater.set_state(Handy.updater.STATES.IDLE)
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

	install_release = function(release_type, callback)
		callback = callback or function() end

		local function exit(message, no_set_state)
			message = message or "success"
			if not no_set_state then
				Handy.updater.set_state(Handy.updater.STATES.IDLE)
			end
			Handy.UI.state_panel.display(function(state)
				state.items.updater = {
					text = Handy.L.variable("Handy_updater_finish_" .. message),
					hold = false,
					order = -1,
				}
				if message == "success" then
					state.items.updater_description = {
						text = Handy.L.variable("Handy_updater_finish_description"),
						hold = false,
						order = -1,
					}
				end
				return true
			end)
			callback(message)
		end

		if Handy.updater.STATE ~= Handy.updater.STATES.IDLE then
			return exit("busy", true)
		end
		Handy.updater.set_state(Handy.updater.STATES.INSTALLING)

		Handy.e_mitter.on("update", function(dt)
			local event = https_updater_output:pop()
			if event then
				if event.install_update_error then
					https_updater_thread:wait()
					Handy.e_mitter.off("update", "handy_updater")
					exit(event.message)
				elseif event.install_update_progress then
					Handy.UI.state_panel.display(function(state)
						state.items.updater = {
							text = Handy.L.variable("Handy_updater_progress_" .. event.message),
							hold = true,
							order = -1,
						}
						return true
					end)
				elseif event.install_update_success then
					https_updater_thread:wait()
					Handy.e_mitter.off("update", "handy_updater")
					Handy.updater.installed_update = release_type
					exit()
				end
			end
		end, {
			key = "handy_updater",
		})

		https_updater_thread:start()
		https_updater_input:push({
			install_release = true,
			release_type = release_type,
			use_smods = SMODS and true or false,
			mod_path = Handy.PATH,
		})
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
		-- but, if we install some update, we're not in any current update, probably
		if not Handy.updater.installed_update and Handy.updater["is_current_" .. release_type] then
			return false, "current_version"
		end
		return true
	end,

	game_startup_check_updates = function()
		Handy.updater.get_releases(nil, function()
			if not Handy.cc.updater.enabled then
				return
			end
			local is_new_stable = Handy.updater.is_new_stable
			local is_new_pre_release = Handy.cc.updater_release_type.value == 2 and Handy.updater.is_new_pre_release
			if not (is_new_pre_release or is_new_stable) then
				return
			end
			if Handy.cc.updater_auto_install_new_update.enabled then
				Handy.updater.install_release(is_new_pre_release and "pre_release" or "stable", function(error)
					if not error and Handy.cc.updater_auto_restart_game_after_update.enabled then
						Handy.UI.state_panel.display(function(state)
							state.items.updater_auto_restart = {
								text = Handy.L.variable("Handy_updater_auto_restart"),
								dangerous = true,
								order = -1000000,
								hold = true,
							}
						end)
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 2,
							no_delete = true,
							blocking = false,
							blockable = false,
							timer = "REAL",
							func = function()
								Handy.utils.restart_game()
								return true
							end,
						}))
					end
				end)
			elseif Handy.cc.updater_notify_about_new_update.enabled then
				Handy.UI.state_panel.display(function(state)
					state.items.new_update = {
						text = Handy.L.variable(
							is_new_pre_release and "Handy_new_pre_release_available" or "Handy_new_stable_available"
						),
						hold = false,
						order = -1,
					}
					state.items.new_update_desc = {
						text = Handy.L.variable("Handy_new_release_description"),
						hold = false,
						order = -0.99,
					}
					return true
				end)
			end
		end)
	end,
}

Handy.load_file("src/updater/versioner.lua")

--

Handy.e_mitter.on("game_start", function()
	G.E_MANAGER:add_event(Event({
		no_delete = true,
		blocking = false,
		func = function()
			G.E_MANAGER:add_event(Event({
				no_delete = true,
				blocking = false,
				func = function()
					Handy.updater.game_startup_check_updates()
					return true
				end,
			}))
			return true
		end,
	}))
end)
