{
  config,
  ...
}:
{
  flake.homeModules.lynxHome =
    { pkgs, ... }:
    {
      imports = with config.flake; [
        profiles.minimal.home
      ];

      home.stateVersion = "25.05";
    };
}
