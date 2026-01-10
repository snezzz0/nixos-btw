{ pkgs, lib, ... }: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    prefix = "C-s";  # Ctrl+s as prefix
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];
    
    extraConfig = ''
      # True color support
      set -ag terminal-overrides ",xterm-256color:RGB"
      
      # Reload config
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"
      
      # Window numbering
      set -g renumber-windows on
      
      # Status bar position
      set-option -g status-position top
      
      # Pane navigation (vim-style)
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      
      # Better splits (open in same directory)
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      
      # Copy mode
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      
      # TokyoNight theme - sharp style
      set -g status-style bg=default,fg=#c0caf5
      set -g status-left ""
      set -g status-right "#[fg=#7aa2f7,bg=#1a1b26] #S #[fg=#9ece6a,bg=#1a1b26] %H:%M "
      
      # Window status - sharp style (no rounded corners)
      set -g window-status-format "#[fg=#565f89,bg=#1a1b26] #I:#W "
      set -g window-status-current-format "#[fg=#1a1b26,bg=#7aa2f7,bold] #I:#W #[fg=#7aa2f7,bg=#1a1b26]"
      
      # Pane borders
      set -g pane-border-style fg=#414868
      set -g pane-active-border-style fg=#7aa2f7
      
      # Message style
      set -g message-style bg=#7aa2f7,fg=#1a1b26
      set -g message-command-style bg=#7aa2f7,fg=#1a1b26
    '';
  };
}
