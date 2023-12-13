{ 
  pkgs ? import <nixpkgs> { system = builtins.currentSystem; }
, fetchurl
, google-chrome ? pkgs.google-chrome
, lib
, makeDesktopItem
, runtimeShell
, symlinkJoin
, writeScriptBin
}:

let
  name = "discord-via-google-chrome";

  meta = {
    description = "Open Discord1 in Google Chrome app mode";
    longDescription = ''
      Netflix is a video streaming service providing films, TV series and exclusive content. See https://www.netflix.com.

      This package installs an application launcher item that opens Netflix in a dedicated Google Chrome window. If your preferred browser doesn't support Netflix's DRM, this package provides a quick and easy way to launch Netflix on a supported browser, without polluting your application list with a redundant, single-purpose browser.
    '';
    homepage = google-chrome.meta.homepage or null;
    license = lib.licenses.unfree;
    maintainers = [ lib.maintainers.roberth ];
    platforms = google-chrome.meta.platforms or lib.platforms.all;
  };

  desktopItem = makeDesktopItem {
    inherit name;
    # Executing by name as opposed to store path is conventional and prevents
    # copies of the desktop file from bitrotting too much.
    # (e.g. a copy in ~/.config/autostart, you lazy lazy bastard ;) )
    exec = name;
    icon = fetchurl {
      name = "netflix-icon-2016.png";
      url = "https://assets.nflxext.com/us/ffe/siteui/common/icons/nficon2016.png";
      sha256 = "sha256-c0H3uLCuPA2krqVZ78MfC1PZ253SkWZP3PfWGP2V7Yo=";
      meta.license = lib.licenses.unfree;
    };
    desktopName = "Discord via Google Chrome";
    genericName = "A video streaming service providing films and exclusive TV series";
    categories = [ "TV" "AudioVideo" "Network" ];
    startupNotify = true;
  };

  script = writeScriptBin name ''
    #!${runtimeShell}
    exec ${google-chrome}/bin/${google-chrome.meta.mainProgram} \
        --app=https://discord.com/app \
      --no-first-run --no-default-browser-check --no-crash-upload
  '';

in

symlinkJoin {
  inherit name meta;
  paths = [ script desktopItem ];
}

