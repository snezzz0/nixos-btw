{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./modules/kitty.nix
    ./modules/zsh.nix
    ./modules/starship.nix
    ./modules/dunst.nix
    # ./modules/tmux.nix
    # ./modules/nvim.nix
  ];
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
  
  home.packages = with pkgs; [
    waybar
  ];
  
  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
  
  programs.home-manager.enable = true;
}
