{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    resources.url = "git+ssh://git@github.com/tomasz-worobiec/dotfiles-resources.git";
  };

  outputs =
    {
      disko,
      home-manager,
      nixpkgs,
      nixpkgs-unstable,
      resources,
      stylix,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable { inherit system; };

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
            ./hosts/${hostname}/home.nix
          ];
          extraSpecialArgs = {
            inherit colorScheme;
            inherit pkgs-unstable;
            inherit hostname;
            inherit username;
            inherit resources;
          };
          inherit pkgs;
        };
      };
    in
    {
      nixosConfigurations =
        { } // (mkConfiguration "bison") // (mkConfiguration "lynx") // (mkConfiguration "redfox");

      homeConfigurations =
        { } // (mkHome "tom" "bison") // (mkHome "tom" "lynx") // (mkHome "tom" "redfox");
    };
}
