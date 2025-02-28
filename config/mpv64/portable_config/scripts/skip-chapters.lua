require("mp.options")
local opt = {
	patterns = {
		-- Opening variants
		"OP",
		"[Oo]pening$",
		"^[Oo]pening:",
		"[Oo]pening [Cc]redits",
		"[Ii]ntro",
		-- Ending variants
		"ED",
		"[Ee]nding$",
		"[Ee]nding",
		"^[Ee]nding:",
		"[Ee]nding [Cc]redits",
		"[Cc]redits",
		-- Extra variants
		-- "[Pp]review$",
	},
}
read_options(opt)

local chapterSkippingEnabled = true

function toggleCheckChapter()
	chapterSkippingEnabled = not chapterSkippingEnabled
	mp.osd_message("Chapter skipping " .. (chapterSkippingEnabled and "enabled" or "disabled"))
end

function check_chapter(_, chapter)
	if not chapterSkippingEnabled or not chapter then
		return
	end
	for _, p in pairs(opt.patterns) do
		if string.match(chapter, p) then
			skip_time = mp.get_property_number("time-pos")
			mp.command('show-text "Skipping chapter: ' .. chapter .. '"')
			mp.command("no-osd add chapter 1")
			mp.command('show-text "Skipping chapter: ' .. chapter .. '"')
			return
		end
	end
end

mp.observe_property("chapter-metadata/by-key/title", "string", check_chapter)
mp.add_key_binding("", "chapter-skip", toggleCheckChapter)
