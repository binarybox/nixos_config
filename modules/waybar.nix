{ config, pkgs, lib, ... }:
let
  media_player = pkgs.writeShellScriptBin "media_player" ''
    
    playerctl metadata -s --format '{"alt": "{{status}}", "tooltip": "󰝚 {{playerName}}\ntitle: {{markup_escape(title)}}\nartist: {{markup_escape(artist)}}"}'; 
    if [ $? -eq 1 ]; then 
      echo {\"alt\": \"No_player\", \"tooltip\": \"\"};
    fi

      
  '';
  custom_waybar = pkgs.writeShellScriptBin "custom_waybar" ''
    # # signal to load the player icons
    # pkill pactl;
    # pactl subscribe | grep --line-buffered "sink-input" | while read -r UNUSED_LINE; do pkill -RTMIN+5 waybar; done & 

    exec waybar -c /etc/nixos/configs/waybar/config.jsonc -s /etc/nixos/configs/waybar/style.css;

  '';
in
{
  environment.systemPackages =
    with pkgs; [
      media_player
      custom_waybar
      workstyle # icons for workspace applications
      libnotify # notifier
      alsa-utils # audio mixer tui
      bluetuith # bluetooth tui
      playerctl
      brightnessctl
      dunst
      acpi
      ponymix
      wttrbar
      wofi
    ];

  programs.waybar = {
    enable = true;
  };
}
