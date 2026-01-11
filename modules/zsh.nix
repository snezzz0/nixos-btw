{ pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      strategy = ["history"];
    };
    syntaxHighlighting.enable = true;
    
    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
    
    initContent = ''
      # Completion Styling (TokyoNight Fix)
      zstyle ':completion:*' menu select
      zstyle ':completion:*:default' list-colors "''${(s.:.)LS_COLORS}" 'ma=48;5;4;fg=15'
      zstyle ':completion:*:descriptions' format '%F{#7dcfff}-- %d --%f'
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      
      # Kitty Integration
      if test -n "$KITTY_INSTALLATION_DIR"; then
        export KITTY_SHELL_INTEGRATION="no-rc"
        autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
        kitty-integration
        unfunction kitty-integration
      fi
    '';
    
    shellAliases = {
      v = "nvim";
      rebuildall = "sudo nixos-rebuild switch --flake .#nixos-btw";
      rebuild = "home-manager switch --flake .#adam";      
      cd = "z";
      
      c = "clear";
      l = "eza -lh --icons=auto";
      ls = "eza -1 --icons=auto";
      ll = "eza -lha --icons=auto --sort=name --group-directories-first";
      ld = "eza -lhD --icons=auto";
      lt = "eza --icons=auto --tree";
      
      mount-server = "mkdir -p ~/mnt/server && rclone mount home-server: ~/mnt/server --vfs-cache-mode full &";
      umount-server = "fusermount -u ~/mnt/server";
      poweroff = "systemctl poweroff";
      reboot = "systemctl reboot";
    };
  };
  
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
