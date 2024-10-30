{
  pkgs,
  inputs,
  ...
}: let
    tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
    hyprland-session = "${pkgs.hyprland}/share/wayland-session";
   in {
    services.greetd = {
      enable = true;
      settings = {
        default-session = {
          command = "${tuigreet} --time --remember --remember-session --session ${hyprland-session}";
	  user = "greeter";
	};
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVDisallocate = true;
    };
}
