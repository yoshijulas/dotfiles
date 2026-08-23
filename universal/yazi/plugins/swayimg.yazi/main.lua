-- ~/.config/yazi/plugins/swayimg.yazi/main.lua
-- Swayimg Gallery Plugin for Yazi

local IMAGE_EXTENSIONS = {
	jpg = true, jpeg = true, png = true, gif = true, bmp = true,
	webp = true, svg = true, ico = true, tiff = true, tif = true,
	heic = true, heif = true, avif = true, crw = true, cr2 = true, nef = true,
	raf = true, exr = true, pnm = true, tga = true, xbm = true, qoi = true,
	dcm = true, ff = true
}

local get_target_paths = ya.sync(function()
	local active = cx.active
	local current = active.current
	local hovered = current.hovered
	local selected = active.selected

	local target_paths = {}
	local selection_kind = nil

	-- 1. Selections: Iterate pairs directly without next() to prevent poll C-error
	if selected then
		for _, f in pairs(selected) do
			local url = f.url or f
			table.insert(target_paths, tostring(url))
		end
		if #target_paths > 0 then
			selection_kind = "selection"
		end
	end

	-- 2. Hovered Directory: If no selections, check if a directory is hovered
	if #target_paths == 0 and hovered and hovered.cha.is_dir then
		table.insert(target_paths, tostring(hovered.url))
		selection_kind = "hovered directory"
	-- 3. Current Directory: Pass CWD for full recursive scanning
	elseif #target_paths == 0 then
		table.insert(target_paths, tostring(current.cwd))
		selection_kind = "folder"
	end

	return target_paths, selection_kind
end)

return {
	entry = function()
		ya.emit("escape", { visual = true })

		local target_paths, selection_kind = get_target_paths()

		if #target_paths == 0 then
			return ya.notify({
				title = "Swayimg Gallery",
				content = "No image files found in " .. (selection_kind or "folder"),
				level = "warn",
				timeout = 4,
			})
		end

		-- Build command: swayimg -g [paths...]
		local cmd = Command("swayimg"):arg("-g")
		for _, path in ipairs(target_paths) do
			cmd = cmd:arg(path)
		end

		local status, err = cmd:spawn():wait()

		if not status or not status.success then
			ya.notify({
				title = "Swayimg Gallery",
				content = string.format("Failed to open gallery: %s", status and status.code or err),
				level = "error",
				timeout = 5,
			})
		end
	end,
}
