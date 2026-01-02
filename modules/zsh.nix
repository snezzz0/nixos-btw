{ pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # p10k instant prompt
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '')
      ''
        # Load p10k theme
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

        # Fix for invisible autocompletions (TokyoNight High Contrast)
        zstyle ':completion:*' menu select
        zstyle ':completion:*:default' list-colors "''${(s.:.)LS_COLORS}" 'ma=48;5;4;fg=15'
        zstyle ':completion:*:descriptions' format '%F{#7dcfff}-- %d --%f'
      ''
    ];

    shellAliases = {
      v = "nvim";
      rebuild = "sudo nixos-rebuild switch --flake .#nixos-btw";
      
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

  home.file.".p10k.zsh".source = ../p10k.zsh;
}
