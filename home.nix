{ config, pkgs, lib, inputs, ... }: {
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
}
