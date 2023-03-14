{
  description = "zbozi's system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = (import nixpkgs) {
        inherit system;
        config.allowUnfree = true;
      };

      specialArgs = { inherit inputs; };
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit pkgs;
          inherit specialArgs;
          modules = [
            ./configuration.nix
            ./hardware-configuration.nix
          ];
        };
      };
    };
}
