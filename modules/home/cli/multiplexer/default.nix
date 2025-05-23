{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.cli.multiplexer == "zellij") {
    home.sessionVariables.MULTIPLEXER = "zellij";
    home.persistence."/persist/home/${config.snowfallorg.user.name}".directories = [ "/.cache/zellij" ];
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      attachExistingSession = true;
      exitShellOnExit = true;
      settings = {
        pane_frames = false;
        show_startup_tips = false;
        show_release_notes = false;
      };
    };
    xdg.configFile."zellij/layouts/default.kdl".text = # kdl
      ''
        layout {
            default_tab_template {
                pane size=1 borderless=true {
                    plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
                        format_left   "{mode} {command_pwd}"
                        format_center "{tabs}"
                        format_right  "{datetime}"
                        format_space  ""
                        format_hide_on_overlength "true"
                        format_precedence "lrc"

                        border_enabled  "false"
                        border_char     "─"
                        border_format   "#[fg=#6C7086]{char}"
                        border_position "top"

                        hide_frame_for_single_pane "false"

                        mode_normal        "#[bg=#89B4FA] {name} "

                        tab_normal   "#[fg=#6C7086] {index} "
                        tab_active   "#[fg=#9399B2,bold,italic] {index} "
                        tab_display_count         "3"  // limit to showing 3 tabs
                        tab_truncate_start_format "#[fg=red,bg=#181825] < +{count} ..."
                        tab_truncate_end_format   "#[fg=red,bg=#181825] ... +{count} >"

                        command_pwd_command "pwd"
                        command_pwd_format "{stdout}"

                        datetime        "#[fg=#6C7086,bold] {format} "
                        datetime_format "%A, %d %b %Y %H:%M"
                        datetime_timezone "Asia/Singapore"
                    }
                }
                children
            }
        }
      '';
  };
}
