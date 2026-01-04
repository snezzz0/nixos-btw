{
  description = "NixOS Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
  };
  outputs = { self, nixpkgs, stylix, ... }@inputs: {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        inputs.stylix.nixosModules.stylix
      ];
    };
  };
}
