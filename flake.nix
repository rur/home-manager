{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nixvim,
      ...
    }:
    let
      # Build a home-manager configuration for a given system + machine module.
      mkHome =
        { system, module }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            nixvim.homeModules.nixvim
            {
              _module.args.pkgs-unstable = import nixpkgs-unstable {
                inherit system;
                config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "claude-code" ];
              };
            }
            module
          ];
        };
    in
    {
      packages.x86_64-linux.default = home-manager.packages.x86_64-linux.default;
      packages.x86_64-darwin.default = home-manager.packages.x86_64-darwin.default;

      # `nix fmt` formats every .nix file with the RFC 166 style.
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
      formatter.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.nixfmt;

      homeConfigurations = {
        "ruaidhridevery@chromebook" = mkHome {
          system = "x86_64-linux";
          module = ./chromebook.nix;
        };
        "ruaidhridevery@macbookpro" = mkHome {
          system = "x86_64-darwin";
          module = ./macbookpro.nix;
        };
        "operator@agent-host" = mkHome {
          system = "x86_64-linux";
          module = ./agent-operator.nix;
        };
      };
    };
}
