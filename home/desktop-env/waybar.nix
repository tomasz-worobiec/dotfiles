{
  ...
}:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        height = 30;
        tray.spacing = 10;

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "tray"
        ];

        modules-right = [
          "pulseaudio"
          "battery"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
          sort-by-number = true;
        };

        clock = {
          format = "{:%H : %M}";
          tooltip-format = "{:%d-%m-%Y}";
        };

        battery = {
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-critical = "󰂃 {capacity}%";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂂" "󰁹"];
          states = {
            "critical" = 10;
          };
          interval = 15;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 {volume}%";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
        };
      }
    ];

    style = ''
      * {
        font-family: "CommitMono Nerd Font:style=Regular";
        border: none;
        border-radius: 10px;
        border-width: 2px;
      }

      window#waybar {
        background: transparent;
      }

      .modules-left {
        padding: 2px 2px 0px 0px;
      }

      .modules-right {
        padding: 2px 2px 0px 0px;
      }

      #workspaces { }

      #workspaces button {
        background-color: @card_bg_color;
        color: @card_fg_color;
        border-color: @card_fg_color;
        border-style: solid;
        margin: 0px 0px 0px 3px;
        min-height: 24px;
        min-width: 24px;
        padding: 0px;
        font-size: 12px;
      }

      #workspaces button.active {
        background-color: @card_fg_color;
        border-color: @card_bg_color;
        color: @card_bg_color;
      }

      #clock {
        font-size: 16px;
        background-color: @card_bg_color;
        color: @card_fg_color;
        border-color: @card_fg_color;
        border-style: solid;
        margin: 0px 2px 0px 2px;
        min-height: 24px;
        min-width: 70px;
        padding: 0px;
      }

      #battery {
        font-size: 16px;
        background-color: @card_bg_color;
        color: @card_fg_color;
        border-color: @card_fg_color;
        border-style: solid;
        margin: 0px 2px 0px 2px;
        min-height: 24px;
        min-width: 70px;
        padding: 0px;
      }

      #pulseaudio {
        font-size: 16px;
        background-color: @card_bg_color;
        color: @card_fg_color;
        border-color: @card_fg_color;
        border-style: solid;
        margin: 0px 2px 0px 2px;
        min-height: 24px;
        min-width: 70px;
        padding: 0px;
      }
    '';
  };
}
