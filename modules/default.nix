{ pkgs, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./sway.nix
      ./vscode.nix
      ./zsh.nix
      ./tuigreet.nix
      # ./hello-world.nix
      # ./timer.nix
      ./fonts.nix
      ./waybar.nix
      ./wofi_calc.nix
      ./webapps.nix
      ./applications.nix
      # ./battop.nix
    ];

  environment.systemPackages = with pkgs; [
    numix-cursor-theme
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    swaylock-effects
    swayidle
    sway-contrib.grimshot # screenshot application
    calcure
    feh
    foot
    wf-recorder # screen recording application6
    vlc
    ffmpeg
    jq
    slurp

    google-chrome # sometimes tis is required
  ];
}
