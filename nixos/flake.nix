{

  description = "My NixOS Flake Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    openchamber.url = "github:openchamber/openchamber";
    opencode.url = "github:anomalyco/opencode";
    appmanager.url = "github:kem-a/AppManager";
    helium.url = "github:oxcl/nix-flake-helium-browser";
    helium.inputs.nixpkgs.follows = "nixpkgs";
    sls-steam.url = "github:AceSLS/SLSsteam";
    sls-steam.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    umbriel.url = "github:noctalia-dev/umbriel";
    noc-greeter.url = "github:noctalia-dev/noctalia-greeter";
    noc-greeter.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      chaotic,
      noctalia,
      opencode,
      openchamber,
      neovim-nightly-overlay,
      umbriel,
      noc-greeter,
      ...
    }:
    {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          chaotic.nixosModules.default
          noctalia.nixosModules.default
          umbriel.nixosModules.default
          ./configuration.nix
        ];
      };
    };

}
