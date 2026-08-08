{ ... }:
{
  flake.nixosModules.nixpkgs =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;
    };

  flake.homeModules.nixpkgs =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;
    };
}
