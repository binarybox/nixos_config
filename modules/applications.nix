{ pkgs, ... }:

let
  fileManager = pkgs.makeDesktopItem {
    name = "file manager";
    desktopName = " File Manager";
    exec = "foot -a \"file-manager\" ${pkgs.broot}/bin/broot";
    type = "Application";
  };
in
{

  environment.systemPackages = with pkgs; [
    typora
    csvlens
    broot
    fileManager
  ];
}
