{
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;

    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
    };

    history = {
      size = 10000;
      share = true;
      ignoreAllDups = true;
    };

    syntaxHighlighting.enable = true;

    autosuggestion.enable = true;

    enableCompletion = true;
    completionInit = ''
      if [[ -n $(print ~/.zcompdump(Nmh+24)) ]] {
        compinit
      } else {
        compinit -C
      }
    '';

    initContent = ''
        ZSH_AUTOSUGGEST_STRATEGY=(history completion)
        ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    '';

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "fzf-tab.zsh";
      }
      {
        name = "autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "zsh-autosuggestions.zsh";
      }
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "zsh-vi-mode.plugin.zsh";
      }
      {
        name = "bureau";
        src = pkgs.fetchFromGitHub {
          owner = "isqua";
          repo = "bureau";
          rev = "d4750adf1dddcc342eeb77144842401911cb3f59";
          sha256 = "sha256-7MeM0jmIsuiwCNjmvFWuHupJQFwdsw7NsDSvEZXHcCk=";
        };
        file = "prompt_bureau_setup.zsh";
      }
    ];
  };

  # Dependencies
  programs.fzf.enable = true;
}
