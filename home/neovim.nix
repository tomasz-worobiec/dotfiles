{
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

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
      rev = "0f7abac168bc624b94f6764859ddbe70c473e931";
      sha256 = "sha256-r3CVhuNJggDKLOpzto30iOFrxVxmq1LFJnCwcNjHSns=";
    };
  };
}
