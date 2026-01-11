{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    
    settings = {
      # --------- WINDOW ---------
      confirm_os_window_close = 0;
      window_padding_width = 6;
      
      # --------- FONT ---------
      adjust_column_width = 1; 
      
      # --------- SHELL ---------
      shell = "zsh";
    };
  };
}
