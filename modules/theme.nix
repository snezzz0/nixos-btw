{ pkgs, ... }: {
  stylix = {
    enable = true;
    image = ../walls/12.jpg;
    polarity = "dark";
    opacity.terminal = 0.85;
     
    base16Scheme = {
      base00 = "282828"; # Background
      base01 = "2a2a2a"; # Lighter Background
      base02 = "6f6f6f"; # Selection
      base03 = "8a8a8a"; # Comments
      base04 = "b0b0b0"; # Muted
      base05 = "d8d8d8"; # Foreground
      base06 = "f0f0f0"; # Bright Foreground
      base07 = "ffffff"; # Brightest
      base08 = "9d79d6"; # Red -> Changed to Purple
      base09 = "b392e0"; # Orange -> Light Purple
      base0A = "b0b0b0"; # Yellow
      base0B = "9d79d6"; # Green -> Changed to Purple
      base0C = "8a8a8a"; # Cyan
      base0D = "9d79d6"; # Blue -> Main Purple
      base0E = "9d79d6"; # Magenta -> Main Purple
      base0F = "9d79d6"; # Brown -> Main Purple
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sizes = {
        applications = 11;
        terminal = 11;
        desktop = 10;
      };
    };
  };
}
