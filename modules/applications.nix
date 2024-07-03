{ pkgs, ... }:

let
  fileManager = pkgs.makeDesktopItem {
    name = "file manager";
    desktopName = " File Manager";
    exec = "${pkgs.kitty}/bin/kitty --app-id \"file-manager\" ${pkgs.broot}/bin/broot";
    type = "Application";
  };
in
{

  environment.systemPackages = with pkgs; [
    typora
    csvlens
    broot
    fileManager
    kitty
  ];
}
