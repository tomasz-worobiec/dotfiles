{
  ...
}:
{
  flake.homeModules.rofi =
    { pkgs, ... }:
    let
      configPath = ".config/rofi";
      launcherConfig = "${configPath}/launcher-theme.rasi";
      powerMenuConfig = "${configPath}/power-menu-theme.rasi";
      powerMenuBin = "${pkgs.rofi-power-menu}/bin/rofi-power-menu";

      launcherCmd = "rofi -show drun -show-icons -config ${launcherConfig}";
      powerMenuCmd = "rofi -show power-menu -modi 'power-menu:${powerMenuBin} --confirm=' -theme ${powerMenuConfig}";
    in
    {
      programs.rofi = {
        enable = true;

        modes = [
          {
            name = "power-menu";
            path = "${pkgs.rofi-power-menu}/bin/rofi-power-menu";
          }
        ];

        plugins = [
          pkgs.rofi-power-menu
        ];
      };

      home.file = {
        "${launcherConfig}".source = ./launcher-theme.rasi;
        "${powerMenuConfig}".source = ./power-menu-theme.rasi;
      };

      wayland.windowManager.hyprland.settings.bind = [
        "$mod, S, exec, ${launcherCmd}"
        "$mod, ESCAPE, exec, ${powerMenuCmd}"
      ];
    };
}
