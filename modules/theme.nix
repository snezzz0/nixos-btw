{ pkgs, ... }: {
  stylix = {
    enable = true;
    image = ../walls/12.jpg;
    polarity = "dark";
    opacity.terminal = 0.95;
     
    base16Scheme = {
      base00 = "1a1b26"; # Background
      base01 = "565f89"; # Alt Background
      base02 = "9aa5ce"; # Selection
      base03 = "414868"; # Comments (too dark for suggestions!)
      base04 = "9aa5ce"; # Brightened Comments (Use this for suggestions)
      base05 = "c0caf5"; # Main Foreground
      base06 = "d5d6db"; # Bright Foreground
      base07 = "ffffff"; # Brightest

      base08 = "f7768e"; # red
      base09 = "ff9e64"; # orange
      base0A = "e0af68"; # yellow
      base0B = "9ece6a"; # green
      base0C = "4fd6be"; # cyan
      base0D = "7aa2f7"; # blue
      base0E = "bb9af7"; # purple
      base0F = "b16286"; # brown / magenta accent
    };


    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
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
        applications = 12;
        terminal = 12;
        desktop = 11;
      };
    };
  };
}
