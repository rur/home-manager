{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    packages.x86_64-linux.default = home-manager.defaultPackage.x86_64-linux;
    packages.x86_64-darwin.default = home-manager.defaultPackage.x86_64-darwin;

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
