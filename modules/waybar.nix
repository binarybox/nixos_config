{ config, pkgs, lib, ... }:
let
  media_player = pkgs.writeShellScriptBin "media_player" ''
    playerctl metadata -s --format '{"alt": "{{status}}", "tooltip": "󰝚 {{playerName}}\ntitle: {{markup_escape(title)}}\nartist: {{markup_escape(artist)}}"}'; 
    if [ $? -eq 1 ]; then 
      echo {\"alt\": \"No_player\", \"tooltip\": \"\"};
    fi
  '';

  custom_waybar = pkgs.writeShellScriptBin "custom_waybar" ''
    exec waybar -c /etc/waybar/config.jsonc -s /etc/waybar/style.css;
  '';

  weather_script = pkgs.stdenv.mkDerivation {
    name = "weather";
    propagatedBuildInputs = [
      (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
        requests
      ]))
    ];
    dontUnpack = true;
    installPhase = "install -Dm755 ${./scripts/weather.py} $out/bin/weather.py";
  };

  waybar_config = pkgs.stdenv.mkDerivation {
    name = "waybar_config";
    buildPhase = ''
      mkdir -p $out/bin/waybar/
      cp -r ${configs/waybar} $out/bin/waybar
    '';
    installPhase = "install -Dm755 ${./configs/waybar/custom_waybar} $out/bin/custom_waybar";
    dontUnpack = true;
  };
in
{
  environment.systemPackages =
    with pkgs; [
      media_player
      custom_waybar
      # waybar_config
      weather_script
      workstyle # icons for workspace applications
      libnotify # notifier
      dunst # notify 
      bluetuith # bluetooth tui
      playerctl
      pulsemixer
      alsa-utils # audio mixer tui
      brightnessctl
      acpi
      ponymix
      wttrbar
      wofi
    ];

  programs.waybar = {
    enable = true;
  };

  environment.etc.waybar =  {
    source = ../configs/waybar;
  };
}
