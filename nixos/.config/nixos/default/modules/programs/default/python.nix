{ pkgs, ... }:
{
environment.systemPackages = with pkgs; [
   (python3.withPackages(ps: with ps; [ wheel pip pygobject3 gst-python dbus-python psutil line_profiler discordpy]))
  ];
}

