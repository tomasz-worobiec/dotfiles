{
    config,
    pkgs,
    lib,
    ...
}:
{
    programs.tmux = {
        enable = true;
        clock24 = true;
        escapeTime = 0;
        plugins = with pkgs.tmuxPlugins; [
            vim-tmux-navigator
        ];
        extraConfig = ''
            # Colors fix
            set -g default-terminal "xterm-256color"
            set -ga terminal-overrides ",*256col*:Tc"
            set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
            set-environment -g COLORTERM "truecolor"

            # Enable mouse
            set -g mouse on

            # Prefix
            set-option -g prefix C-Space

            # Window switch
            bind -n C-[ previous-window
            bind -n C-] next-window

            # Reorder windows
            bind -n M-[ swap-window -t -1\; select-window -t -1
            bind -n M-] swap-window -t +1\; select-window -t +1

            # Window splits
            bind h split-window -h
            bind v split-window -v

            # Pane switching
            bind -n M-h select-pane -L
            bind -n M-j select-pane -D 
            bind -n M-k select-pane -U
            bind -n M-l select-pane -R

            # ! WORK IN PROGRESS ! #

            # Ustawienia stylu
            set -g status-left-length 40
            set -g status-right-length 100
            set -g status-interval 5

            # Ikony i symbole
            set -g status-left "#[$status-style] ❐ #S #[fg=black,bg=cyan] ❐ "

            # Prawy status z datą, godziną i użytkownikiem
            set -g status-right "#[fg=green]#(whoami) #[fg=yellow]%Y-%m-%d #[fg=$clock-mode-colour]%H:%M"

            # Style dla aktywnego i nieaktywnego okna
            set-window-option -g window-status-current-format "#[$window-status-style] #I:#W "
            set-window-option -g window-status-format "#[$window-status-current-style] #I:#W "

            # Aktywne okno
            set -g pane-active-border-style fg=yellow
        '';
    };
}
