{
  programs.zellij.enable = true;

  xdg.configFile."zellij/config.kdl".text = ''
    keybinds clear-defaults=true {
      locked {
        bind "Ctrl g" { SwitchToMode "normal"; }
      }
      normal {
        bind "Ctrl n" { GoToNextTab; SwitchToMode "locked"; }
        bind "Ctrl p" { GoToPreviousTab; SwitchToMode "locked"; }
        bind "m" { SwitchToMode "move"; }
        bind "o" { SwitchToMode "session"; }
        bind "p" { SwitchToMode "pane"; }
        bind "r" { SwitchToMode "resize"; }
        bind "s" { SwitchToMode "scroll"; }
        bind "t" { SwitchToMode "tab"; }
      }
      pane {
        bind "c" { SwitchToMode "renamepane"; PaneNameInput 0; }
        bind "d" { NewPane "down"; SwitchToMode "locked"; }
        bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "locked"; }
        bind "f" { ToggleFocusFullscreen; SwitchToMode "locked"; }
        bind "h" { MoveFocus "left"; }
        bind "j" { MoveFocus "down"; }
        bind "k" { MoveFocus "up"; }
        bind "l" { MoveFocus "right"; }
        bind "n" { NewPane; SwitchToMode "locked"; }
        bind "p" { SwitchToMode "normal"; }
        bind "r" { NewPane "right"; SwitchToMode "locked"; }
        bind "w" { ToggleFloatingPanes; SwitchToMode "locked"; }
        bind "x" { CloseFocus; SwitchToMode "locked"; }
        bind "z" { TogglePaneFrames; SwitchToMode "locked"; }
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
        bind "l" { GoToNextTab; }
        bind "n" { NewTab; SwitchToMode "locked"; }
        bind "r" { SwitchToMode "renametab"; TabNameInput 0; }
        bind "s" { ToggleActiveSyncTab; SwitchToMode "locked"; }
        bind "t" { SwitchToMode "normal"; }
        bind "x" { CloseTab; SwitchToMode "locked"; }
        bind "tab" { ToggleTab; }
      }
      resize {
        bind "-" { Resize "Decrease"; }
        bind "=" { Resize "Increase"; }
        bind "H" { Resize "Decrease left"; }
        bind "J" { Resize "Decrease down"; }
        bind "K" { Resize "Decrease up"; }
        bind "L" { Resize "Decrease right"; }
        bind "h" { Resize "Increase left"; }
        bind "j" { Resize "Increase down"; }
        bind "k" { Resize "Increase up"; }
        bind "l" { Resize "Increase right"; }
        bind "r" { SwitchToMode "normal"; }
      }
      move {
        bind "h" { MovePane "left"; }
        bind "j" { MovePane "down"; }
        bind "k" { MovePane "up"; }
        bind "l" { MovePane "right"; }
        bind "m" { SwitchToMode "normal"; }
        bind "n" { MovePane; }
        bind "p" { MovePaneBackwards; }
        bind "tab" { MovePane; }
      }
      scroll {
        bind "e" { EditScrollback; SwitchToMode "locked"; }
        bind "f" { SwitchToMode "entersearch"; SearchInput 0; }
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
      shared_among "normal" "locked" {
        bind "Alt [" { PreviousSwapLayout; }
        bind "Alt ]" { NextSwapLayout; }
        bind "Alt i" { MoveTab "left"; }
        bind "Alt j" { MoveFocus "down"; }
        bind "Alt k" { MoveFocus "up"; }
        bind "Alt l" { MoveFocusOrTab "right"; }
        bind "Alt n" { NewPane; }
        bind "Alt o" { MoveTab "right"; }
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
        bind "d" { HalfPageScrollDown; }
        bind "Ctrl f" { PageScrollDown; }
        bind "h" { PageScrollUp; }
        bind "j" { ScrollDown; }
        bind "k" { ScrollUp; }
        bind "l" { PageScrollDown; }
        bind "u" { HalfPageScrollUp; }
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

    default_mode "locked"
    default_shell "/etc/profiles/per-user/s3igo/bin/fish"
    pane_frames false
  '';
}
