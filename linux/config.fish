# Theme
fish_config theme choose catppuccin-macchiato

# PATH (replaces all the zsh `export PATH=...` juggling)
fish_add_path $HOME/.cargo/bin $HOME/.bun/bin $HOME/.local/bin $HOME/.dotnet/tools

# pnpm
set -gx PNPM_HOME $HOME/.local/share/pnpm
fish_add_path $PNPM_HOME/bin

# Env vars
set -gx EDITOR nvim
set -gx _JAVA_AWT_WM_NONREPARENTING 1   # fix for java?
set -gx XDG_MENU_PREFIX arch-           # fix dolphin not having open with
set -gx DXVK_HUD compiler               # display compiling shader globally with proton
set -gx SCCACHE_BASEDIR $HOME

# Aliases (no args needed)
alias tree="eza --tree --icons"
alias u-seagate="systemd-mount --unmount /media/seagate"
alias u-adata="systemd-mount --unmount /media/adata"
alias pacdiff='DIFFPROG="nvim -d" pacdiff -s'
alias fishconfig="nvim ~/.config/fish/config.fish"
# Nix
if test -x /run/current-system/sw/bin/app-manager
    alias app-manager /run/current-system/sw/bin/app-manager
end

function la
    eza --icons=always -l --all --color=always $argv
end
function ls
    eza --icons=always --color=always $argv
end
function cat
    bat $argv
end
function grep
    rg --color=auto $argv
end

# Yazi shell wrapper
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	command rm -f -- "$tmp"
end

# fzf
fzf --fish | source
set -gx FZF_DEFAULT_COMMAND "fd --follow --hidden --exclude .git --exclude dosdevices --exclude drive_c --exclude compatdata --exclude pfx --exclude proc --exclude sys --exclude dev --color=always"
set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git --exclude dosdevices --exclude drive_c --exclude compatdata --exclude pfx --exclude proc --exclude sys --exclude dev --color=always'
set -gx FZF_CTRL_T_COMMAND "fd --type file --follow --hidden --exclude .git --exclude dosdevices --exclude drive_c --exclude compatdata --exclude pfx --exclude proc --exclude sys --exclude dev --color=always"
set -gx FZF_DEFAULT_OPTS "--ansi --walker-skip=.git,dosdevices,drive_c,compatdata,pfx,proc,sys,dev"

# Tool inits (guarded: skipped if the tool isn't installed)
command -q zoxide; and zoxide init fish | source
command -q mise; and mise activate fish | source
command -q starship; and starship init fish | source
command -q jj; and COMPLETE=fish jj | source

# secrets live outside the repo in ~/.fish_secrets (never committed, fish syntax: set -gx VAR value)
if test -f $HOME/.fish_secrets
    source $HOME/.fish_secrets
end

# dcg: warn if hook was silently removed from Claude Code settings
if command -q dcg; and command -q jq; and test -f $HOME/.claude/settings.json
    if not jq -e '.hooks.PreToolUse[]? | select(.hooks[]?.command | test("dcg\"?$"))' $HOME/.claude/settings.json >/dev/null 2>&1
        printf '\033[1;33m[dcg] Hook missing from ~/.claude/settings.json — run: dcg install\033[0m\n'
    end
end

fish_hybrid_key_bindings
