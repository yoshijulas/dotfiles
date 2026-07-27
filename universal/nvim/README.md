---
title: Neovim Plugin & Keybind Guide
tags:
  - neovim
  - obsidian
  - cheatsheet
  - plugins
  - lazyvim
date: 2026-07-25
---

# 🚀 Neovim Plugin & Keybind Guide

An Obsidian reference note for your custom Neovim setup based on **LazyVim** with custom plugins, keybindings, and configurations.

---

## 🗂️ Table of Contents
- [[#📁 File Managers & Explorers]]
- [[#⚡ Navigation, Search & Grep]]
- [[#🐙 Git Integration & Diffing]]
- [[#✏️ Editing & Code Manipulation]]
- [[#⚙️ LSP, Autocompletion & Formatting]]
- [[#🚨 Diagnostics & Quickfix]]
- [[#🎨 UI, Syntax & Visuals]]
- [[#🦀 Rust Development]]
- [[#⚙️ Custom Utilities & Keymaps]]
- [[#🎉 Fun & Easter Eggs]]

---

## 📁 File Managers & Explorers

### 1. `fyler.nvim`
> [!info] **Why Use It?**
> A modern, lightweight file explorer — **like `oil.nvim`, but with a file tree view!** Provides intuitive directory buffer browsing and file tree navigation integrated with `mini.icons`.
* **Keybinds & Usages:**
  * `<leader>-` : Open Fyler explorer.

### 2. `yazi.nvim`
> [!info] **Why Use It?**
> Integrates **Yazi**, the blazing-fast terminal file manager, directly inside Neovim. Perfect for batch file manipulation, image previews, directory jumping, and shell-level file management without leaving Neovim.
* **Keybinds & Usages:**
  * `<leader>=` : Open Yazi focused at the current file (`n`, `v` modes).

### 3. `snacks.nvim` (Explorer & Utilities)
> [!info] **Why Use It?**
> A suite of high-performance QoL utilities for Neovim (pickers, explorer layout, smooth notifications, handling large files over 8MB without crashing).
* **Keybinds & Usages:**
  * `<leader>e` / `<leader>fE` : Open Snacks explorer picker.
  * Handles big files automatically by disabling heavy LSP/treesitter features.

---

## ⚡ Navigation, Search & Grep

> [!important] **Understanding Search Scopes: Root Dir vs. CWD**
> - **Root Dir (`root`)**: Auto-detected top-level project folder (containing `.git`, `Cargo.toml`, `package.json`, etc.). Best for standard project searching.
> - **CWD (`cwd`)**: Current working directory of Neovim. Useful when working in mono-repos or nested subdirectories.

### 🔍 Grep & Search Keybindings Breakdown

| Keybind | Action | Description & Usage | Scope |
| :--- | :--- | :--- | :--- |
| `<leader>/` or `<leader>sg` | **Grep (Root Dir)** | Live text search across all files in the project. | Project Root |
| `<leader>sG` | **Grep (CWD)** | Live text search across files starting from current working directory. | CWD |
| `<leader>sw` | **Search Word (Root)** | Greps for the word under the cursor across the project. | Project Root |
| `<leader>sW` | **Search WORD (Root)** | Greps for the whitespace-delimited WORD under cursor. | Project Root |
| `<leader>sw` / `<leader>sW` | **Search Selection** | *(In Visual Mode)* Greps for highlighted text selection across project. | Project Root |
| `<leader><space>` or `<leader>ff` | **Find Files (Root)** | Quick fuzzy lookup for filenames across the project. | Project Root |
| `<leader>fF` | **Find Files (CWD)** | Quick fuzzy lookup for filenames starting from CWD. | CWD |
| `<leader>fb` | **Find Buffers** | Fuzzy search through currently open buffers/tabs. | Open Buffers |
| `<leader>fr` | **Recent Files** | Search through recently opened files history. | History |
| `<leader>fc` | **Find Config** | Search files inside your Neovim config directory (`~/.config/nvim`). | Nvim Config |
| `<leader>sb` | **Search Buffer** | Fuzzy search lines inside the current active file buffer. | Current File |
| `<leader>st` | **Search TODOs** | Search all `TODO`, `FIXME`, `HACK` comments in project. | Project Root |
| `<leader>sd` | **Search Diagnostics** | Search LSP errors and warnings across the codebase. | Project Root |
| `<leader>sp` | **Search Pickers** | Open picker menu for custom searches. | All Pickers |

---

### 4. `flash.nvim`
> [!info] **Why Use It?**
> Replaces traditional searching and web motion plugins. Allows you to jump to any character or syntax tree node on the screen in 2-3 keystrokes.
* **Keybinds & Usages:**
  * `s` : Flash jump (type 2 letters, pick label to instantly teleport cursor).
  * `S` : Flash Treesitter selection (expand selection based on AST).
  * `r` / `R` : Remote Flash (operate on distant text objects without moving cursor).

### 5. `aerial.nvim`
> [!info] **Why Use It?**
> Code outline sidebar showing symbols, functions, classes, and structs in the current file for quick navigation in complex source files.
* **Keybinds & Usages:**
  * `<leader>cs` : Toggle Aerial symbol outline.
  * `{` / `}` : Jump to previous/next symbol.

### 6. `grug-far.nvim`
> [!info] **Why Use It?**
> An interactive multi-file search and replace tool powered by `ripgrep`. Shows live preview diffs as you edit match lines across the entire codebase.
* **Keybinds & Usages:**
  * `<leader>sr` : Open Grug-far search & replace panel.

---

## 🐙 Git Integration & Diffing

### 7. `neogit`
> [!info] **Why Use It?**
> A powerful Magit clone for Neovim. Provides an interactive status buffer to stage hunks, commit, push, pull, rebase, and branch without touching external CLI tools.
* **Keybinds & Usages:**
  * `<leader>gn` : Open Neogit status UI.

### 8. `codediff.nvim`
> [!info] **Why Use It?**
> High-precision side-by-side side diff viewer, seamlessly integrated as the primary diff viewer inside `neogit`.
* **Keybinds & Usages:**
  * `:CodeDiff` : Launch side-by-side diff view.
  * Integrated directly inside Neogit diff reviews.

### 9. `gitsigns.nvim`
> [!info] **Why Use It?**
> Displays Git status signs (+/-/~) in the sign column, highlights modified lines, and lets you preview/stage/reset individual hunks inline.
* **Keybinds & Usages:**
  * `]h` / `[h` : Jump to Next / Previous Git hunk.
  * `<leader>ghp` : Preview hunk inline.
  * `<leader>ghs` : Stage current hunk.
  * `<leader>ghr` : Reset/discard current hunk.
  * `<leader>gbl` : Blame current line.

---

## ✏️ Editing & Code Manipulation

### 10. `treesj`
> [!info] **Why Use It?**
> Intelligent code block splitting/joining based on Treesitter AST syntax trees (arrays, objects, function parameters, dictionaries).
* **Keybinds & Usages:**
  * `<leader>m` : Toggle split / join on current code block.
  * `<leader>M` : Toggle split / join recursively for nested blocks.

### 11. `dial.nvim`
> [!info] **Why Use It?**
> Enhanced increment/decrement functionality (`<C-a>` and `<C-x>`) that works on booleans (`true`/`false`), dates (`2026-07-25`), weekdays, constants, and hex colors.
* **Keybinds & Usages:**
  * `<C-a>` : Increment target under cursor.
  * `<C-x>` : Decrement target under cursor.

### 12. `mini.surround`
> [!info] **Why Use It?**
> Add, delete, replace, or find surrounding pairs of quotes, brackets, parentheses, or HTML tags around selections or text objects.
* **Keybinds & Usages:**
  * `gsa<motion><char>` : Add surround (e.g., `gsaiw"` surrounds word in quotes).
  * `gsd<char>` : Delete surround (e.g., `gsd"` deletes surrounding quotes).
  * `gsr<old><new>` : Replace surround (e.g., `gsr"'` replaces `"` with `'`).
  * `gsf` / `gsF` : Find surrounding pair right / left.
  * `gsh` : Highlight surrounding pair.

### 13. `mini.ai` (Extended Text Objects)
> [!info] **Why Use It?**
> Expands Neovim's text objects to target arguments (`a`), functions (`f`), classes (`c`), brackets (`b`/`B`), quotes (`q`/`Q`), and tags (`t`). Works with operators like `d` (delete), `c` (change), `v` (select), `y` (yank).

* **Text Object Aliases:**
  * `a` : **Argument / Parameter** (e.g., `cia` changes inside function argument).
  * `b` : **Balanced brackets** — Matches any `()`, `[]`, `{}` pair. (e.g., `dib` deletes inside nearest bracket).
  * `B` : **Balanced Block / Curly Brackets** — Specifically targets `{}` curly brace blocks. (e.g., `ciB` changes inside `{}` block).
  * `q` : **Quotes** — Matches any `"`, `'`, `` ` `` quotes. (e.g., `ciq` changes inside quote).
  * `Q` : **Quotes Alias** — Specifically targets quote strings across multiline / string literals. (e.g., `daQ` deletes around quote string).
  * `f` : **Function** call / definition (e.g., `vaF` selects around function).
  * `c` : **Class** / type definition.
  * `t` : **HTML / XML Tag** (e.g., `cit` changes inside `<tag>content</tag>`).

### 14. `mini.comment` & `ts-comments.nvim` & `nvim-ts-context-commentstring`
> [!info] **Why Use It?**
> Smart multi-language commenting. Automatically handles embedded languages (e.g., JSX inside JS, HTML inside Vue/Svelte) using Treesitter context.
* **Keybinds & Usages:**
  * `gcc` : Toggle comment on current line.
  * `gc` : Toggle comment over motion / visual selection.

### 15. `mini.pairs`
> [!info] **Why Use It?**
> Automatically inserts matching pairs of `()`, `[]`, `{}`, `""`, `''` as you type and balances deletion when backspacing.

---

## ⚙️ LSP, Autocompletion & Formatting

### 16. `nvim-lspconfig`, `mason.nvim`, `mason-lspconfig.nvim`
> [!info] **Why Use It?**
> The core engine for language intelligence (autocompletion, go-to-definition, type hover info, symbol renaming, refactoring). Mason manages binary LSP server installations.
* **Keybinds & Usages:**
  * `gd` : Go to definition.
  * `gr` : Go to references.
  * `K` : Hover documentation popover.
  * `<leader>cr` : Rename symbol project-wide.
  * `<leader>ca` : Code actions (fixes, imports).

### 17. `blink.cmp` & `friendly-snippets`
> [!info] **Why Use It?**
> Next-generation, Rust-based high performance completion engine. Loads instantly with preconfigured snippets for all major programming languages.
* **Keybinds & Usages:**
  * `<Tab>` / `<S-Tab>` : Navigate completion menu items / snippet fields.
  * `<C-space>` : Trigger completion menu manually.
  * `<C-y>` : Confirm completion selection.

### 18. `conform.nvim`
> [!info] **Why Use It?**
> Universal auto-formatter supporting Prettier, Stylua, Biome, Rustfmt, and more.
* **Keybinds & Usages:**
  * `<leader>cf` : Format current buffer manually.
  * Formats automatically on save (if enabled in LazyVim).

### 19. `nvim-lint`
> [!info] **Why Use It?**
> Asynchronous linter integration for project diagnostics beyond standard LSP servers.

### 20. `lazydev.nvim`
> [!info] **Why Use It?**
> Full IDE autocompletion, type signatures, and documentation for Neovim Lua API (`vim.api.*`, `vim.opt.*`, plugin modules) when editing configuration files.

---

## 🚨 Diagnostics & Quickfix

### 21. `trouble.nvim`
> [!info] **Why Use It?**
> Pretty list for diagnostics, errors, warnings, LSP references, location lists, and quickfix lists.
* **Keybinds & Usages:**
  * `<leader>xx` : Diagnostics (Trouble mode).
  * `<leader>xX` : Buffer Diagnostics (Trouble mode).
  * `<leader>cs` : Symbols (Trouble mode).
  * `<leader>cl` : LSP Definitions / References.

### 22. `quicker.nvim` & Quickfix Workflow (`<C-q>`)
> [!info] **Why Use It?**
> Enhances Neovim quickfix and location lists by making them fully editable, adding syntax highlighting, and allowing context expanding/collapsing.

> [!tip] **The Grep ➔ Quickfix (`<C-q>`) Workflow**
> 1. Run a search/grep using `<leader>/` or `<leader>sg`.
> 2. Inside the search picker popup, press **`<C-q>`** (or `<M-q>`) to send all search results directly into Neovim's **Quickfix List**.
> 3. `quicker.nvim` automatically formats the quickfix window.
> 4. Toggle the quickfix list anytime with `<leader>xq`.
> 5. Expand or collapse surrounding context lines to inspect code without opening files!

* **Keybinds & Usages:**
  * `<C-q>` *(Inside Search/Grep Picker)* : Export search match results to Quickfix List.
  * `<leader>xq` : Toggle Quickfix list window.
  * `<leader>xl` : Toggle Location list window.
  * `>` *(Inside Quickfix Window)* : Expand context lines (show code above & below match).
  * `<` *(Inside Quickfix Window)* : Collapse context lines.

---

## 🎨 UI, Syntax & Visuals

### 23. `rainbow-delimiters.nvim` & `indent-blankline.nvim`
> [!info] **Why Use It?**
> Colors matching pairs of parentheses, brackets, and braces in rainbow hues while highlighting active scope indent lines. Skip large files (>100KB) for performance.
* **Keybinds & Usages:**
  * `<leader>u(` : Toggle rainbow delimiters for current buffer.
  * `<leader>u)` : Toggle rainbow delimiters globally.

### 24. `nvim-treesitter` & `nvim-treesitter-context`
> [!info] **Why Use It?**
> AST-based syntax parser for ultra-accurate code highlighting and indentation. `treesitter-context` pins current function/class signature to top of window during scroll.

### 25. `noice.nvim` & `nui.nvim`
> [!info] **Why Use It?**
> Redesigns command line, messages, and notification popups into sleek floating UI windows.

### 26. `bufferline.nvim` & `lualine.nvim`
> [!info] **Why Use It?**
> `bufferline` displays open files as tabs at the top; `lualine` displays status info (Git branch, LSP status, line counts, mode) at the bottom.
* **Keybinds & Usages:**
  * `<S-h>` / `<S-l>` : Navigate to previous / next buffer tab.
  * `<leader>bd` : Delete current buffer.

### 27. `todo-comments.nvim`
> [!info] **Why Use It?**
> Highlights comments like `TODO`, `FIXME`, `BUG`, `HACK`, `NOTE` with vivid colors and icons.
* **Keybinds & Usages:**
  * `]t` / `[t` : Jump to Next / Previous TODO comment.
  * `<leader>st` : Search all TODO comments across project.

### 28. `persistence.nvim`
> [!info] **Why Use It?**
> Session manager that restores open buffers, tabs, and window split layouts when launching Neovim.
* **Keybinds & Usages:**
  * `<leader>qs` : Restore session for current directory.
  * `<leader>ql` : Restore last session.

### 29. `mini.hipatterns` & `mini.icons`
> [!info] **Why Use It?**
> `hipatterns` highlights color codes (e.g. `#FF5733`) with real inline background colors; `mini.icons` provides fast devicon icons across plugins.

### 30. Theme Colorschemes
> [!info] **Why Use It?**
> Pre-installed high contrast aesthetic themes.
* **Active Default:** `everforest` (medium background, high contrast UI, italics enabled).
* **Available Alternatives:** `sonokai` (espresso style), `catppuccin`, `tokyonight`.

---

## 🦀 Rust Development

### 31. `rustaceanvim` & `crates.nvim`
> [!info] **Why Use It?**
> Supercharges Rust development with custom `rust-analyzer` settings, background `clippy` checks (including pedantic & nursery lints), inlay hints, runnable targets, and `crates.nvim` dependency management inside `Cargo.toml`.
* **Keybinds & Usages:**
  * `<leader>cR` : Rust code actions / runnables.
  * Hover over `Cargo.toml` dependencies to inspect crate versions.

---

## ⚙️ Custom Utilities & Keymaps

### Custom Keymaps (in `lua/config/keymaps.lua`)

| Mode | Keybind | Action | Why Use It? |
| :--- | :--- | :--- | :--- |
| **Visual (`x`)** | `p` | `"_dP` | **Paste over selection without losing yanked buffer**. Prevents replaced text from overwriting clipboard register. |
| **Normal (`n`)** | `<leader>cp` | Copy file path | Copies current file's path relative to project root to system clipboard. |
| **Visual (`v`)** | `<leader>cp` | Copy file path + line range | Copies file path with line numbers (e.g. `src/main.rs:12-25`) for easy sharing. |

---

## 🎉 Fun & Easter Eggs

### 32. `cellular-automaton.nvim`
> [!info] **Why Use It?**
> A matrix-style falling text animation inside Neovim when code fails to compile or when you just need a break.
* **Keybinds & Usages:**
  * `<leader>fml` : Trigger `make_it_rain` animation on current code buffer!

---

> [!tip] **Pro-Tip in Obsidian**
> Keep this file in your Obsidian vault root or `cheatsheets/` folder to quickly reference your mappings using Obsidian's search (`Ctrl+O` / `Cmd+O`) or graph view!
