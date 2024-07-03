{ pkgs, ... }:

let
  bandcamp_desktop_item = pkgs.makeDesktopItem {
    name = "bandcamp";
    desktopName = " bandcamp";
    exec = "firefox --profile /home/leo/.config/webapp -url=bandcamp.com";
    type="Application";
  };
in {
  environment.systemPackages = [ bandcamp_desktop_item ];
}