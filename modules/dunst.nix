{ pkgs, lib, ... }: {
  services.dunst = {
    enable = true;
    
    settings = {
      global = {
        follow = "mouse";
        indicate_hidden = true;
        offset = "10x10";
        notification_height = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 0;
        frame_width = 2;
        frame_color = lib.mkForce "#7aa2f7";  # TokyoNight blue
        separator_color = lib.mkForce "frame";
        sort = true;
        idle_threshold = 120;
        line_height = 0;
        markup = "full";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        word_wrap = true;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;
        min_icon_size = 0;
        max_icon_size = 64;
        icon_path = "/run/current-system/sw/share/icons/Papirus-Dark/16x16/status/:/run/current-system/sw/share/icons/Papirus-Dark/16x16/devices/:/run/current-system/sw/share/icons/Papirus-Dark/16x16/actions/:/run/current-system/sw/share/icons/Papirus-Dark/16x16/animations/:/run/current-system/sw/share/icons/Papirus-Dark/16x16/apps/:/run/current-system/sw/share/icons/Papirus-Dark/16x16/categories/:/run/current-system/sw/share/icons/Papirus-Dark/16x16/emblems/:/run/current-system/sw/share/icons/Papirus-Dark/16x16/emotes/:/run/current-system/sw/share/icons/Papirus-Dark/16x16/devices/mimetypes:/run/current-system/sw/share/icons/Papirus-Dark/16x16/panel/:/run/current-system/sw/share/icons/Papirus-Dark/16x16/places/";
        dmenu = "${pkgs.wofi}/bin/wofi -p dunst:";
        browser = "${pkgs.firefox}/bin/firefox --new-tab";
        title = "Dunst";
        class = "Dunst";
        corner_radius = 10;
        timeout = 5;
      };
      
      urgency_low = {
        background = lib.mkForce "#1a1b26";
        foreground = lib.mkForce "#c0caf5";
      };
      
      urgency_normal = {
        background = lib.mkForce "#1a1b26";
        foreground = lib.mkForce "#c0caf5";
      };
      
      urgency_critical = {
        background = lib.mkForce "#1a1b26";
        foreground = lib.mkForce "#c0caf5";
        frame_color = lib.mkForce "#f7768e";
      };
    };
  };
}
