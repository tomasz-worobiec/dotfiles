{
    config,
    pkgs,
    lib,
    ...
}:
{
    options = {
        hardware.bluetooth.enableAudio = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description =
                "Whether to enable handling bluetooth audio devices";
        };
    };
    
    config = {
        hardware.bluetooth = {
            enable = lib.mkDefault false;
        };
        
        # Enable audio through BT device
        services.pipewire.pulse.enable = 
            lib.mkOverride 100 config.hardware.bluetooth.enableAudio;

        # Enable controlling media with BT device buttons.
        # services.mpris-proxy.enable = 
        #     lib.mkOverride 100 config.hardware.bluetooth.enableAudio;
    };
}

