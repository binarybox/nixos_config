{ pkgs, ... }:

let
  fileManager = pkgs.makeDesktopItem {
    name = "file manager";
    desktopName = "File Manager (broot)";
    exec = "foot -a \"settings-window\" broot";
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
