# Swayimg & Yazi Setup Guide & Keybindings Cheatsheet

A complete reference for your custom **Swayimg** configuration and **Yazi** integration.

---

## 🚀 Key Features

* **🛡️ Crash-Proof Protection:** Automatically filters out non-image files (`.log`, font files, binaries, `.solv`, `.txt`) before decoding to prevent C++ vector crashes.
* **📂 Automatic Recursive Folder Scanning:** Opening any directory automatically scans all subfolders recursively.
* **🖼️ Grid Fill Mode:** Thumbnails fill the grid squares cleanly without letterboxing or empty borders (`aspect = "fill"`).
* **⚡ High-Performance Caching:** Pre-renders 5,000 thumbnails in RAM and caches them to disk (`~/.cache/swayimg/`) for instant scrolling.
* **📋 Wayland Clipboard Integration:** Copy file or folder paths directly to your clipboard.

---

## ⌨️ Swayimg Keybindings Reference

### 1. Navigation & Scrolling

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| **`g`** / **`Home`** | **Jump to Top** | Selects the first image in the gallery |
| **`Shift + G`** / **`End`** | **Jump to Bottom** | Selects the last image in the gallery |
| **`Shift + Down`** / **`Shift + J`** / **`Ctrl + d`** | **Scroll View Down** | Scrolls down 1 full screen/page view |
| **`Shift + Up`** / **`Shift + K`** / **`Ctrl + u`** | **Scroll View Up** | Scrolls up 1 full screen/page view |
| **`Enter`** | **Full View Mode** | View selected image in full resolution |
| **`Esc`** | **Exit** | Close Swayimg and return to terminal |

---

### 2. Folder Filtering & Hiding (Temporary in RAM)

*(None of these commands delete files from your drive; they only hide them during the active session).*

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| **`i`** | **Ignore Exact Folder** | Hides images in the current image's exact folder *(keeps subfolders and parents)* |
| **`Shift + I`** | **Ignore Folder & Subfolders** | Hides the current folder **AND all of its child subfolders** |
| **`Ctrl + Shift + I`** | **Ignore Parent Folder** | Hides the **parent folder** and all of its contents |

---

### 3. Interactive Sorting Modes

| Keybinding | Sorting Mode | Description |
| :--- | :--- | :--- |
| **`Alt + m`** / **`Ctrl + m`** | **Modification Date** | Sort by file modification date/time |
| **`Alt + s`** | **File Size** | Sort by file size |
| **`Alt + n`** | **Numeric Name** | Sort by natural numbers (`1, 2, 3, 10, 100...`) |
| **`Alt + a`** | **Alphabetical** | Sort alphabetically by filename |
| **`Alt + r`** | **Random Shuffle** | Randomize image order |
| **`Alt + Shift + R`** | **Toggle Reverse** | Reverses the current sort order *(e.g. newest date first)* |

---

### 4. Actions & File Operations

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| **`c`** | **Copy File Path** | Copies the absolute file path to Wayland clipboard (`wl-copy`) |
| **`Shift + C`** | **Copy Folder Path** | Copies the parent folder path to Wayland clipboard |
| **`o`** | **Open Folder** | Opens the parent folder in your default file manager (`xdg-open`) |

---

## 🗂️ Yazi Integration Shortcuts

Inside **Yazi File Manager**:

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| **`g` `i`** | **Swayimg Yazi Plugin** | Opens Swayimg gallery for **selected files**, **hovered folder**, or **current directory recursively** |
| **`g` `I`** | **Swayimg Standalone Window** | Opens `swayimg -g .` in a separate standalone window |

---

## 📁 Configuration File Locations

* **Swayimg Custom Lua Config:** [`~/.config/swayimg/init.lua`](file:///home/yoshi/.config/swayimg/init.lua)
* **Yazi Swayimg Plugin:** [`~/.config/yazi/plugins/swayimg.yazi/main.lua`](file:///home/yoshi/.config/yazi/plugins/swayimg.yazi/main.lua)
* **Yazi Keymaps Config:** [`~/.config/yazi/keymap.toml`](file:///home/yoshi/.config/yazi/keymap.toml)
