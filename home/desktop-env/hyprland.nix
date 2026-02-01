{
  pkgs,
  ...
}:
let
  singleWsBindings = args: [
    "$mod, ${args.key}, workspace, ${args.ws}"
    "$mod SHIFT, ${args.key}, movetoworkspace, ${args.ws}"
  ];

  wsBindingsArgs = key: {
    key = builtins.toString key;
    ws = builtins.toString (if key == 0 then 10 else key);
  };

  allWsBindings = builtins.genList
    (key: singleWsBindings (wsBindingsArgs key)) 10;

  generatedBindings = builtins.concatLists allWsBindings;
in
{
  imports = [
    ./dunst.nix
    ./hyprpaper.nix
    ./rofi
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      "$terminal" = "alacritty";
      "$mod" = "SUPER";

      bind = [
        # Starting programs
        "$mod, T, exec, alacritty"

        # Window management
        "$mod, Q, killactive"
        "$mod, F, fullscreen"

        # Window resizing
        "$mod SHIFT, l, resizeactive, 10 0"
        "$mod SHIFT, h, resizeactive, -10 0"
        "$mod SHIFT, k, resizeactive, 0 -10"
        "$mod SHIFT, j, resizeactive, 0 10"

        # Window navigation
        "$mod, l, movefocus, r"
        "$mod, h, movefocus, l"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # Workspace management
        "$mod, bracketleft, workspace, m-1"
        "$mod, bracketright, workspace, m+1"

        # Sound
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # Display brightness
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ] ++ generatedBindings;

      monitor = [
        ", preffered, auto, 1.2"
      ];

      general = {
        gaps_in = 2.5;
        gaps_out = 5;
        border_size = 1;
      };

      decoration = {
        rounding = 5;
      };

      input = {
        kb_layout="pl";
      };
    };
  };
}
