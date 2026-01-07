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
      gcc ripgrep fd rust-analyzer nodejs gemini-cli 
      # Terminal
      eza rclone yazi libqalculate
      # Desktop / Apps
      brave pear-desktop obsidian prismlauncher dbeaver-bin gimp3 
      waybar rofi wlogout swaybg xwayland-satellite
      # Theming
      bibata-cursors
      # System essentials (moved from system packages)
      kitty neovim firefox seahorse wget git stow glib
      pulseaudio mpv unzip feh dunst pavucontrol
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
    # Minimal system essentials only
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
