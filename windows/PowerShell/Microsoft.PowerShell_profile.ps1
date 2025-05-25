# Probably useless
# $prompt = ""
# function Invoke-Starship-PreCommand {
#     $current_location = $executionContext.SessionState.Path.CurrentLocation;
#     if ($current_location.Provider.Name -eq "FileSystem") {
#         $ansi_escape = [char]27
#         $provider_path = $current_location.ProviderPath -replace "\\", "/"
#         $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
#     }
#     $host.ui.Write($prompt)
# }

function Invoke-Starship-PreCommand {
  $loc = $executionContext.SessionState.Path.CurrentLocation;
  $prompt = "$([char]27)]9;12$([char]7)"
  if ($loc.Provider.Name -eq "FileSystem")
  {
    $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $host.ui.Write($prompt)
}

Invoke-Expression (&starship init powershell)
#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

#Scoop replace with reimplantation in rust
Invoke-Expression (&sfsu hook)

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

# Ls -> Eza
function Invoke-Eza {
  param (
      [Parameter(ValueFromRemainingArguments = $true)]
      [string[]]$Args
  )
  eza --icons=always --all --color=always @Args
}

Set-Alias ls Invoke-Eza

function Invoke-Eza-La {
  param (
      [Parameter(ValueFromRemainingArguments = $true)]
      [string[]]$Args
  )
  eza --icons=always --all --long --color=always @Args
}

Set-Alias la Invoke-Eza-La

# Powershell Replace rm -rf 

# function Remove-Folder { 
#   param (
#       [Parameter(ValueFromRemainingArguments = $true)]
#       [string[]]$Args
#   )
#   Remove-Item -Recurse -ErrorAction:Stop @Args
# }
#
# set-alias rm -rf 

# Replace sudo (windows developer) -> gsudo  which works better
Set-Alias sudo gsudo
# Add sudo !!
Import-Module 'gsudoModule'


# Replace Cat -> Bat

function Invoke-Bat {
  param (
      [Parameter(ValueFromRemainingArguments = $true)]
      [string[]]$Args
  )
  Bat @Args
}

Set-Alias Cat Invoke-Bat

# Set fnm
fnm env --use-on-cd | Out-String | Invoke-Expression

# Set Yazi
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}
