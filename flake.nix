{
  description = "DevLive Nix Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
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
      };
      homeConfigurations = {
        astra = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home-manager/astra/home.nix ];
        };
      };
    };
}
