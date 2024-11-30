{
  programs.zellij.enable = true;

  xdg.configFile."zellij/config.kdl".text = ''
    keybinds clear-defaults=true {
      locked {
        bind "Ctrl g" { SwitchToMode "normal"; }
      }
      normal {
        bind "[" { PreviousSwapLayout; SwitchToMode "locked"; }
        bind "]" { NextSwapLayout; SwitchToMode "locked"; }
        bind "Ctrl h" { MoveFocus "left"; SwitchToMode "locked"; }
        bind "Ctrl j" { MoveFocus "down"; SwitchToMode "locked"; }
        bind "Ctrl k" { MoveFocus "up"; SwitchToMode "locked"; }
        bind "Ctrl l" { MoveFocus "right"; SwitchToMode "locked"; }
        bind "Ctrl n" { GoToNextTab; SwitchToMode "locked"; }
        bind "Ctrl p" { GoToPreviousTab; SwitchToMode "locked"; }
        // Write "Ctrl g" (ASCII 7)
        // Ref: https://en.wiktionary.org/wiki/Appendix:Control_characters
        bind "g" { Write 7; SwitchToMode "locked"; }
        bind "o" { SwitchToMode "session"; }
        bind "p" { SwitchToMode "pane"; }
        bind "s" { SwitchToMode "scroll"; }
        bind "t" { SwitchToMode "tab"; }
      }
      pane {
        bind "-" { Resize "Decrease"; }
        bind "=" { Resize "Increase"; }
        bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "locked"; }
        bind "f" { ToggleFocusFullscreen; SwitchToMode "locked"; }
        bind "Ctrl h" { MovePane "left"; }
        bind "Ctrl j" { MovePane "down"; }
        bind "Ctrl k" { MovePane "up"; }
        bind "Ctrl l" { MovePane "right"; }
        bind "H" { Resize "Increase left"; }
        bind "J" { Resize "Increase down"; }
        bind "K" { Resize "Increase up"; }
        bind "L" { Resize "Increase right"; }
        bind "h" { MoveFocus "left"; }
        bind "j" { MoveFocus "down"; }
        bind "k" { MoveFocus "up"; }
        bind "l" { MoveFocus "right"; }
        bind "Ctrl n" { MovePane; }
        bind "Ctrl p" { MovePaneBackwards; }
        bind "n" { NewPane; SwitchToMode "locked"; }
        bind "p" { SwitchToMode "normal"; }
        bind "r" { SwitchToMode "renamepane"; PaneNameInput 0; }
        bind "S" { NewPane "up"; SwitchToMode "locked"; }
        bind "s" { NewPane "down"; SwitchToMode "locked"; }
        bind "V" { NewPane "left"; SwitchToMode "locked"; }
        bind "v" { NewPane "right"; SwitchToMode "locked"; }
        bind "w" { ToggleFloatingPanes; SwitchToMode "locked"; }
        bind "x" { CloseFocus; SwitchToMode "locked"; }
        bind "tab" { SwitchFocus; }
      }
      tab {
        bind "1" { GoToTab 1; SwitchToMode "locked"; }
        bind "2" { GoToTab 2; SwitchToMode "locked"; }
        bind "3" { GoToTab 3; SwitchToMode "locked"; }
        bind "4" { GoToTab 4; SwitchToMode "locked"; }
        bind "5" { GoToTab 5; SwitchToMode "locked"; }
        bind "6" { GoToTab 6; SwitchToMode "locked"; }
        bind "7" { GoToTab 7; SwitchToMode "locked"; }
        bind "8" { GoToTab 8; SwitchToMode "locked"; }
        bind "9" { GoToTab 9; SwitchToMode "locked"; }
        bind "[" { BreakPaneLeft; SwitchToMode "locked"; }
        bind "]" { BreakPaneRight; SwitchToMode "locked"; }
        bind "b" { BreakPane; SwitchToMode "locked"; }
        bind "h" { GoToPreviousTab; }
        bind "j" { MoveTab "right"; }
        bind "k" { MoveTab "left"; }
        bind "l" { GoToNextTab; }
        bind "n" { NewTab; SwitchToMode "locked"; }
        bind "r" { SwitchToMode "renametab"; TabNameInput 0; }
        bind "s" { ToggleActiveSyncTab; SwitchToMode "locked"; }
        bind "t" { SwitchToMode "normal"; }
        bind "x" { CloseTab; SwitchToMode "locked"; }
        bind "tab" { ToggleTab; }
      }
      scroll {
        bind "/" { SwitchToMode "entersearch"; SearchInput 0; }
        bind "e" { EditScrollback; SwitchToMode "locked"; }
        bind "s" { SwitchToMode "normal"; }
      }
      search {
        bind "c" { SearchToggleOption "CaseSensitivity"; }
        bind "n" { Search "down"; }
        bind "o" { SearchToggleOption "WholeWord"; }
        bind "p" { Search "up"; }
        bind "w" { SearchToggleOption "Wrap"; }
      }
      session {
        bind "d" { Detach; }
        bind "o" { SwitchToMode "normal"; }
        bind "p" {
          LaunchOrFocusPlugin "plugin-manager" {
            floating true
            move_to_focused_tab true
          }
          SwitchToMode "locked"
        }
        bind "w" {
          LaunchOrFocusPlugin "session-manager" {
            floating true
            move_to_focused_tab true
          }
          SwitchToMode "locked"
        }
      }
      shared_except "locked" "renametab" "renamepane" {
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl q" { Quit; }
      }
      shared_except "locked" "entersearch" "renametab" "renamepane" {
        bind "esc" { SwitchToMode "locked"; }
      }
      shared_among "scroll" "search" {
        bind "Ctrl b" { PageScrollUp; }
        bind "Ctrl c" { ScrollToBottom; SwitchToMode "locked"; }
        bind "Ctrl d" { HalfPageScrollDown; }
        bind "Ctrl f" { PageScrollDown; }
        bind "j" { ScrollDown; }
        bind "k" { ScrollUp; }
        bind "Ctrl u" { HalfPageScrollUp; }
      }
      entersearch {
        bind "Ctrl c" { SwitchToMode "scroll"; }
        bind "esc" { SwitchToMode "scroll"; }
        bind "enter" { SwitchToMode "search"; }
      }
      renametab {
        bind "esc" { UndoRenameTab; SwitchToMode "tab"; }
      }
      shared_among "renametab" "renamepane" {
        bind "Ctrl c" { SwitchToMode "locked"; }
      }
      renamepane {
        bind "esc" { UndoRenamePane; SwitchToMode "pane"; }
      }
    }

    plugins {
      compact-bar location="zellij:compact-bar"
      filepicker location="zellij:strider" {
        cwd "/"
      }
      plugin-manager location="zellij:plugin-manager"
      session-manager location="zellij:session-manager"
      status-bar location="zellij:status-bar"
      strider location="zellij:strider"
      tab-bar location="zellij:tab-bar"
      welcome-screen location="zellij:session-manager" {
        welcome_screen true
      }
    }

    // theme "iceberg-dark"
    theme "night-owl"
    default_mode "locked"
    default_shell "/etc/profiles/per-user/s3igo/bin/fish"
    pane_frames false
  '';
}
