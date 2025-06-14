{ pkgs, osConfig, ... }:
{
  home.sessionVariables.MULTIPLEXER = "zellij";
  persistDirs = [ "/.cache/zellij" ];
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
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
                      format_left   "{mode} ${osConfig.system.hostname}"
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

                      mode_default_to_mode "normal"
                      mode_normal  "#[bg=#89B4FA] {name} "
                      mode_locked  "#[bg=#f55e18] {name} "
                      mode_session "#[bg=#00ff00] {name} "

                      tab_normal   "#[fg=#6C7086] {index} "
                      tab_active   "#[fg=#9399B2,bold,italic] {index} "
                      tab_display_count         "3"  // limit to showing 3 tabs
                      tab_truncate_start_format "..."
                      tab_truncate_end_format   "..."

                      datetime        "#[fg=#6C7086,bold] {format}"
                      datetime_format "%H:%M:%S"
                      datetime_timezone "Asia/Singapore"
                  }
              }
              children
          }
      }
    '';
}
