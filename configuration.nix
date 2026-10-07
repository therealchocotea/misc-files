{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./sandboxing.nix
    ./hm.nix
  ];

  # Use Zen Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.zfs.requestEncryptionCredentials = true;
  boot.zfs.forceImportRoot = false;
  boot.supportedFilesystems = [
    "zfs"
    "ext4"
    "ntfs"
    "exfat"
    "vfat"
  ];

  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "*-*-1,5,10,15,20,25,30 18:00";
    };
    trim.enable = true;
  };

  fileSystems."/" = {
    device = "zpool/root";
    fsType = "zfs";
  };
  fileSystems."/nix" = {
    device = "zpool/nix";
    fsType = "zfs";
  };
  fileSystems."/var" = {
    device = "zpool/var";
    fsType = "zfs";
  };
  fileSystems."/home" = {
    device = "zpool/home";
    fsType = "zfs";
  };

  # For the UGEE S640 graphics tablet to work
  hardware.opentabletdriver.enable = true;
  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input"
  '';

  networking.wireless.enable = true;
  networking.hostName = "puterputer"; # Define your hostname.
  networking.hostId = "cda96004";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Berlin";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  services.earlyoom = {
    enable = true;
    freeSwapThreshold = 10;
    freeMemThreshold = 5;
  };

  console.keyMap = "de-latin1";
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.xserver.xkb.layout = "de";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;
  services.tlp.enable = true;

  users.users.anon = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    nixfmt
    element-desktop
    curl
    tor
    qbittorrent
    discord
    whatsie
    keepassxc
    tor-browser
    gdb
    gnumake
    nasm
    qemu
    mtools
    dosfstools
    pkgsCross.gnu64.buildPackages.gcc
    pkgsCross.gnu64.buildPackages.binutils
    backintime
    backintime-qt
    nicotine-plus
    mpv
    ffmpeg
    pandoc
    tmux
    irssi
    git
    fossil
    sbcl
    clisp
    xfce4-whiskermenu-plugin
    gimp
    krita
    nmap
    aircrack-ng
    qpdfview
    rsync
    sshfs
    sshfs-fuse
    pan
    claws-mail
    yt-dlp
    strawberry
    hugo
    i2pd-tools
    i2p
    librewolf-bin
    gpa
    abcde
    cdparanoia
    aria2
    jq
    anki
    blackbird
    tcpdump
    mg
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };

  services.emacs = {
    enable = true;
  };

  services.displayManager.defaultSession = "xfce";

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  system.copySystemConfiguration = true;

  system.stateVersion = "26.05"; # Did you read the comment?
}
