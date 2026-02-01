{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

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

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    disko,
    home-manager,
    nixpkgs,
    nixpkgs-unstable,
    plasma-manager,
    stylix,
    ...
  }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    pkgs-unstable = import nixpkgs-unstable { inherit system; };

    colorScheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";

    mkConfiguration = hostname: {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        modules = [
          # disko.nixosModules.disko
          # ./hosts/${hostname}/disk-config.nix
          stylix.nixosModules.stylix
          ./hosts/${hostname}/configuration.nix
        ];
        specialArgs = {
          inherit pkgs;
          inherit pkgs-unstable;
          inherit colorScheme;
          inherit hostname;
        };
      };
    };

    mkHome = username: hostname: {
      "${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
        modules = [
          stylix.homeModules.stylix
          plasma-manager.homeModules.plasma-manager
          ./hosts/${hostname}/home.nix
        ];
        extraSpecialArgs = {
          inherit colorScheme;
          inherit pkgs-unstable;
          inherit hostname;
          inherit username;
        };
        inherit pkgs;
      };
    };
  in
  {
    nixosConfigurations = {}
      // (mkConfiguration "bison")
      // (mkConfiguration "lynx")
      // (mkConfiguration "redfox");

    homeConfigurations = {}
      // (mkHome "tom" "bison")
      // (mkHome "tom" "lynx")
      // (mkHome "tom" "redfox");
  };
}
