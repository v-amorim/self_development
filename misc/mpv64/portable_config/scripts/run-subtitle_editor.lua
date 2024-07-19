--[[
    run-subtitle_editor.lua - mpv script to run a Python script on the currently loaded subtitle file

	This script runs a Python script on the currently loaded subtitle file. The Python script path is read from a configuration file.
]]
--

local mp = require("mp")

function read_script_conf()
	local conf_file_path = mp.command_native({ "expand-path", "~~/script-opts/run_subtitle_editor.conf" })
	local file = assert(io.open(conf_file_path, "r"))
	local python_script_path = file:read("*line")
	file:close()
	return python_script_path
end

function get_external_subtitle_path()
	local tracks = mp.get_property_native("track-list")
	for _, track in ipairs(tracks) do
		if track.type == "sub" and track.external == true and track.selected == true then
			return track["external-filename"]
		end
	end
	return nil
end

function run_python_script()
	local python_script_path = read_script_conf()
	local subtitle_path = get_external_subtitle_path()

	if not python_script_path then
		mp.msg.error("Failed to read Python script path from script.conf")
		return
	end

	if subtitle_path then
		local command = string.format('python "%s" "%s"', python_script_path, subtitle_path)
		mp.msg.info("Running Python script: " .. command)
		os.execute(command)
	else
		mp.msg.warn("No external subtitle file is currently loaded.")
	end
end

mp.add_key_binding("F7", "run_subtitle_editor", run_python_script)
