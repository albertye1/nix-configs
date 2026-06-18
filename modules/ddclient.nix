{ config, pkgs, ... }:
{
  services.ddclient = {
    enable = true;

    # Porkbun uses the dyndns2 protocol
    protocol = "dyndns2";

    # How often to check for IP changes (in seconds)
    interval = "300";  # 5 minutes

    # Use web-based IP detection
    use = "web, web=checkip.dyndns.org/, web-skip='IP Address'";

    # Porkbun server
    server = "porkbun.com";

    # SSL support
    ssl = true;

    # Verbose logging
    verbose = true;

    # Your domain(s) to update
    # You can add multiple domains separated by commas
    domains = [ "yourdomain.com" ];

    # API key from Porkbun
    username = "pk1_your_api_key";

    # Secret key stored in a file for security
    passwordFile = "/var/lib/ddclient/porkbun-secret";
  };

  # Ensure the password file directory exists with proper permissions
  systemd.tmpfiles.rules = [
    "d /var/lib/ddclient 0700 ddclient ddclient"
  ];
}
