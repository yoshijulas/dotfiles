function Test-CommandExists {
    param($command)
    return (Get-Command $command -ErrorAction SilentlyContinue)
}

# --- Main Logic ---

# 1. Check if Scoop is installed
if (-not (Test-CommandExists scoop)) {
    Write-Output "Scoop is not installed or not in PATH. Skipping package installation."
    # Optional: You could add the Scoop installation command here if you want it to be fully automatic.
    # Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Or AllSigned
    # irm get.scoop.sh | iex
    exit
}

Write-Output "Scoop found. Checking buckets and packages..."

# --- Buckets to ensure are added ---
$buckets = @(
    "extras"
    "main",
    "nerd-fonts",
    "versions",
)

foreach ($bucket in $buckets) {
    if (-not (scoop bucket list | Select-String -Quiet $bucket)) {
        Write-Output "Adding Scoop bucket: $bucket"
        scoop bucket add $bucket
    } else {
        Write-Output "Scoop bucket '$bucket' already exists."
    }
}


# --- Packages to ensure are installed ---
$packages = @(
    "extras/lazygit",
    "extras/mpv-git",
    "extras/sfsu",
    "extras/trafficmonitor"
    "extras/vcredist2022",
    "main/eza",
    "main/gsudo",
    "main/jj",
    "main/starship",
    "main/zig",
    "nerd-fonts/JetBrainsMono-NF",
    "versions/neovim-nightly",
)

$failedInstalls = @()
foreach ($package in $packages) {
    # Extract the package name without the bucket prefix for the status check
    $packageNameOnly = $package.Split('/')[1]

    # NOTE: `scoop status` never prints "OK" and `scoop list <name>`
    # echoes the query even when missing, so match the table row instead.
    $listOut = scoop list $packageNameOnly | Out-String
    $healthy = $listOut | Select-String -Quiet "(?m)^$packageNameOnly\s+\S"
    $failed = $listOut | Select-String -Quiet "Install failed"
    if ((-not $healthy) -or $failed) {
        Write-Output "Installing Scoop package: $package"
        try {
            scoop install $package
            if ($LASTEXITCODE -ne 0) { throw "scoop exited with code $LASTEXITCODE" }
        } catch {
            Write-Output "WARNING: Failed to install '$package': $_ (continuing...)"
            $failedInstalls += $package
        }
    } else {
        Write-Output "Scoop package '$packageNameOnly' is already installed."
    }
}

Write-Output "Scoop package check complete."
if ($failedInstalls.Count -gt 0) {
    Write-Output ("WARNING: These packages failed (re-run this script later): " + ($failedInstalls -join ", "))
}

