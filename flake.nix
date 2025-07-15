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

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    disko,
    home-manager,
    nixpkgs,
    stylix,
    ...
  }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

    colorScheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";

    mkConfiguration = hostname: {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        modules = [
          disko.nixosModules.disko
          ./hosts/${hostname}/disk-config.nix
          stylix.nixosModules.stylix
          ./hosts/${hostname}/configuration.nix
        ];
        specialArgs = {
          inherit pkgs;
          inherit colorScheme;
        };
      };
    };

    mkHome = username: hostname: {
      "${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
        modules = [
          stylix.homeModules.stylix
          ./hosts/${hostname}/home.nix
        ];
        extraSpecialArgs = {
          inherit colorScheme;
        };
        inherit pkgs;
      };
    };
  in
  {
    nixosConfigurations = {}
      // (mkConfiguration "lynx")
      // (mkConfiguration "redfox");

    homeConfigurations = {}
      // (mkHome "tom" "lynx")
      // (mkHome "tom" "redfox");
  };
}
