-- ~/.config/swayimg/init.lua
-- Custom Swayimg Config & Crash Prevention

-- 1. Supported Pure Image Extensions List (Fonts & logs excluded to prevent decoder crashes)
local valid_exts = {
  jpg=true, jpeg=true, jxl=true, jp2=true, png=true, gif=true, svg=true,
  webp=true, heif=true, heic=true, avif=true, tiff=true, tif=true,
  crw=true, cr2=true, nef=true, raf=true, exr=true,
  bmp=true, pnm=true, tga=true, xbm=true, qoi=true, dcm=true, ff=true
}

-- 2. Automatically Filter Out Non-Image Files
swayimg.on_initialized(function()
  local all_entries = swayimg.imagelist.get()
  local to_remove = {}
  for _, entry in ipairs(all_entries) do
    local ext = entry.path:match("%.([^%.]+)$")
    if not ext or not valid_exts[ext:lower()] then
      table.insert(to_remove, entry.path)
    end
  end
  if #to_remove > 0 then
    swayimg.imagelist.remove(to_remove)
  end
end)

-- 3. Mode & Grid Fill Options
swayimg.mode = "gallery"
swayimg.gallery.aspect = "fill"          -- Fill thumbnail grid (no letterboxing)
swayimg.gallery.thumb_size = 200         -- Thumbnail size in pixels
swayimg.gallery.padding_size = 8         -- Padding between grid cells
swayimg.gallery.preload = true           -- Preload thumbnails upfront
swayimg.gallery.cache = 5000             -- Large cache for fast rendering
swayimg.gallery.pstore = true            -- Save thumbnail cache to disk (~/.cache/swayimg/)
swayimg.imagelist.recursive = true       -- Recursively scan subfolders automatically!

-- 4. Default Sorting Options (Available: "numeric", "alpha", "mtime", "size", "random")
swayimg.imagelist.order = "numeric"      -- Default sort by natural numeric name (1, 2, 10, etc.)
swayimg.imagelist.reverse = false        -- Reverse order toggle

-- 5. Interactive Sorting Keybindings (Using Alt- modifier)
local function sort_by(mode, name)
  swayimg.imagelist.order = mode
  swayimg.gallery.reload()
  swayimg.text.status = "Sorted by " .. name
end

swayimg.gallery.on_key("Alt-m", function() sort_by("mtime", "Modification Date") end)
swayimg.gallery.on_key("Ctrl-m", function() sort_by("mtime", "Modification Date") end)

swayimg.gallery.on_key("Alt-s", function() sort_by("size", "File Size") end)

swayimg.gallery.on_key("Alt-n", function() sort_by("numeric", "Numeric Name") end)

swayimg.gallery.on_key("Alt-a", function() sort_by("alpha", "Alphabetical Name") end)

swayimg.gallery.on_key("Alt-r", function() sort_by("random", "Random Shuffle") end)

swayimg.gallery.on_key("Alt-Shift-R", function()
  swayimg.imagelist.reverse = not swayimg.imagelist.reverse
  swayimg.gallery.reload()
  swayimg.text.status = "Sort Reversed: " .. tostring(swayimg.imagelist.reverse)
end)

-- 6. Vim-style Jump to Top ('g' or 'Home') and Bottom ('Shift-G' or 'End')
swayimg.gallery.on_key("g", function() swayimg.gallery.select("first") end)
swayimg.gallery.on_key("Home", function() swayimg.gallery.select("first") end)
swayimg.gallery.on_key("Shift-G", function() swayimg.gallery.select("last") end)
swayimg.gallery.on_key("End", function() swayimg.gallery.select("last") end)

-- 7. Keybinding: Ignore / Remove ONLY Current Folder (Press 'i')
local function ignore_current_folder()
  local img = swayimg.gallery.get_image()
  if not img then return end

  local dir = img.path:match("(.+)/[^/]+")
  if not dir then return end

  local to_remove = {}
  for _, entry in ipairs(swayimg.imagelist.get()) do
    local entry_dir = entry.path:match("(.+)/[^/]+")
    if entry_dir == dir then
      table.insert(to_remove, entry.path)
    end
  end

  swayimg.imagelist.remove(to_remove)
  swayimg.text.status = "Ignored exact folder: " .. dir
end

swayimg.gallery.on_key("i", ignore_current_folder)

-- 8. Keybinding: Ignore / Remove Current Folder AND ALL ITS SUBFOLDERS (Press 'Shift-I' or 'I')
local function ignore_folder_and_children()
  local img = swayimg.gallery.get_image()
  if not img then return end

  local dir = img.path:match("(.+)/[^/]+")
  if not dir then return end

  local to_remove = {}
  for _, entry in ipairs(swayimg.imagelist.get()) do
    if entry.path:sub(1, #dir) == dir then
      table.insert(to_remove, entry.path)
    end
  end

  swayimg.imagelist.remove(to_remove)
  swayimg.text.status = "Ignored folder & subfolders: " .. dir
end

swayimg.gallery.on_key("Shift-I", ignore_folder_and_children)

-- 9. Keybinding: Ignore / Remove PARENT Folder & All its contents (Press 'Ctrl-Shift-I')
local function ignore_parent_folder()
  local img = swayimg.gallery.get_image()
  if not img then return end

  local dir = img.path:match("(.+)/[^/]+")
  if not dir then return end

  local parent_dir = dir:match("(.+)/[^/]+")
  if not parent_dir then return end

  local to_remove = {}
  for _, entry in ipairs(swayimg.imagelist.get()) do
    if entry.path:sub(1, #parent_dir) == parent_dir then
      table.insert(to_remove, entry.path)
    end
  end

  swayimg.imagelist.remove(to_remove)
  swayimg.text.status = "Ignored parent folder: " .. parent_dir
end

swayimg.gallery.on_key("Ctrl-Shift-I", ignore_parent_folder)
swayimg.gallery.on_key("Ctrl-Shift-i", ignore_parent_folder)

-- 10. Keybinding: Page Down / Page Up (Scroll Full View)
swayimg.gallery.on_key("Shift-Down", function() swayimg.gallery.select("pgdown") end)
swayimg.gallery.on_key("Shift-Up", function() swayimg.gallery.select("pgup") end)
swayimg.gallery.on_key("Shift-J", function() swayimg.gallery.select("pgdown") end)
swayimg.gallery.on_key("Shift-K", function() swayimg.gallery.select("pgup") end)
swayimg.gallery.on_key("Ctrl-d", function() swayimg.gallery.select("pgdown") end)
swayimg.gallery.on_key("Ctrl-u", function() swayimg.gallery.select("pgup") end)

-- 11. Keybinding: Copy Image Path to Clipboard (Press 'c')
swayimg.gallery.on_key("c", function()
  local img = swayimg.gallery.get_image()
  if img then
    os.execute("wl-copy " .. string.format("%q", img.path))
    swayimg.text.status = "Copied path: " .. img.path
  end
end)

-- 12. Keybinding: Copy Parent Folder Path to Clipboard (Press 'Shift-C')
swayimg.gallery.on_key("Shift-C", function()
  local img = swayimg.gallery.get_image()
  if img then
    local dir = img.path:match("(.+)/[^/]+")
    if dir then
      os.execute("wl-copy " .. string.format("%q", dir))
      swayimg.text.status = "Copied folder path: " .. dir
    end
  end
end)

-- 13. Keybinding: Open Folder in System File Manager (Press 'o')
swayimg.gallery.on_key("o", function()
  local img = swayimg.gallery.get_image()
  if img then
    local dir = img.path:match("(.+)/[^/]+")
    if dir then
      os.execute("xdg-open " .. string.format("%q", dir) .. " &")
      swayimg.text.status = "Opened folder: " .. dir
    end
  end
end)
