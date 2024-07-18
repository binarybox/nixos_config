{ pkgs, ... }:

let
  file_manager = pkgs.makeDesktopItem {
    name = "file manager";
    desktopName = " File Manager";
    exec = "${pkgs.kitty}/bin/kitty -c /etc/kitty/theme.conf --app-id \"file-manager\" ${pkgs.broot}/bin/broot";
    type = "Application";
  };
in
{

  environment.systemPackages = with pkgs; [
    typora
    csvlens
    broot
    file_manager
    kitty
  ];

  environment.etc = {
    kitty.source = ../configs/kitty;
  };
}
