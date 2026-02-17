{pkgs, ...}: {
  users.users.nixos = {
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyKQ5Kt/wdnNmIDgyeqf31EPcXoD2cvP9727qI5Buh3 y.a.728@protonmail.ch"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO8V1bg/p2CQhKh0RnyCCcNxyyZiH2OSD6zfbABevbg0 y.a.728@berkeley.edu"
    ];
  };
}
