{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    homeConfigurations = {
      "ruaidhridevery" = home.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackage.x86_64-linux;
        modules = [ ./home.nix ];
      };
    };
  };
}
