{
    config,
    lib,
    pkgs,
    pkgs-unstable,
    ...
}:
let
    # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
	workspaces = builtins.concatLists (builtins.genList (
		x: let
        	ws = let
        		c = (x + 1) / 10;
        	in
        		builtins.toString (x + 1 - (c * 10));
		in [
        	"$mod, ${ws}, workspace, ${toString (x + 1)}"
        	"$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      	]
    )
    10);
in
{
    config = lib.mkIf (config.desktop-env.wm == "hyprland") {
        desktop-env.cmd = "Hyprland";

        home.packages = with pkgs; [
            rofi-wayland
            hyprpaper
        ];

        wayland.windowManager.hyprland = {
            enable = true;
            xwayland.enable = true;
            package = pkgs.hyprland;
            settings = {
                "$terminal" = "alacritty";
                "$mod" = "SUPER";

                exec-once = [
                    "hyprpaper"
                    config.desktop-env.widgets.cmd
                ];

                bind = [
                    # Starting programs
                    "$mod, T, exec, alacritty"
                    "$mod, S, exec, rofi -show drun -show-icons"
            
                    # Window management
                    "$mod, Q, killactive"
                    "$mod, F, fullscreen"
                    "$mod, TAB, cyclenext"

                    # Workspace management
                    "$mod, bracketleft, workspace, m-1"
                    "$mod, bracketright, workspace, m+1"

                    # Sound
                    ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
                    ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ] ++ workspaces;

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

            extraConfig = ''
                windowrule=opacity 0.9,^(Alacritty)$
                monitor = eDP-1,1920x1080@60.02Hz,0x0,1.25
                monitor = HDMI-A-2,3840x1600@60.00Hz,0x0,1.25
            '';
        };

        home.file.".config/hypr/hyprpaper.conf".text = ''
            preload = ~/wallpapers/1
            wallpaper = eDP-1,~/wallpapers/1
        '';
    };
}
