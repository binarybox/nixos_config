{ pkgs, ... }:

let
  firefox_webapp = pkgs.stdenv.mkDerivation {
    name = "firefox_webapp";
    dontUnpack = true;
    installPhase = "install -Dm755 ${./scripts/webapp.sh} $out/bin/firefox_webapp";
  };
  bandcamp_desktop_item = pkgs.makeDesktopItem {
    name = "bandcamp";
    desktopName = " bandcamp";
    exec = "firefox_webapp bandcamp bandcamp.com";
    type = "Application";
  };
  telegram_desktop_item = pkgs.makeDesktopItem {
    name = "telegram";
    desktopName = " telegram";
    exec = "firefox_webapp telegram https://web.telegram.org/";
    type = "Application";
  };
in
{
  environment.systemPackages = [
    bandcamp_desktop_item
    telegram_desktop_item
    firefox_webapp
  ];
}
