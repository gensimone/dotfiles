{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Rome";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  documentation.man.generateCaches = true;

  services.displayManager = {
    gdm.enable = true;
    autoLogin = {
      enable = true;
	  user = "simone";
    };
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.simone = {
    isNormalUser = true;
    description = "Simone Gentili";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
    bash-completion
    clang-tools
    cmus
    fd
    ffmpeg
    firefox
    foot
    fzf
    gcc
    git
    gnumake
    grim
    mako
    man-pages
    mpv
    neovim
    pipx
    poetry
    pyright
    python3
    qbittorrent-nox
    ripgrep
    slurp
    swayidle
    swayimg
    swaylock
    telegram-desktop
    tmux
    tree
    tree-sitter
    vim
    wget
    wl-clipboard
    wmenu
    xdg-user-dirs
    yt-dlp
    zathura
  ];

  environment.shellAliases = {
      rebuild = "nixos-rebuild switch --sudo --flake ~/nixos";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
