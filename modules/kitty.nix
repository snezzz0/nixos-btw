{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    
    settings = {
      # --------- WINDOW ---------
      confirm_os_window_close = 0;
      # --------- SHELL ---------
      shell = "zsh";
    };
  };
}
