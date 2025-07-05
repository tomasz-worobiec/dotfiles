{
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;

    vimAlias = true;
    viAlias = true;

    extraPackages = with pkgs; [
      fd
      fzf
      gcc
      ripgrep
    ];
  };

  home.file.".config/nvim" = {
    source = pkgs.fetchFromGitHub {
      owner = "tomasz-worobiec";
      repo = "neovim-config";
      rev = "923157bcb005a6a6386c8e3127d69518eb09c4d0";
      sha256 = "sha256-WDh4cca8omTrFx+khH3ytnchO8jejObnu3rOPIiUUOY=";
    };
  };
}
