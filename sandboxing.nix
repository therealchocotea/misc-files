{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      mpv = {
        executable = "${pkgs.mpv}/bin/mpv";
        profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
      };
      ffmpeg = {
        executable = "${pkgs.ffmpeg}/bin/ffmpeg";
        profile = "${pkgs.firejail}/etc/firejail/ffmpeg.profile";
      };
      firefox = {
        executable = "${pkgs.firefox}/bin/firefox";
        profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
      };
      discord = {
        executable = "${pkgs.discord}/bin/discord";
        profile = "${pkgs.firejail}/etc/firejail/discord.profile";
      };
      tor-browser = {
        executable = "${pkgs.tor-browser}/bin/tor-browser";
        profile = "${pkgs.firejail}/etc/firejail/tor-browser.profile";
      };
      nicotine-plus = {
        executable = "${pkgs.nicotine-plus}/bin/nicotine-plus";
        extraArgs = [
          "--whitelist=${builtins.getEnv "HOME"}/Music"
          "--whitelist=${builtins.getEnv "HOME"}/.config/"
          "--caps.drop=all"
          "--seccomp"
          "--dbus-user.talk=org.freedesktop.Notifications"
        ];
      };
      whatsie = {
        executable = lib.getExe pkgs.whatsie;
        extraArgs = [
          "--whitelist=${builtins.getEnv "HOME"}/.config/WhatSie"
          "--whitelist=${builtins.getEnv "HOME"}/.cache/WhatSie"
          "--whitelist=${builtins.getEnv "HOME"}/Downloads/"
          "--caps.drop=all"
          "--seccomp"
          "--dbus-user.talk=org.freedesktop.Notifications"
          "--dbus-user.talk=org.kde.StatusNotifierWatcher"
        ];
      };
    };
  };
}
