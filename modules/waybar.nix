{ config, pkgs, lib, ... }:
let
  media_player = pkgs.writeShellScriptBin "media_player" ''
      case $1 in
        play-pause)
            playerctl play-pause
    	    ;;
        info)
            title=$(playerctl metadata | grep title | awk '{$1=$2=""; print $0}' | awk '{$1=$1;print}')
            album=$(playerctl metadata | grep album | awk '{$1=$2=""; print $0}' | awk '{$1=$1;print}')
            artist=$(playerctl metadata | grep artist | awk '{$1=$2=""; print $0}' | awk '{$1=$1;print}')
            echo { \
            \"alt\": \"$(playerctl status)\", \
            \"album\": \"$album\", \
            \"artist\": \"$artist\", \
            \"title\": \"$title\", \
            \"tooltip\": \"$title\" \
            }
            ;;
        help)
            echo "Usage: $0 | play-pause"
            ;;
      esac
  '';
  custom_waybar = pkgs.writeShellScriptBin "custom_waybar" ''
    exec waybar -c /etc/nixos/modules/waybar/config.jsonc -s /etc/nixos/modules/waybar/style.css
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
    ];

  programs.waybar.enable = true;
}
