{ config, pkgs, ... }:

{
  imports =
    [
      ../../shared.nix
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-abb61944-d5bc-49dd-99c5-a60f1f17041b".device = "/dev/disk/by-uuid/abb61944-d5bc-49dd-99c5-a60f1f17041b";
  networking.hostName = "latitude5400";

  system.stateVersion = "25.11";
}
