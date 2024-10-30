{
    config,
    pkgs,
    lib,
    ...
}:
{
    config = {
        services.pipewire = {
            enable = lib.mkDefault true;
            pulse.enable = lib.mkDefault true;
        };
    };
}


