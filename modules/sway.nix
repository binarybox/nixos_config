{ config, pkgs, lib, ... }:
let
  sway_config = pkgs.stdenv.mkDerivation {
    name = "sway_config";
    dontUnpack = true;
    installPhase = ''
      mkdir -p /etc/sway
      cp ${../configs/sway/custom} /etc/sway/config
    '';
  };
in
{
  # package for sway
  security.polkit.enable = true;


  # Enable the gnome-keyring secrets vault. 
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock-effects
      swayidle
      numix-cursor-theme
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      mako # notification system developed by swaywm maintainer
      sway-contrib.grimshot # screenshot application
      calcure
      feh
      foot
      wf-recorder # screen recording application6
      vlc
      ffmpeg
      jq
      slurp
    ];
  };

  environment.etc = {
    "sway/config".text = ''include custom'';
    "sway/custom".source = ../configs/sway/custom;
    "sway/config.d/lockscreen.conf".source = ../configs/sway/config.d/lockscreen.conf;
    "sway/config.d/power_menu.conf".source = ../configs/sway/config.d/power_menu.conf;
    "sway/config.d/recording.conf".source = ../configs/sway/config.d/recording.conf;
    "sway/config.d/resize.conf".source = ../configs/sway/config.d/resize.conf;
    "sway/config.d/scratchpad.conf".source = ../configs/sway/config.d/scratchpad.conf;
    "sway/config.d/screenshot.conf".source = ../configs/sway/config.d/screenshot.conf;
    "sway/config.d/window_formats.conf".source = ../configs/sway/config.d/window_formats.conf;
    "sway/config.d/workspaces.conf".source = ../configs/sway/config.d/workspaces.conf;
    "sway/images".source = ../configs/sway/images;
    "sway/scripts".source = ../configs/sway/scripts;
    "sway/theme".source = ../configs/sway/theme;
    "sway/swaylock.config".source = ../configs/sway/swaylock.config;
    "sway/mako.config".source = ../configs/sway/mako.config;
    "sway/foot.config".source = ../configs/sway/foot.config;

    "foot".source = ../configs/foot;
    "mako".source = ../configs/mako;
  };

  # login manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time -r --cmd sway";
        user = "leo";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
