{
  pkgs,
  ...
}:
{
  flake.homeModules.swaync =
    { pkgs, ... }:
    {
      services.swaync = {
        enable = true;
      };
    };
}
