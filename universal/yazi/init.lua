require("git"):setup({
	-- Order of status signs showing in the linemode
	order = 1500,
})

require("spot"):setup({
	metadata_section = {
		enable = true,
		-- Show a unique file hash in the spot popup
		hash_cmd = "xxhsum",
		hash_filesize_limit = 10 * 1024, -- in MB, set 0 to disable
		relative_time = true,
		time_format = "%Y-%m-%d %H:%M",
		show_compression = true,
	},
})
