# environment/default.nix
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    #buildtools
    gcc gnumake
    wget neovim ranger
    busybox git
    wezterm nodejs
    foot zbar
    stow home-manager
    networkmanager pipewire wireplumber
    pavucontrol
    neovim ripgrep
    lazygit gdu bottom
    rofi-wayland rofi-bluetooth waybar
    swaybg swaylock-effects
    dunst xdg-utils imagemagick
    wl-clipboard grim slurp
    jq libnotify hyprpicker
    gpick pamixer
    xdg-desktop-portal-hyprland swww
    gnome.adwaita-icon-theme eww-wayland
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.localBinInPath = true;
}
