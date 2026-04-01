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

  allWsBindings = builtins.genList (key: singleWsBindings (wsBindingsArgs key)) 10;

  generatedBindings = builtins.concatLists allWsBindings;
in
{
  imports = [
    ./swaync.nix
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./rofi
    ./waybar.nix
  ];

  programs.hyprshot = {
    enable = true;
    saveLocation = "$HOME/Pictures/Screenshots"; # TODO: screen shots are not saved here
  };

  services.cliphist = {
    enable = true;
  };

  home.packages = with pkgs; [
    brightnessctl
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      "$terminal" = "alacritty";
      "$mod" = "SUPER";
      "$shiftmod" = "SUPER SHIFT";

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

        # Window movement
        "$mod ALT, l, movewindow, r"
        "$mod ALT, h, movewindow, l"
        "$mod ALT, k, movewindow, u"
        "$mod ALT, j, movewindow, d"

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

        # Screenshot
        ", PRINT, exec, hyprshot -m output -m active"
        "$mod, PRINT, exec, hyprshot -m window -m active"
        "$shiftmod, PRINT, exec, hyprshot -m region"

        # Clipboard
        "$shiftmod, v, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      ]
      ++ generatedBindings;

      general = {
        gaps_in = 2.5;
        gaps_out = 5;
        border_size = 1;
      };

      decoration = {
        rounding = 5;
      };

      input = {
        kb_layout = "pl";
      };
    };
  };
}
