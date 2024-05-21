{ config, pkgs, lib, ... }:
{
  # package for sway
  security.polkit.enable = true;

  fonts.packages = with pkgs; [
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  # Enable the gnome-keyring secrets vault. 
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      mako # notification system developed by swaywm maintainer
      rofi
      swaylock-effects
      swayidle
      workstyle # icons for workspace applications
      libnotify # notifier
      pulsemixer # audio mixer tui
      bluetuith # bluetooth tui
      numix-cursor-theme
      sway-contrib.grimshot # screenshot application
      calcurse
      pcmanfm
      feh
      foot
      wf-recorder # screen recording application6
      vlc
      ffmpeg
      jq
      slurp
      
    ];
  };

  programs.dconf.enable = true;

  programs.waybar.enable = true;
}
