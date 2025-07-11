{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    disko,
    home-manager,
    nixpkgs,
    ...
  }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    nixosConfigurations = {
      lynx = nixpkgs.lib.nixosSystem {
        modules = [
          disko.nixosModules.disko
          ./hosts/lynx/disk-config.nix
          ./hosts/lynx/configuration.nix
        ];
        specialArgs = { inherit pkgs; };
      };
    };

    homeConfigurations = {
      tom = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./hosts/lynx/home.nix
        ];
        inherit pkgs;
      };
    };
  };
}
