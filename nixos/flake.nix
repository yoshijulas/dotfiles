{

  description = "My NixOS Flake Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    amethyst.inputs.nixpkgs.follows = "nixpkgs";
    amethyst.url = "github:ChrisDKN/Amethyst-Mod-Manager";
    appmanager.inputs.nixpkgs.follows = "nixpkgs";
    appmanager.url = "github:kem-a/AppManager";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    fluxer.url = "github:Hy4ri/fluxer-flake";
    yazi.url = "github:sxyazi/yazi";
    #yazi.inputs.nixpkgs.follows = "nixpkgs";
    helium.inputs.nixpkgs.follows = "nixpkgs";
    helium.url = "github:oxcl/nix-flake-helium-browser";
    lazyflakes.inputs.nixpkgs.follows = "nixpkgs";
    lazyflakes.url = "github:MaJDa-sh/lazyflakes";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    noctalia-greeter.inputs.nixpkgs.follows = "nixpkgs";
    noctalia-greeter.url = "github:noctalia-dev/noctalia-greeter";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    omniflake.inputs.nixpkgs.follows = "nixpkgs";
    omniflake.url = "github:fzakaria/omniflake";
    openchamber.inputs.nixpkgs.follows = "nixpkgs";
    openchamber.url = "github:openchamber/openchamber";
    opencode.inputs.nixpkgs.follows = "nixpkgs";
    opencode.url = "github:anomalyco/opencode/v2.2.4";
    rustowl.url = "github:nix-community/rustowl-flake";
    sls-steam.inputs.nixpkgs.follows = "nixpkgs";
    sls-steam.url = "github:AceSLS/SLSsteam";
    umbriel.url = "github:noctalia-dev/umbriel";
  };
  outputs =
    inputs@{
      self,
      amethyst,
      chaotic,
      fluxer,
      lazyflakes,
      neovim-nightly-overlay,
      nixpkgs,
      noctalia,
      noctalia-greeter,
      omniflake,
      openchamber,
      opencode,
      rustowl,
      umbriel,
      yazi,
      ...
    }:
    {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          chaotic.nixosModules.default
          noctalia-greeter.nixosModules.default
          noctalia.nixosModules.default
          umbriel.nixosModules.default
          ./configuration.nix
        ];
      };
    };

}
