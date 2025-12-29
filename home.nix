{ config, pkgs, ... }: {
  home.username = "adam";
  home.homeDirectory = "/home/adam";
  home.stateVersion = "25.11";

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic"; # Or "Bibata-Modern-Ice"
    size = 24;
  };

  programs.home-manager.enable = true;

  # Your personal packages
  home.packages = with pkgs; [
    # Dev
    gcc ripgrep fd rust-analyzer nodejs python3 python3Packages.pip
    
    # Terminal
    kitty eza rclone yazi libqalculate
    
    # Desktop / Apps
    brave obsidian pear-desktop firefox
    waybar rofi wofi wlogout swaybg xwayland-satellite seahorse
    
    # Utils
    wget git stow mpv unzip feh bibata-cursors
  ];

  programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "boo-berry";
        editor = {
          line-number = "relative";
          mouse = false;
          bufferline = "always";
          shell = ["zsh" "-c"];
          cursor-shape = {
            insert = "bar";
            normal = "block";
          };
        };
        keys.normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];
        };
      };
    };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
  home.file.".p10k.zsh".source = ./p10k.zsh;
}
