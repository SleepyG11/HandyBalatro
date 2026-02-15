require("love.system")
require("love.filesystem")
sendDebugMessage = sendDebugMessage or function() end
arg = args or {}

local json = require("handy/json")
local NFS = require("handy/nativefs")

local temp_folder = "Handy_UpdaterTempFiles"
local zip_file = "HandyBalatro.zip"
local unzip_folder = "HandyBalatro"
local temp_suffix = "_old"
local stored_folder = "HandyBalatro_" .. temp_suffix

local https_input = love.thread.getChannel("handy_updater_input")
local https_output = love.thread.getChannel("handy_updater_output")

--

local function recursivelyDelete(item)
	if NFS.getInfo(item, "directory") then
		for _, child in ipairs(NFS.getDirectoryItems(item)) do
			recursivelyDelete(item .. "/" .. child)
			NFS.remove(item .. "/" .. child)
		end
	elseif NFS.getInfo(item) then
		NFS.remove(item)
	end
	NFS.remove(item)
end
local function loveRecursivelyCopy(folder, saveDir)
	local lfs = love.filesystem
	local filesTable = lfs.getDirectoryItems(folder)
	if saveDir ~= "" and not lfs.isDirectory(saveDir) then
		lfs.createDirectory(saveDir)
	end

	for i, v in ipairs(filesTable) do
		local file = folder .. "/" .. v
		local saveFile = saveDir .. "/" .. v
		if saveDir == "" then
			saveFile = v
		end

		if lfs.isDirectory(file) then
			lfs.createDirectory(saveFile)
			loveRecursivelyCopy(file, saveFile)
		else
			lfs.write(saveFile, tostring(lfs.read(file)))
		end
	end
end
local function get_fetcher(use_smods)
	return use_smods and require("SMODS.https") or require("https")
end

--

local function get_latest_releases(use_smods)
	local fetcher = get_fetcher(use_smods)
	if not fetcher then
		return {
			success = false,
			message = "no_fetcher",
		}
	end
	local code, response, headers
	local url = "https://api.github.com/repos/SleepyG11/HandyBalatro/releases?per_page=5"
	local is_redirect = false

	repeat
		code, response, headers = fetcher.request(url, {
			method = "GET",
			headers = {
				["User-Agent"] = "Mozilla/5.0",
			},
		})
		is_redirect = code >= 300 and code < 400
		if is_redirect then
			url = headers["location"]
		end
	until not is_redirect or not url

	if not response or not url then
		return {
			success = false,
			message = "no_connection",
		}
	end
	if code == 200 then
		local success, body = pcall(function()
			return json.decode(response)
		end)

		if not success then
			return {
				success = false,
				message = "invalid_server_response",
			}
		end

		local latest_stable, latest_pre_release
		for _, release in ipairs(body) do
			if not release.draft then
				if release.prerelease and not latest_pre_release then
					latest_pre_release = release
				elseif not release.prerelease and not latest_stable then
					latest_stable = release
				end
			end
		end

		if not latest_stable then
			local code, response, headers
			local url = "https://api.github.com/repos/SleepyG11/HandyBalatro/releases/latest"
			local is_redirect = false

			repeat
				code, response, headers = fetcher.request(url, {
					method = "GET",
					headers = {
						["User-Agent"] = "Mozilla/5.0",
					},
				})
				is_redirect = code >= 300 and code < 400
				if is_redirect then
					url = headers["location"]
				end
			until not is_redirect or not url

			if code == 200 then
				local success, body = pcall(function()
					return json.decode(response)
				end)

				if success then
					latest_stable = body
				end
			end
		end

		return {
			success = true,
			stable = latest_stable,
			pre_release = latest_pre_release,
		}
	else
		return {
			success = false,
			message = "check_request_failed",
		}
	end
end

--

local function download_release(url, use_smods)
	local fetcher = get_fetcher(use_smods)
	if not fetcher then
		return {
			success = false,
			message = "no_fetcher",
		}
	end

	local code, response, headers
	local is_redirect = false
	repeat
		code, response, headers = fetcher.request(url, {
			method = "GET",
			headers = {
				["User-Agent"] = "Mozilla/5.0",
			},
		})
		is_redirect = code >= 300 and code < 400
		if is_redirect then
			url = headers["location"]
		end
	until not is_redirect or not url

	if not response or not url then
		return {
			success = false,
			message = "no_connection",
		}
	end
	if code == 200 then
		local appdata_dir = love.filesystem.getSaveDirectory()
		local temp_dir = appdata_dir .. "/" .. temp_folder

		-- create temp
		NFS.createDirectory(temp_dir)
		-- delete zip
		recursivelyDelete(temp_dir .. "/" .. zip_file)
		-- write zip
		if not NFS.write(temp_dir .. "/" .. zip_file, response) then
			return {
				success = false,
				message = "cannot_write_zip",
			}
		end
		return {
			success = true,
		}
	else
		return {
			success = false,
			message = "download_request_failed",
		}
	end
end
local function unzip_archive()
	local appdata_dir = love.filesystem.getSaveDirectory()
	local temp_dir = appdata_dir .. "/" .. temp_folder

	local zipPath = temp_dir .. "/" .. zip_file
	local destination = temp_dir .. "/" .. unzip_folder

	local local_zipPath = temp_folder .. "/" .. zip_file
	local local_destination = temp_folder .. "/" .. unzip_folder

	local mount_prefix = "_temp"

	-- delete unzip
	recursivelyDelete(destination)
	-- mount archive
	local mount_success = love.filesystem.mount(local_zipPath, local_destination .. mount_prefix)
	if not mount_success then
		return {
			success = false,
			message = "cannot_unzip",
		}
	end
	-- copy archive content
	loveRecursivelyCopy(local_destination .. mount_prefix, local_destination)
	-- unmount
	love.filesystem.unmount(local_zipPath)

	if not NFS.getInfo(destination) then
		return {
			success = false,
			message = "cannot_unzip",
		}
	end

	-- delete zip
	NFS.remove(zipPath)
	return {
		success = true,
	}
end
local function replace_mod(mod_path)
	local appdata_dir = love.filesystem.getSaveDirectory()
	local temp_dir = appdata_dir .. "/" .. temp_folder

	local unzipped_dir = temp_dir .. "/" .. unzip_folder
	local mod_folder = NFS.getDirectoryItems(unzipped_dir)[1]

	if mod_folder then
		-- delete backup
		recursivelyDelete(temp_dir .. "/" .. stored_folder)
		-- rename current -> backup
		local backup_success = os.rename(mod_path, temp_dir .. "/" .. stored_folder)
		if not backup_success then
			return {
				success = false,
				message = "cannot_move_files",
			}
		end
		-- rename unzip -> current
		local replace_success = os.rename(unzipped_dir .. "/" .. mod_folder, mod_path)
		if not replace_success then
			return {
				success = false,
				message = "cannot_move_files",
			}
		end
		-- delete unzip
		NFS.remove(temp_dir .. "/" .. unzip_folder)
		return {
			success = true,
		}
	end

	return {
		success = false,
		message = "no_data_to_replace",
	}
end

--

(function()
	while true do
		local event = https_input:demand()
		if event then
			if event.check_update then
				local data = get_latest_releases(event.use_smods)
				data.check_update_complete = true
				https_output:push(data)
				goto continue
			end
			if event.download_release then
				local data = download_release(event.url, event.use_smods)
				data.download_release_complete = true
				https_output:push(data)
				goto continue
			end
			if event.unzip_archive then
				local data = unzip_archive()
				data.unzip_archive_complete = true
				https_output:push(data)
				goto continue
			end
			if event.replace_mod then
				local data = replace_mod(event.mod_path)
				data.replace_mod_complete = true
				https_output:push(data)
				goto continue
			end
			if event.install_release then
				https_output:push({ install_update_progress = true, message = "getting_releases" })
				local releases = get_latest_releases(event.use_smods)
				if not releases.success then
					https_output:push({ install_update_error = true, message = releases.message })
					goto continue
				end

				local release = releases[event.release_type]
				if not release then
					https_output:push({ install_update_error = true, message = "no_release" })
					goto continue
				end

				local release_url = release.zipball_url
				https_output:push({ install_update_progress = true, message = "downloading_release" })
				local download = download_release(release_url, event.use_smods)
				if not download.success then
					https_output:push({ install_update_error = true, message = download.message })
					goto continue
				end

				https_output:push({ install_update_progress = true, message = "unzipping_archive" })
				local unzip = unzip_archive()
				if not unzip.success then
					https_output:push({ install_update_error = true, message = unzip.message })
					goto continue
				end

				https_output:push({ install_update_progress = true, message = "installing_files" })
				local replace = replace_mod(event.mod_path)
				if not replace.success then
					https_output:push({ install_update_error = true, message = replace.message })
					goto continue
				end

				https_output:push({ install_update_success = true })
			end
		end
		::continue::
	end
end)()
