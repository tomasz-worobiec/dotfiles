{
    config,
    pkgs,
    lib,
    ...
}:
let 
    aliases = {
        ll = "ls -l";
        ".." = "cd ..";
    };
    sha256 = lib.fakeSha256;
in
{
    programs.zsh = {
        enable = true;
        syntaxHighlighting.enable = true;

        enableCompletion = true;
        autosuggestion.enable = true;

        shellAliases = aliases;

        history = {
            share = true;
            expireDuplicatesFirst = true;
        };

        initExtra = ''

        '';

        plugins = [
            {
                name = "zsh-autocomplete";
                src = pkgs.fetchFromGitHub {
                    owner = "marlonrichert";
                    repo = "zsh-autocomplete";
                    rev = "24.09.04";
                    sha256 = "sha256-o8IQszQ4/PLX1FlUvJpowR2Tev59N8lI20VymZ+Hp4w=";
                };
            }
            {
                name = "zsh-autosuggestions";
                src = pkgs.fetchFromGitHub {
                    owner = "zsh-users";
                    repo = "zsh-autosuggestions";
                    rev = "v0.7.0";
                    sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
                };
            }
        ];
    };
}
