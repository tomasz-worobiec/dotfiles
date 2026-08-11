{
  flake.homeModules.zellij =
    { pkgs, ... }:
    {
      programs.zellij = {
        enable = true;
        enableZshIntegration = true;

        settings = {
          pane_frames = false;
          default_layout = "compact";

          keybinds = {
            _props = {
              clear-defaults = true;
            };

            shared_except = {
              _args = [ "locked" ];

              "bind \"Alt [\"" = {
                GoToPreviousTab = [ ];
              };
              "bind \"Alt ]\"" = {
                GoToNextTab = [ ];
              };

              "bind \"Alt Shift [\"" = {
                MoveTab = [ "Left" ];
              };
              "bind \"Alt Shift ]\"" = {
                MoveTab = [ "Right" ];
              };

              "bind \"Alt d\"" = {
                Detach = [ ];
              };

              "bind \"Alt s\"" = {
                NewPane = "Down";
              };
              "bind \"Alt v\"" = {
                NewPane = "Right";
              };

              "bind \"Alt h\"" = {
                MoveFocus = "Left";
              };
              "bind \"Alt j\"" = {
                MoveFocus = "Down";
              };
              "bind \"Alt k\"" = {
                MoveFocus = "Up";
              };
              "bind \"Alt l\"" = {
                MoveFocus = "Right";
              };

              "bind \"Alt t\"" = {
                NewTab = [ ];
              };

              "bind \"Alt x\"" = {
                CloseFocus = [ ];
              };
              "bind \"Alt X\"" = {
                CloseTab = [ ];
              };

              "bind \"Alt f\"" = {
                ToggleFloatingPanes = [ ];
              };

              "bind \"Alt +\"" = {
                Resize = [ "Increase" ];
              };
              "bind \"Alt =\"" = {
                Resize = [ "Increase" ];
              };
              "bind \"Alt -\"" = {
                Resize = [ "Decrease" ];
              };

            };
          };
        };
      };
    };
}
