{ config, pkgs, lib, ... }: {
  imports = [
    ./modules/zsh.nix
    ./modules/helix.nix
    ./modules/kitty.nix
  ];
  
  stylix.targets = {
    helix.enable = false;
  };
  
  home.username = "adam";
  home.homeDirectory = "/home/adam";
  home.stateVersion = "25.11";
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic"; 
    size = 24;
  };
  programs.home-manager.enable = true;
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
}
