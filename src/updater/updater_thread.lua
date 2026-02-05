require("love.system")
require("love.filesystem")
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
	if use_smods then
		sendDebugMessage = sendDebugMessage or function() end
		arg = args or {}
		require("love.system")
	end
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
		recursivelyDelete(temp_folder)
		love.filesystem.createDirectory(temp_folder)
		love.filesystem.write(temp_folder .. "/" .. zip_file, response)
		return {
			success = true,
		}
	else
		https_output:push({ log = true, message = "we fail" })
		return {
			success = false,
			code = code,
			response = response,
		}
	end
end
local function unzip_archive()
	local appdataDir = love.filesystem.getSaveDirectory()
	recursivelyDelete(appdataDir .. "/" .. temp_folder .. "/" .. unzip_folder)
	love.filesystem.createDirectory(temp_folder .. "/" .. unzip_folder)

	local zipPath = appdataDir .. "/" .. temp_folder .. "/" .. zip_file
	local destination = appdataDir .. "/" .. temp_folder .. "/" .. unzip_folder

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
	local appdataDir = love.filesystem.getSaveDirectory()
	local unzippedDir = appdataDir .. "/" .. temp_folder .. "/" .. unzip_folder
	local mod_folder = NFS.getDirectoryItems(unzippedDir)[1]

	if mod_folder then
		os.rename(mod_path, mod_path .. temp_suffix)
		os.rename(unzippedDir .. "/" .. mod_folder, mod_path)
		if delete_old then
			recursivelyDelete(mod_path)
		else
			os.rename(mod_path .. temp_suffix, appdataDir .. "/" .. temp_folder .. "/" .. stored_folder)
		end
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
