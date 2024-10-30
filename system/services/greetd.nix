{
    config,
    pkgs,
    lib,
    ...
}:
let
    tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in
{
    config = {
        services.greetd = {
            enable = true;
            settings = {
                default_session = {
                    command = "${tuigreet} --time --cmd Hyprland";
                    user = "tom";
                };
            };
        };
    #   systemd.services.greetd.serviceConfig = {
    #     Type = "idle";
    #     StandardInput = "tty";
    #     StandardOutput = "tty";
    #     StandardError = "journal";
    #     TTYReset = true;
    #     TTYVHangup = true;
    #     TTYVDisallocate = true;
    #   };
    };
}

