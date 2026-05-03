{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixvim, ... }: {
    packages.x86_64-linux.default = home-manager.packages.x86_64-linux.default;
    packages.x86_64-darwin.default =
      home-manager.packages.x86_64-darwin.default;

    homeConfigurations = {
      "ruaidhridevery@chromebook" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          nixvim.homeManagerModules.nixvim
          {
            _module.args.pkgs-unstable = import nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
                "claude-code"
              ];
            };
          }
          ./chromebook.nix
        ];
      };
      "ruaidhridevery@macbookpro" = home-manager.lib.homeManagerConfiguration
      {
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
        modules = [
          nixvim.homeManagerModules.nixvim
          {
            _module.args.pkgs-unstable = import nixpkgs-unstable {
              system = "x86_64-darwin";
              config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
                "claude-code"
              ];
            };
          }
          ./macbookpro.nix
        ];
      };
    };
  };
}
