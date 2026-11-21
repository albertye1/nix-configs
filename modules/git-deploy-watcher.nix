{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.gitDeployWatcher;

  daemon = pkgs.writeShellApplication {
    name = "git-deploy-watcher-daemon";
    runtimeInputs = [pkgs.git pkgs.docker pkgs.jq pkgs.coreutils];
    text = builtins.readFile ./scripts/git-deploy-watcher-daemon.sh;
  };

  ctl = pkgs.writeShellApplication {
    name = "git-deploy-watcher-ctl";
    runtimeInputs = [pkgs.systemd pkgs.jq pkgs.coreutils];
    text = builtins.readFile ./scripts/git-deploy-watcher-ctl.sh;
  };
in {
  options.services.gitDeployWatcher = {
    enable = mkEnableOption "on-demand daemons that poll a git checkout for upstream updates and redeploy it with docker compose";

    user = mkOption {
      type = types.str;
      description = "User the watcher daemons run as. Needs docker group membership and any git credentials the watched checkouts rely on.";
    };

    interval = mkOption {
      type = types.int;
      default = 120;
      description = "Seconds between update checks. Keep well under 300 to get a sub-5-minute lead time.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ctl];

    systemd.services."git-deploy-watcher@" = {
      description = "Watch %I for upstream git updates and redeploy via docker compose";
      after = ["network-online.target"];
      wants = ["network-online.target"];
      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        # %I/%i specifier expansion strips the leading "/" from a path-escaped
        # instance name and does not restore it, so it must be added back here.
        WorkingDirectory = "/%I";
        Environment = [
          "HOME=/home/${cfg.user}"
          "WATCH_INTERVAL=${toString cfg.interval}"
        ];
        StateDirectory = "git-deploy-watcher/%i";
        ExecStart = "${daemon}/bin/git-deploy-watcher-daemon /%I";
        Restart = "on-failure";
        RestartSec = "30s";
      };
    };

    security.polkit.enable = true;
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.systemd1.manage-units" &&
            subject.user == "${cfg.user}" &&
            action.lookup("unit").indexOf("git-deploy-watcher@") == 0) {
          return polkit.Result.YES;
        }
      });
    '';
  };
}
