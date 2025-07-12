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

    mkConfiguration = hostname: {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        modules = [
          disko.nixosModules.disko
          ./hosts/${hostname}/disk-config.nix
          ./hosts/${hostname}/configuration.nix
        ];
        specialArgs = { inherit pkgs; };
      };
    };

    mkHome = username: hostname: {
      "${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./hosts/${hostname}/home.nix
        ];
        inherit pkgs;
      };
    };
  in
  {
    nixosConfigurations = {}
      // (mkConfiguration "lynx");

    homeConfigurations = {}
      // (mkHome "tom" "lynx");
  };
}
