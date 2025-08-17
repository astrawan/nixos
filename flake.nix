{
  description = "DevLive Nix Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/release-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        pandorabox = lib.nixosSystem {
          inherit system;
          modules = [ ./nixos/pandorabox/configuration.nix ];
        };
        pandorabox-v2 = lib.nixosSystem {
          inherit system;
          modules = [ ./nixos/pandorabox-v2/configuration.nix ];
        };
        pandorabox-wsl = lib.nixosSystem {
          inherit system;
          modules = [
            nixos-wsl.nixosModules.default
            ./nixos/pandorabox-wsl/configuration.nix
          ];
        };
      };
      homeConfigurations = {
        astra = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home-manager/astra/home.nix ];
        };
        astra-wsl = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home-manager/astra-wsl/home.nix ];
        };
      };
    };
}
