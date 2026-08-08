{
  config,
  ...
}:
{
  flake.homeModules.bisonHome =
    { pkgs, ... }:
    {
      imports = with config.flake; [
        profiles.gui.home
      ];

      home.stateVersion = "25.05";
    };
}
