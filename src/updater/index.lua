local updater_thread_file = Handy.read_file("src/updater/updater_thread.lua")

local https_updater_input = love.thread.getChannel("handy_updater_input")
local https_updater_output = love.thread.getChannel("handy_updater_output")

local https_updater_thread =
	love.thread.newThread(love.filesystem.newFileData(updater_thread_file, '=[SMODS Handy "threads/updater"]'))
https_updater_thread:start()

local function send_to_updater(data, response_event, callback)
	callback = callback or function() end

	Handy.e_mitter.on("update", function(dt)
		local event = https_updater_output:pop()
		if event then
			if event.log then
				print(event.message)
			end
			if event[response_event] then
				Handy.e_mitter.off("update", "handy_updater")
				callback(event)
			end
		end
	end, {
		key = "handy_updater",
	})

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

	is_loaded = false,
	last_check_updates_time = 0,
	stale_timeout = 60 * 15,

	is_new_stable = false,
	is_current_stable = false,
	is_new_pre_release = false,
	is_current_pre_release = false,
	new_version_stable = nil,
	new_version_pre_release = nil,

	installed_update = nil,

	loc_state = "",

	localize_state = function() end,
	set_state = function(state)
		Handy.updater.STATE = state
		Handy.updater.localize_state()
	end,

	releases = nil,
	request_releases = request_releases,

	get_release_info = function(release_type)
		local release = (Handy.updater.releases or {})[release_type]

		return {
			release = release,
			is_new = Handy.updater["is_new_" .. release_type] or false,
			is_current = Handy.updater["is_current_" .. release_type] or false,
			new_version = Handy.updater["new_version_" .. release_type] or nil,
			is_installed = Handy.updater.installed_update == release_type,
		}
	end,

	update_versions = function()
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
				Handy.updater.new_version_stable = stable_version
				Handy.updater.is_new_stable = Handy.updater.V.is_newer(Handy.updater.V(stable_version), current_v)
				Handy.updater.is_current_stable = stable_version == Handy.version
			end
			if Handy.updater.releases.pre_release and not Handy.updater.releases.pre_release.draft then
				local pre_release_version = Handy.updater.releases.pre_release.tag_name
				pre_release_version = pre_release_version:gsub("^v", ""):gsub("-", "~", 1)
				Handy.updater.new_version_pre_release = pre_release_version
				Handy.updater.is_new_pre_release =
					Handy.updater.V.is_newer(Handy.updater.V(pre_release_version), current_v)
				Handy.updater.is_current_pre_release = pre_release_version == Handy.version
			end
		end
	end,

	is_updated_releases_data = function()
		return G.TIMERS.REAL - (Handy.updater.last_check_updates_time or 0) < Handy.updater.stale_timeout
	end,
	get_releases = function(args, callback)
		args = args or {}
		callback = callback or function() end

		if Handy.updater.releases and not args.no_cache and Handy.updater.is_updated_releases_data() then
			callback(nil, Handy.updater.releases)
		elseif Handy.updater.STATE ~= Handy.updater.STATES.IDLE then
			callback("busy")
		else
			Handy.updater.last_check_updates_time = nil
			Handy.updater.set_state(Handy.updater.STATES.CHECKING)
			request_releases(function(releases)
				Handy.updater.last_check_updates_time = G.TIMERS.REAL
				Handy.updater.set_state(Handy.updater.STATES.IDLE)
				if releases and releases.success then
					Handy.updater.releases = releases
					Handy.updater.update_versions()
					callback(nil, releases)
				else
					callback("fetch_error")
				end
			end)
		end
		-- Return this as old result for responsive UI
		return Handy.updater.releases
	end,

	can_install_release = function(release_type)
		local release_info = Handy.updater.get_release_info(release_type)
		-- no release to install
		if not release_info.release then
			return false, "no_data"
		end
		-- already installed
		if release_info.is_installed then
			return false, "already_installed"
		end
		-- busy
		if Handy.updater.STATE ~= Handy.updater.STATES.IDLE then
			return false, "busy"
		end
		-- already installed even before updating
		-- but, if we install some update, we're not in any current update, probably
		if not Handy.updater.installed_update and release_info.is_current then
			return false, "current_version"
		end
		return true
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
				state.items.updater_version = {
					text = Handy.L.brackets(Handy.updater["new_version_" .. release_type]),
					hold = false,
					order = -0.995,
				}
				if message == "success" then
					state.items.updater_description = {
						text = Handy.L.variable("Handy_updater_finish_description"),
						hold = false,
						order = -0.99,
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
					Handy.e_mitter.off("update", "handy_updater")
					exit(event.message)
				elseif event.install_update_progress then
					Handy.UI.state_panel.display(function(state)
						state.items.updater = {
							text = Handy.L.variable("Handy_updater_progress_" .. event.message),
							hold = true,
							order = -1,
						}
						state.items.updater_version = {
							text = Handy.L.brackets(Handy.updater["new_version_" .. release_type]),
							hold = true,
							order = -0.995,
						}
						return true
					end)
				elseif event.install_update_success then
					Handy.e_mitter.off("update", "handy_updater")
					Handy.updater.installed_update = release_type
					exit()
				end
			end
		end, {
			key = "handy_updater",
		})

		https_updater_input:push({
			install_release = true,
			release_type = release_type,
			use_smods = SMODS and true or false,
			mod_path = Handy.PATH,
		})
	end,

	get_new_available_release = function()
		local stable_info = Handy.updater.get_release_info("stable")
		local pre_release_info = Handy.updater.get_release_info("pre_release")

		local is_new_stable = stable_info.is_new and not stable_info.is_installed
		local is_new_pre_release = Handy.cc.updater_release_type.value == 2
			and pre_release_info.is_new
			and not pre_release_info.is_installed

		if is_new_pre_release then
			return "pre_release"
		elseif is_new_stable then
			return "stable"
		else
			return nil
		end
	end,
	game_startup_check_updates = function()
		Handy.updater.get_releases({ no_cache = true }, function(releases)
			if not Handy.cc.updater.enabled then
				return
			end
			local release_type = Handy.updater.get_new_available_release()
			if not release_type then
				return
			end
			if Handy.cc.updater_auto_install_new_update.enabled then
				Handy.updater.install_release(release_type, function(error)
					if not error and Handy.cc.updater_auto_restart_game_after_update.enabled then
						Handy.UI.state_panel.display(function(state)
							state.items.updater_auto_restart = {
								text = Handy.L.variable("Handy_updater_auto_restart"),
								dangerous = true,
								order = -1000000,
								hold = true,
							}
							state.items.updater_version = {
								text = Handy.L.brackets(Handy.updater["new_version_" .. release_type]),
								hold = true,
								order = -0.995,
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
						text = Handy.L.variable("Handy_new_" .. release_type .. "_available")
							.. " "
							.. Handy.L.brackets(Handy.updater["new_version_" .. release_type]),
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
					Handy.updater.is_loaded = true
					return true
				end,
			}))
			return true
		end,
	}))
end)

Handy.e_mitter.on("update", function()
	if
		Handy.updater.is_loaded
		and not Handy.updater.is_updated_releases_data()
		and Handy.updater.STATE == Handy.updater.STATES.IDLE
	then
		Handy.updater.get_releases({ no_cache = true })
	end
end)
