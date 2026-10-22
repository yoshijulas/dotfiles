-- NixOS: Mason can't install working binaries here, so never try.
-- LSPs/formatters come from nixpkgs (environment.systemPackages) instead.
-- Everywhere else (CachyOS, ...) this file is a no-op and Mason works as usual.
local function is_nixos()
  local f = io.open("/etc/os-release", "r")
  if f then
    local s = f:read("*a")
    f:close()
    if s and s:match("ID=nixos") then
      return true
    end
  end
  return false
end

if not is_nixos() then
  return {}
end

return {
  { "mason-org/mason.nvim", enabled = false },
  { "mason-org/mason-lspconfig.nvim", enabled = false },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", enabled = false },
}
