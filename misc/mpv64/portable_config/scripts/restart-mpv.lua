local utils = require("mp.utils")

local last_file_path = nil

function restart_mpv()
	-- Save the current file path before restarting
	last_file_path = mp.get_property("path")

	mp.command_native({ "quit" })

	local args = {}
	if last_file_path then
		args.args = { "mpv", last_file_path }
	else
		args.args = { "mpv" }
	end

	utils.subprocess_detached(args)
end

mp.add_key_binding("F5", "restart-mpv", restart_mpv)
