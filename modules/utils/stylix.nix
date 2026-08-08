{ inputs, ... }:
{
  flake.nixosModules.stylix =
    { pkgs, ... }:
    {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
    };

  flake.homeModules.stylix =
    { pkgs, ... }:
    {
      imports = [
        inputs.stylix.homeManagerModules.stylix
      ];

      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
    };
}
