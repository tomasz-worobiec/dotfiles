{
  ...
}:
{
  flake.homeModules.hyprpaper =
    { pkgs, resources, ... }:
    {
      services.hyprpaper = {
        enable = true;
        settings = {
          preload = [
            "${resources.wallpaper}"
          ];
          wallpaper = [
            ",${resources.wallpaper}"
          ];
        };
      };
    };
}
