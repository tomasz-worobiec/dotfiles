{
  ...
}:
let
  wallpaper = builtins.fetchurl {
    url = "https://gruvbox-wallpapers.pages.dev/wallpapers/brands/nixos.png";
    sha256 = "sha256:0s22k5nw3kli9h7h6wb98lrpp3zp0n8zc5bfvyg56rdr57ykk11k";
  };
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${wallpaper}"
      ];
      wallpaper = [
        ",${wallpaper}"
      ];
    };
  };
}
