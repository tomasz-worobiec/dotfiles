{ inputs, config, ... }:
let
  noctaliaModule = config.flake.homeModules.noctalia;
in
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      imports = [
        inputs.niri.nixosModules.niri
        config.flake.nixosModules.noctalia
      ];

      programs.niri.enable = true;
    };

  flake.homeModules.niri =
    { pkgs, config, ... }:
    {
      imports = [
        inputs.niri.homeModules.niri
        noctaliaModule
      ];

      programs.niri = {
        enable = true;

        settings = {
          input.keyboard.xkb.layout = "pl";

          prefer-no-csd = true;

          layout = {
            gaps = 10;
            border.width = 1;
            focus-ring.width = 1;
            default-column-width.proportion = 0.5;
          };

          window-rules = [
            {
              geometry-corner-radius = {
                top-left = 8.0;
                top-right = 8.0;
                bottom-right = 8.0;
                bottom-left = 8.0;
              };
              clip-to-geometry = true;
            }
          ];

          spawn-at-startup = [
            {
              command = [ "xwayland-satellite" ];
            }
            {
              command = [ "noctalia" ];
            }
          ];

          binds = {
            "Mod+T".action.spawn = [ "alacritty" ];

            "Mod+Q".action.close-window = { };
            "Mod+F".action.maximize-column = { };
            "Mod+Shift+F".action.fullscreen-window = { };
            "Mod+Ctrl+F".action.expand-column-to-available-width = { };

            "Mod+H".action.focus-column-left = { };
            "Mod+L".action.focus-column-right = { };
            "Mod+K".action.focus-window-or-workspace-up = { };
            "Mod+J".action.focus-window-or-workspace-down = { };

            "Mod+Shift+h".action.move-column-left = { };
            "Mod+Shift+l".action.move-column-right = { };

            "XF86AudioRaiseVolume".action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "5%+"
            ];
            "XF86AudioLowerVolume".action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "5%-"
            ];
            "XF86AudioMute".action.spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SINK@"
              "toggle"
            ];

            "Mod+1".action.focus-workspace = 1;
            "Mod+2".action.focus-workspace = 2;
            "Mod+3".action.focus-workspace = 3;
            "Mod+4".action.focus-workspace = 4;
            "Mod+5".action.focus-workspace = 5;

            "Mod+Shift+1".action.move-window-to-workspace = 1;
            "Mod+Shift+2".action.move-window-to-workspace = 2;
            "Mod+Shift+3".action.move-window-to-workspace = 3;
            "Mod+Shift+4".action.move-window-to-workspace = 4;
            "Mod+Shift+5".action.move-window-to-workspace = 5;

            "Mod+S".action.spawn = [
              "noctalia"
              "msg"
              "panel-toggle"
              "launcher"
            ];

            "Mod+Escape".action.spawn = [
              "noctalia"
              "msg"
              "panel-toggle"
              "session"
            ];

            "Mod+Tab".action.spawn = [
              "noctalia"
              "msg"
              "panel-toggle"
              "control-center"
            ];
          };
        };
      };

      home.packages = with pkgs; [
        xwayland-satellite
      ];
    };
}
