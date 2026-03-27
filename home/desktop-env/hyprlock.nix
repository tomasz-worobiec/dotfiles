{
  resources,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading = true;
        hide_cursor = true;
      };

      background = [
        {
          path = "${resources.wallpaper}";
          blur_passes = 3;
          blur_size = 8;
          contrast = 1;
          brightness = 0.5;
          vibrancy = 0.2;
          vibrancy_darkness = 0.2;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "350, 60";
          outline_thickness = 2;
          font_color = "rgba(242, 243, 244, 0.75)";
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = "rgba(242, 243, 244, 0.75)";
          inner_color = "rgba(0, 0, 0, 0.2)";
          fade_on_empty = false;
          rounding = -1;
          check_color = "rgb(204, 136, 34)";
          placeholder_text = "Password...";
          hide_input = false;
          position = "0, -200";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = "28";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%H:%M\")\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = "95";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
