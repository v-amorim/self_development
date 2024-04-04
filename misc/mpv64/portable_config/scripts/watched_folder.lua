local utils = require "mp.utils"

local subfolder = "watched"
local previousFilePath = nil

function movePreviousFile()
    if previousFilePath then
        local thisFolder, _ = utils.split_path(previousFilePath)
        local destFolder = utils.join_path(thisFolder, subfolder)

        local args = {'cmd.exe', '/C', 'md', destFolder ,'&','move', previousFilePath, destFolder}
        utils.subprocess({args = args, playback_only = false})
        previousFilePath = nil
    end
end

function recordPreviousFile()
    previousFilePath = mp.get_property("path")
end

mp.register_event("start-file", movePreviousFile)
mp.register_event("file-loaded", recordPreviousFile)
