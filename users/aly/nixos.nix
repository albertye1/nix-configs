{pkgs, ...}: {
  users.users.aly = {
    shell = pkgs.nushell;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyKQ5Kt/wdnNmIDgyeqf31EPcXoD2cvP9727qI5Buh3 y.a.728@protonmail.ch"
    ];
  };
}
