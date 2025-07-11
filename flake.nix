{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
   packages.x86_64-linux.default = home-manager.packages.x86_64-linux.default;
   packages.x86_64-darwin.default = home-manager.packages.x86_64-darwin.default;

    homeConfigurations = {
      "ruaidhridevery@chromebook" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./chromebook.nix ];
      };
      "ruaidhridevery@macbookpro" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
        modules = [ ./macbookpro.nix ];
      };
    };
  };
}
