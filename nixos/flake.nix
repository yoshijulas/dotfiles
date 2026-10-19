{

	description = "My NixOS Flake Config";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
noctalia.url = "github:noctalia-dev/noctalia/cachix";
openchamber.url = "github:openchamber/openchamber";
opencode.url = "github:anomalyco/opencode";
appmanager.url = "github:kem-a/AppManager";
	};
	outputs = inputs@{
		self, nixpkgs, chaotic, noctalia, opencode, openchamber,...}: {

			nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				system = "x86_64-linux";
				modules = [ chaotic.nixosModules.default noctalia.nixosModules.default ./configuration.nix ./hardware-configuration.nix ]; };
		};

}
