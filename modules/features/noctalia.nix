{ inputs, ... }:
{
  flake.homeModules.noctalia =
    { pkgs, ... }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;

        settings = {
          bar.default = {
            position = "top";
            density = "compact";
            showCapsule = false;

            widget_spacing = 15;

            start = [
              "launcher"
              "workspaces"
            ];
            center = [
              "media"
              "clock"
            ];
            end = [
              "volume"
              "brightness"
              "bluetooth"
              "network"
              "battery"
              "control-center"
            ];
          };
        };
      };
    };

  flake.nixosModules.noctalia =
    { pkgs, ... }:
    {
      imports = [
        inputs.noctalia-greeter.nixosModules.default
      ];

      programs.noctalia-greeter = {
        enable = true;
      };

      networking.networkmanager.enable = true;

      services = {
        power-profiles-daemon.enable = true;
        upower.enable = true;
      };
    };
}
