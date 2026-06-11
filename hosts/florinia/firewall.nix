
{
  config,
  pkgs,
  ...
}: {
  networking.firewall = {
    enable = true;
    allowedTcpPorts = [ 22 ];
    extraInputRules = ''
    	ip saddr 192.168.0.0/24 tcp dport 2283 accept
	ip saddr 5.78.181.20 tcp dport 2283 accept
	ip saddr 5.78.181.20 tcp dport 3000 accept
	ip saddr 5.78.181.20 tcp dport 3001 accept
    '';
  };
}
