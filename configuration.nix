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
  # SYSTEM SERVICES
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
  # SYSTEM PROGRAMS
  # ============================================================================
  
  programs.zsh.enable = true;
  programs.niri.enable = true;
  programs.fuse.userAllowOther = true;
  
  # ============================================================================
  # USER ACCOUNTS
  # ============================================================================
  
  users.users.adam = {
    isNormalUser = true;
    description = "";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  
  # ============================================================================
  # NIX SETTINGS
  # ============================================================================
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  
  # ============================================================================
  # SYSTEM PACKAGES (minimal essentials only)
  # ============================================================================
  
  environment.systemPackages = with pkgs; [
    git
    wget
    vim  
  ];
  
  # ============================================================================
  # FONTS (system-wide availability)
  # ============================================================================
  
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.code-new-roman
  ];
  
  system.stateVersion = "25.11";
}
