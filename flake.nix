{
  description = "DevLive Nix Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/release-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixos-wsl, home-manager, zen-browser, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        pandorabox = lib.nixosSystem {
          inherit system;
          modules = [
            nixos-wsl.nixosModules.default
            ({ ... }: {
              imports = [
                ./modules/options
                ./modules/nixos
                ./profiles/astra/options.nix
                ./profiles/astra/extra-options.nix
                ./nixos/pandorabox/configuration.nix
              ];
            })
          ];
        };
        pandorabox-v2 = lib.nixosSystem {
          inherit system;
          modules = [
            nixos-wsl.nixosModules.default
            ({ ... }: {
              imports = [
                ./modules/options
                ./modules/nixos
                ./profiles/astra/options.nix
                ./profiles/astra/extra-options.nix
                ./nixos/pandorabox-v2/configuration.nix
              ];
            })
          ];
        };
        pandorabox-wsl = lib.nixosSystem {
          inherit system;
          modules = [
            nixos-wsl.nixosModules.default
            ({ ... }: {
              imports = [
                ./modules/options
                ./modules/nixos
                ./profiles/astra/options.nix
                ./profiles/astra/extra-wsl-options.nix
                ./nixos/pandorabox-wsl/configuration.nix
              ];
            })
          ];
        };
      };
      homeConfigurations = {
        astra = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ({ ... }: {
              imports = [
                zen-browser.homeModules.beta
                ./modules/options
                ./modules/home-manager
                ./profiles/astra/options.nix
                ./profiles/astra/extra-options.nix
                ./home-manager/astra/home.nix
              ];
            })
          ];
        };
        astra-wsl = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ({ ... }: {
              imports = [
                ./modules/options
                ./modules/home-manager
                ./profiles/astra/options.nix
                ./profiles/astra/extra-wsl-options.nix
                ./home-manager/astra/home.nix
              ];
            })
          ];
        };
      };
    };
}
