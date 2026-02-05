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
local function replace_mod(delete_old, callback)
	send_to_updater({
		replace_mod = true,
		mod_path = Handy.PATH,
		delete_old = delete_old and true or false,
	}, "replace_mod_complete", callback)
end

Handy.updater = {
	request_releases = request_releases,

	download_stable_release = function(delete_old)
		request_releases(function(releases_event)
			if releases_event.success and releases_event.stable then
				download_release(releases_event.stable.zipball_url, function(download_event)
					unzip_archive(function(unzip_event)
						replace_mod(delete_old, function(replace_event)
							print("Installation is done")
						end)
					end)
				end)
			end
		end)
	end,
	download_pre_release = function(delete_old)
		request_releases(function(releases_event)
			if releases_event.success and releases_event.pre_release then
				download_release(releases_event.pre_release.zipball_url, function(download_event)
					unzip_archive(function(unzip_event)
						replace_mod(delete_old, function(replace_event)
							print("Installation is done")
						end)
					end)
				end)
			end
		end)
	end,
}
