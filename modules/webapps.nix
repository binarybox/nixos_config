{ pkgs, ... }:

let
  bandcampDestkopItem = pkgs.makeDesktopItem {
    name = "bandcamp";
    desktopName = "bandcamp";
    exec = "firefox --profile webapp -url=bandcamp.com";
    type="Application";
  };
in {
  environment.systemPackages = [ bandcampDestkopItem ];
}