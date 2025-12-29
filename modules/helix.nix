{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "boo_berry";
      
      keys.normal = {
        esc = ["collapse_selection" "keep_primary_selection"];
      };
      
      editor = {
        line-number = "relative";
        mouse = false;
        bufferline = "multiple";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        lsp.display-messages = true;
      };
    };
  };
}
