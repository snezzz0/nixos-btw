# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/theme.nix
  ];

  # ============================================================================
  # BOOT
  # ============================================================================
  
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 2;  # Keep only last 2 generations
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
  
  # Display manager
  services.displayManager.ly.enable = true;

  services.tumbler.enable = true;

  # GNOME services
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
   
  # Keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # ============================================================================
  # PROGRAMS
  # ============================================================================
  
 programs.zsh.enable = true;

 programs.niri.enable = true;
  
 users.users.adam = {
    isNormalUser = true;
    description = "Adam K";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
 };

  # ============================================================================
  # SYSTEM SETTINGS & PACKAGES
  # ============================================================================

  nix.settings.experimental-features = [ "nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    
    # Terminal & Shell
    kitty
    neovim
    
    # Window manager & Desktop
    firefox
    
    # Security & Keyring
    seahorse
    
    # Theming
    bibata-cursors
    
    # Utilities
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
  ];

  # ============================================================================
  # FONTS
  # ============================================================================
  
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # ============================================================================
  # SYSTEM STATE VERSION
  # ============================================================================
  
  system.stateVersion = "25.11";
}
