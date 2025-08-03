function Test-CommandExists {
    param($command)
    return (Get-Command $command -ErrorAction SilentlyContinue)
}

# --- Main Logic ---

# 1. Check if Scoop is installed
if (-not (Test-CommandExists scoop)) {
    Write-Host "Scoop is not installed or not in PATH. Skipping package installation."
    # Optional: You could add the Scoop installation command here if you want it to be fully automatic.
    # Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Or AllSigned
    # irm get.scoop.sh | iex
    exit
}

Write-Host "Scoop found. Checking buckets and packages..."

# --- Buckets to ensure are added ---
$buckets = @(
    "main",
    "versions",
    "nerd-fonts",
    "extras"
)

foreach ($bucket in $buckets) {
    if (-not (scoop bucket list | Select-String -Quiet $bucket)) {
        Write-Host "Adding Scoop bucket: $bucket"
        scoop bucket add $bucket
    } else {
        Write-Host "Scoop bucket '$bucket' already exists."
    }
}


# --- Packages to ensure are installed ---
$packages = @(
    "versions/neovim-nightly",
    "main/eza",
    "main/gsudo",
    "nerd-fonts/JetBrainsMono-NF",
    "extras/sfsu",
    "main/starship",
    "main/zig",
    "extras/lazygit",
    "extras/mpv-git",
    "extras/trafficmonitor"
)

foreach ($package in $packages) {
    # Extract the package name without the bucket prefix for the status check
    $packageNameOnly = $package.Split('/')[1]
    
    if (-not (scoop status $packageNameOnly | Select-String -Quiet "OK")) {
        Write-Host "Installing Scoop package: $package"
        scoop install $package
    } else {
        Write-Host "Scoop package '$packageNameOnly' is already installed."
    }
}

Write-Host "Scoop package check complete."

