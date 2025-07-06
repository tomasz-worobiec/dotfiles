{
  pkgs,
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
      bind -n M-[ previous-window
      bind -n M-] next-window

      # Reorder windows
      bind -n M-{ swap-window -t -1\; select-window -t -1
      bind -n M-\} swap-window -t +1\; select-window -t +1

      # Window splits
      bind h split-window -h
      bind v split-window -v

      # Vim aware pane switching
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
      | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"

      bind-key -n 'M-h' if-shell "$is_vim" 'send-keys M-h'  'select-pane -L'
      bind-key -n 'M-j' if-shell "$is_vim" 'send-keys M-j'  'select-pane -D'
      bind-key -n 'M-k' if-shell "$is_vim" 'send-keys M-k'  'select-pane -U'
      bind-key -n 'M-l' if-shell "$is_vim" 'send-keys M-l'  'select-pane -R'

      bind-key -T copy-mode-vi 'M-h' select-pane -L
      bind-key -T copy-mode-vi 'M-j' select-pane -D
      bind-key -T copy-mode-vi 'M-k' select-pane -U
      bind-key -T copy-mode-vi 'M-l' select-pane -R

      # Unbind C-{h, j, k, l}
      unbind-key -T copy-mode-vi 'C-h'
      unbind-key -T copy-mode-vi 'C-j'
      unbind-key -T copy-mode-vi 'C-k'
      unbind-key -T copy-mode-vi 'C-l'
      unbind-key -T root 'C-h'
      unbind-key -T root 'C-j'
      unbind-key -T root 'C-k'
      unbind-key -T root 'C-l'
      unbind-key -T copy-mode 'C-k'
      unbind-key -T copy-mode 'C-h'

      # Theme
      set -g status-style "fg=#bdae93,bg=#32302f"
      set -g window-status-style  "fg=#bdae93,bg=#32302f"
      set -g window-status-current-style  "fg=#32302f,bg=#a9b665"

      # Status bar
      set -g status-left "[#S]"
      set -g status-right "[%d-%m-%Y][%H:%M][#(whoami)@#(hostname)]"

      set-window-option -g window-status-current-format "[(#I) #W]"
      set-window-option -g window-status-format "[(#I) #W]"
    '';
  };
}
