{
  lib,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # zen browser
    inputs.zen-browser.packages."${pkgs.system}".default

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # 1password
    _1password-cli
    _1password-gui

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    glow # markdown previewer in terminal
    obsidian

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # web stuff
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    yarn

    # code editor
    zed-editor

    # social
    signal-desktop
    discord-canary
  ];

  services = {
    udiskie.enable = true;
  };
}
