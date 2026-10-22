# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  environment.etc."crypttab".text =
    "seagate_crypt UUID=749fc558-3b53-4387-a555-95cbedc8f026 /root/seagate.key tpm2-device=auto,token-timeout=2min,timeout=0,nofail,luks";

  fileSystems = {
    "/data" = {
      device = "/dev/mapper/luks-733460a8-edb4-4798-b8ba-fe1c0681f06";
      fsType = "btrfs";
      options = [
        "subvol=@data"
        "compress=zstd"
        "noatime"
      ];
    };
    "/media/seagate/Torrents" = {
      device = "/dev/mapper/seagate_crypt";
      fsType = "btrfs";
      options = [
        "subvol=@torrents"
        "noatime"
        "compress=zstd:1"
        "nofail"
      ];
    };
    "/media/seagate/YosFiles" = {
      device = "/dev/mapper/seagate_crypt";
      fsType = "btrfs";
      options = [
        "subvol=@yosfiles"
        "noatime"
        "compress=zstd:1"
        "nofail"
      ];
    };
  };

  powerManagement.cpufreq.max = 3200000;

  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 20;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  # other (optional) custom CachyOS packages that may be fit for your setup include:
  boot.zfs.package = pkgs.zfs_cachyos;
  hardware.nvidia.package = pkgs.nvidia_cachyos;
  # # Use latest kernel.
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  nixpkgs.config.allowUnfree = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # };

  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        path = pkgs.bibata-cursors;
      };
    };
  };

  nix = {
    package = pkgs.lix;
    # Lets legacy commands (nix-shell -p, nix-env) resolve <nixpkgs> without channels.
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "@wheel" ];

      extra-substituters = [
        "https://noctalia.cachix.org"
        "https://nix-community.cachix.org"
        "https://umbriel.cachix.org"
      ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    optimise.automatic = true;
  };

  zramSwap.enable = true;
  swapDevices = [
    {
      device = "/swapfile";
      size = 24 * 1024;
    }
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings.data-root = "/data/docker-nixos";
  virtualisation.docker.daemon.settings.shutdown-timeout = 360;
  systemd.services.docker.restartIfChanged = false;
  systemd.services.docker.serviceConfig.TimeoutStopSec = "6min";

  programs = {
    fish.enable = true;
    niri.enable = true;
    thunderbird.enable = true;
    gamescope.enable = true;
    umbriel.enable = true;
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraEnv =
          let
            sls = inputs.sls-steam.packages.${pkgs.stdenv.hostPlatform.system}.sls-steam;
          in
          {
            LD_AUDIT = "${sls}/library-inject.so:${sls}/SLSsteam.so";
          };
        extraProfile = ''
          export XCURSOR_PATH="${
            (pkgs.callPackage ./material-bibata-cursor.nix { })
          }/share/icons''${XCURSOR_PATH:+:$XCURSOR_PATH}"
          export XCURSOR_THEME="Bibata-Material-Beige"
          export XCURSOR_SIZE="20"
        '';
      };
    };
    nh = {
      enable = true;
      flake = "/home/yoshi/dotfiles/nixos";
    };
    niri.package = pkgs.niri_git;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    noctalia = {
      enable = true;

      # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
      recommendedServices.enable = true;
    };
    appimage.enable = true;
    appimage.binfmt = true;
    nix-ld.enable = true;
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Backends Dolphin needs to list devices, trash and network locations.
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yoshi = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "root"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      kdePackages.dolphin
    ];
    shell = pkgs.fish;
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages =
    with pkgs;
    [
      # Flakes
      inputs.opencode.packages.${stdenv.hostPlatform.system}.opencode
      # appmanager builds from source without glib-networking, so its updater has
      # no GIO TLS backend ("TLS support is not available"). This wires it in so
      # HTTPS update checks validate against the system CA bundle. Upstream fix:
      # add glib-networking to buildInputs in kem-a/AppManager package.nix.
      (inputs.appmanager.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.glib-networking ];
      }))
      inputs.neovim-nightly-overlay.packages.${stdenv.hostPlatform.system}.default
      inputs.helium.packages.${stdenv.hostPlatform.system}.default # helium browser (oxcl flake: repackaged upstream .deb, pinned hash)

      # Nixpkgs 
      jujutsu
      git
      wget
      yazi
      vim
      firefox_nightly
      ghostty
      wl-clipboard
      btop
      nerd-fonts.jetbrains-mono
      ripgrep
      bat
      starship
      eza
      fzf
      fd
      lazygit
      vesktop
      kdePackages.kleopatra
      pinentry-curses
      nvd
      steam-run
      xwayland-satellite
      mangohud
      pkgsi686Linux.mangohud
      (callPackage ./material-bibata-cursor.nix { })
      unzip
      ouch
      duf
      topgrade
      cryptomator
      swayimg
      imv
      libreoffice
      localsend
      pureref

      proton-cachyos_x86_64_v3

      # Test
      oxker # lazydocker like tool
      gitlogue
    ]

    # Dev tools (appended to the list above).
    ++ [
      # LSP servers: nvim gets these from nixpkgs on NixOS (Mason is disabled).
      bash-language-server # LSP: bashls (bash/sh)
      fsautocomplete # LSP: fsautocomplete (fsharp)
      kotlin-language-server # LSP: kotlin_language_server (kotlin)
      lemminx # LSP: lemminx (xml/xaml)
      lua-language-server # LSP: lua_ls (lua)
      nixd # LSP: nixd (nix)
      omnisharp-roslyn # LSP: omnisharp (c#)
      vscode-langservers-extracted # LSP: jsonls (json, +html/css)
      vtsls # LSP: vtsls (typescript/javascript)
      yaml-language-server # LSP: yamlls (yaml)
      # Runtimes / toolchains
      bun # fast JS runtime/package manager, npm alternative
      dotnet-sdk # .NET SDK (C# builds; omnisharp analyzes without it)
      gcc # C compiler: nvim-treesitter builds parsers from source
      jdk25 # latest Java
      nodejs # node + npm (nvim plugins, LSP servers, frontend)
      python3 # python (nvim plugins, scripts)
      uv # python project/package manager, replaces pip + venv
      # Helpers
      mise # polyglot version manager (node/python pinning per project)
      skills # skills.sh CLI: find/add/update agent skills
      nixfmt # nix formatter
      statix # nix linter
      taplo # toml formatter (lua/plugins/lsp/toml.lua)
      tree-sitter # tree-sitter CLI: required by nvim-treesitter (:checkhealth)
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

  # eMudhra intermediates compromise (Oct 2026): distrust the affected roots
  # until the updated CA bundle lands. Revert the AAA line if legacy sites break.
  # https://emudhra.we-have-a-problem.com/
  security.pki.caCertificateBlacklist = [
    "Comodo AAA Services root"
    "emSign ECC Root CA - G3"
  ];

}
