{ pkgs, lib, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      add_newline = false;
      palette = lib.mkForce "tokyonight";
      format = "$directory$git_branch$git_status$character";
      right_format = "$all";
      
      character = {
        vicmd_symbol = "[N] >>>";
        success_symbol = "[➜](bold #9ece6a)";
        error_symbol = "[➜](bold #f7768e)";
      };
      
      directory = {
        style = "bold #7aa2f7";
        read_only = " 󰌾";
        truncation_length = 3;
        truncate_to_repo = true;
        format = "[$path]($style)[$read_only]($read_only_style) ";
      };
      
      python = {
        symbol = " ";
        format = "[$\{symbol}$\{version}]($style) ";
        style = "bold #e0af68";
      };
      
      nodejs = {
        symbol = " ";
        format = "[$\{symbol}$\{version}]($style) ";
        style = "bold #9ece6a";
      };
      
      cpp = {
        symbol = " ";
        format = "[$\{symbol}$\{version}]($style) ";
        style = "bold #7aa2f7";
      };
      
      rust = {
        symbol = "󱘗 ";
        format = "[$\{symbol}$\{version}]($style) ";
        style = "bold #ff9e64";
      };
      
      package = {
        symbol = "🚀 ";
        format = "[$\{symbol}$\{version}]($style) ";
        style = "bold #bb9af7";
      };
      
      git_branch = {
        symbol = "";
        format = "[$symbol$branch]($style) ";
        style = "bold #f7768e";
      };
      
      git_status = {
        format = "\\[$all_status$ahead_behind\\] ";
        style = "bold #bb9af7";
        untracked = "";
        modified = "[!$count](bold #ff9e64)";
        staged = "[+$count](bold #9ece6a)";
        renamed = "[»$count](bold #7aa2f7)";
        deleted = "[✘$count](bold #f7768e)";
        ahead = "[⇡$count](bold #bb9af7)";
        behind = "[⇣$count](bold #bb9af7)";
        diverged = "[⇕⇡$ahead_count⇣$behind_count](bold #bb9af7)";
      };
      
      golang = {
        disabled = true;
      };
      
      cmd_duration = {
        min_time = 2000;
        format = "[$duration]($style) ";
        style = "bold #e0af68";
      };
      
      palettes.tokyonight = lib.mkForce {
        background = "#1a1b26";
        foreground = "#c0caf5";
        red = "#f7768e";
        green = "#9ece6a";
        yellow = "#e0af68";
        blue = "#7aa2f7";
        magenta = "#bb9af7";
        cyan = "#7dcfff";
        orange = "#ff9e64";
      };
    };
  };
}
