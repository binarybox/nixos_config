{ pkgs, ... }:

{
  systemd = {
    timers.simple-timer = {
      wantedBy = [ "timers.target" ];
      partOf = [ "simple-timer.service" ];
      timerConfig.OnCalendar = "minutely";
    };
    services.simple-timer = {
      serviceConfig.Type = "oneshot";
      script = ''
        echo "Time: $(date)." >> /tmp/simple-timer.log
      '';
    };
  };
}