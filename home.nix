{ config, pkgs, lib, inputs, ... }: 
{
  imports = [
    ./modules/kitty.nix
    ./modules/zsh.nix
    ./modules/starship.nix
    ./modules/dunst.nix
  ];
  
  home.username = "adam";
  home.homeDirectory = "/home/adam";
  home.stateVersion = "25.11";
  
  # ============================================================================
  # USER PACKAGES
  # ============================================================================
  
  home.packages = with pkgs; [
    # Development Tools
    gcc
    ripgrep
    fd
    rust-analyzer
    nodejs
    gemini-cli
    opencode
    neovim
    
    # Terminal Utilities
    eza
    rclone
    yazi
    libqalculate
    starship
    stow
    
    # Desktop Applications
    brave
    pear-desktop
    obsidian
    prismlauncher
    dbeaver-bin
    gimp3
    firefox
    seahorse
    kitty
    
    # Window Manager / Desktop Environment
    rofi
    wlogout
    swaybg
    xwayland-satellite
    eww
    dunst
    
    # Media & System Utilities
    mpv
    unzip
    feh
    pavucontrol
    pulseaudio
    pamixer
    
    # Theming
    bibata-cursors
    
    # System libraries (glib needed by some user apps)
    glib
  ];
  
  # ============================================================================
  # USER SERVICES
  # ============================================================================
  
  systemd.user.services.eww = {
    Unit = {
      Description = "Eww Widget Bar";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize";
      ExecStartPost = "${pkgs.bash}/bin/bash -c 'sleep 1 && ${pkgs.eww}/bin/eww open status_bar'";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
  
  # ============================================================================
  # PROGRAM CONFIGURATIONS
  # ============================================================================
  
  programs.home-manager.enable = true;
  
  # Git configuration (user-specific)
  programs.git = {
    enable = true;
    # userName = "Your Name";      # Uncomment and configure
    # userEmail = "you@email.com"; # Uncomment and configure
  };
}
