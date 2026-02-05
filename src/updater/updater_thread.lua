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

-- TODO: checks everywhere

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
local function get_fetcher(use_smods)
	return use_smods and require("SMODS.https") or require("https")
end

--

local function get_latest_releases(use_smods)
	local fetcher = get_fetcher(use_smods)
	if not fetcher then
		return {
			success = false,
			code = 0,
			cannot_fetch = true,
		}
	end
	local code, response = fetcher.request("https://api.github.com/repos/SleepyG11/HandyBalatro/releases?per_page=5", {
		method = "GET",
		headers = {
			["User-Agent"] = "Mozilla/5.0",
		},
	})
	if code == 200 then
		local body = json.decode(response)

		local latest_stable, latest_pre_release
		for _, release in ipairs(body) do
			if release.prerelease and not latest_pre_release then
				latest_pre_release = release
			elseif not release.prerelease and not latest_stable then
				latest_stable = release
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
			code = code,
			response = response,
		}
	end
end

--

local function download_release(url, use_smods)
	local fetcher = get_fetcher(use_smods)
	if not fetcher then
		return {
			success = false,
			code = 0,
			cannot_fetch = true,
		}
	end
	local code, response = fetcher.request(url, {
		method = "GET",
		headers = {
			["User-Agent"] = "Mozilla/5.0",
		},
	})
	if code == 200 then
		local appdata_dir = love.filesystem.getSaveDirectory()
		local temp_dir = appdata_dir .. "/" .. temp_folder
		recursivelyDelete(temp_dir)
		NFS.createDirectory(temp_dir)
		NFS.write(temp_dir .. "/" .. zip_file, response)
		return {
			success = true,
		}
	else
		return {
			success = false,
			code = code,
			response = response,
		}
	end
end
local function unzip_archive()
	local appdata_dir = love.filesystem.getSaveDirectory()
	local temp_dir = appdata_dir .. "/" .. temp_folder

	local zipPath = temp_dir .. "/" .. zip_file
	local destination = temp_dir .. "/" .. unzip_folder

	recursivelyDelete(destination)
	NFS.createDirectory(destination)

	if love.system.getOS() == "Windows" then
		os.execute(string.format('powershell -Command "Expand-Archive -Force \\"%s\\" \\"%s\\""', zipPath, destination))
		return {
			success = true,
		}
	else
		os.execute(string.format('unzip -o "%s" -d "%s"', zipPath, destination))
		return {
			success = true,
		}
	end
end
local function replace_mod(mod_path, delete_old)
	local appdata_dir = love.filesystem.getSaveDirectory()
	local temp_dir = appdata_dir .. "/" .. temp_folder

	local unzipped_dir = temp_dir .. "/" .. unzip_folder
	local mod_folder = NFS.getDirectoryItems(unzipped_dir)[1]

	if mod_folder then
		os.rename(mod_path, mod_path .. temp_suffix)
		os.rename(unzipped_dir .. "/" .. mod_folder, mod_path)
		if delete_old then
			recursivelyDelete(mod_path)
		else
			os.rename(mod_path .. temp_suffix, temp_dir .. "/" .. stored_folder)
		end
		NFS.remove(temp_dir .. "/" .. zip_file)
		NFS.remove(temp_dir .. "/" .. unzip_folder)
		return {
			success = true,
		}
	end

	return {
		success = false,
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
				return
			end
			if event.download_release then
				local data = download_release(event.url, event.use_smods)
				data.download_release_complete = true
				https_output:push(data)
				return
			end
			if event.unzip_archive then
				local data = unzip_archive()
				data.unzip_archive_complete = true
				https_output:push(data)
				return
			end
			if event.replace_mod then
				local data = replace_mod(event.mod_path, event.delete_old)
				data.replace_mod_complete = true
				https_output:push(data)
				return
			end
		end
	end
end)()
