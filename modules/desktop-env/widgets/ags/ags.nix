{
    config,
    pkgs,
    lib,
    ...
}:
{
    config = lib.mkIf (config.desktop-env.widgets.library == "ags") {
        desktop-env.widgets.cmd = "ags";

        programs.ags = {
            enable = true;
        };
    };
}
