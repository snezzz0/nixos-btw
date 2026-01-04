# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ============================================================================
  # BOOT
  # ============================================================================
  
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 2;
    efi.canTouchEfiVariables = true;
    grub.enable = false;
  };

  # ============================================================================
  # NETWORKING
  # ============================================================================
  
  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  # ============================================================================
  # LOCALIZATION
  # ============================================================================
  
  time.timeZone = "Europe/Budapest";
  
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # ============================================================================
  # SERVICES
  # ============================================================================
  
  services.displayManager.ly.enable = true;
  services.tumbler.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
   
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  systemd.user.services.rclone-notes = {
    description = "Mount Koofr notes via rclone";
    wantedBy = [ "default.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/notes";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount koofr:notes %h/notes \
          --vfs-cache-mode full \
          --vfs-cache-max-size 2G \
          --vfs-cache-max-age 168h \
          --dir-cache-time 168h \
          --poll-interval 15s \
          --buffer-size 64M \
          --allow-other
      '';
      ExecStop = "/run/wrappers/bin/fusermount -u %h/notes";
      Restart = "on-failure";
      RestartSec = "10s";
      Type = "notify";
      Environment = "PATH=/run/wrappers/bin:${pkgs.fuse}/bin";
    };
  };
  
  # ============================================================================
  # USER & PACKAGES
  # ============================================================================

  users.users.adam = {
    isNormalUser = true;
    description = "Adam K";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Dev
      gcc ripgrep fd rust-analyzer nodejs python3 python3Packages.pip gemini-cli 
      # Terminal
      eza rclone yazi libqalculate      
      # Desktop / Apps
      brave pear-desktop
      waybar rofi wlogout swaybg xwayland-satellite
      # Theming Utils (moved from home-manager)
      bibata-cursors
    ];
  };

  # ============================================================================
  # PROGRAMS
  # ============================================================================
  
  programs.zsh.enable = true;
  programs.niri.enable = true;
  programs.fuse.userAllowOther = true;

  # ============================================================================
  # SYSTEM SETTINGS & PACKAGES
  # ============================================================================
  
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    kitty
    neovim
    firefox
    seahorse
    wget
    git
    stow
    glib
    pulseaudio
    mpv
    unzip
    feh
    dunst
    pavucontrol
    rclone
  ];

  # ============================================================================
  # FONTS
  # ============================================================================
  
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  system.stateVersion = "25.11";
}
