{
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

        home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # Modules
        hyprland.url = "github:hyprwm/Hyprland";
        hyprland-plugins = {
            url = "github:hyprwm/hyprland-plugins";
            inputs.hyprland.follows = "hyprland";
        };
        stylix.url = "github:danth/stylix/993fcabd83d1e0ee5ea038b87041593cc73c1ebe";
        ags.url = "github:Aylur/ags";
    };

    outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:

    let
        system = "x86_64-linux";
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.${system};
        pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                modules = [
                    ./configuration.nix
                    inputs.stylix.nixosModules.stylix
                ];
                specialArgs = {
                    inherit pkgs;
                    inherit pkgs-unstable;
                };
            };
        };

        homeConfigurations = {
            tom = home-manager.lib.homeManagerConfiguration {
                modules = [
                    ./home.nix
                    inputs.ags.homeManagerModules.default
                    inputs.stylix.homeManagerModules.stylix
                ];
                inherit pkgs;
                extraSpecialArgs = {
                    inherit pkgs-unstable;
                };
            };
        };
    };
}
