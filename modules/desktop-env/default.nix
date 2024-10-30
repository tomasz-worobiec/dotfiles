{
    config,
    pkgs,
    lib,
    ...
}:
{
    imports = [
        ./window-managers/hyprland.nix
        ./widgets/ags/ags.nix
    ];

    options = {
        desktop-env.wm = lib.mkOption {
            type = lib.types.enum [ "hyprland" ];
            default = "hyprland";
            description = "What window manager to use?";
        };

        desktop-env.widgets.library = lib.mkOption {
            type = lib.types.enum [ "ags" ];
            default = "ags";
            description = "What widgets library to use?";
        };

        desktop-env.widgets.cmd = lib.mkOption {
            type = lib.types.str;
            description = ''
                Command to start widgets.
                This option is overriden in subsequent nix modules
                based on widgets.library parameter.
            '';
        };

        desktop-env.cmd = lib.mkOption {
            type = lib.types.str;
            description = ''
                Command to start window manager.
                This option is overriden in subsequent nix modules
                based on wm parameter.
            '';
        };
    };
}

