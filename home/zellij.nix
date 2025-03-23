{
  programs.zellij = {
    enable = true;
    # https://github.com/nix-community/home-manager/commit/5af1b9a0f193ab6138b89a8e0af8763c21bbf491
    # https://github.com/nix-community/home-manager/pull/6037
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
  };

  xdg.configFile = {
    "zellij/config.kdl".text = ''
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

          bind "Ctrl o" { GoToNextTab; SwitchToMode "locked"; }
          // "Ctrl i" is the same as Tab
          bind "Ctrl i" { GoToPreviousTab; SwitchToMode "locked"; } // for Ghostty
          bind "Tab" { GoToPreviousTab; SwitchToMode "locked"; } // for Wezterm

          // Write "Ctrl g" (ASCII 7)
          // Ref: https://en.wiktionary.org/wiki/Appendix:Control_characters
          bind "g" { Write 7; SwitchToMode "locked"; }

          bind "Ctrl p" { SwitchToMode "pane"; }
          bind "Ctrl s" { SwitchToMode "scroll"; }
          bind "Ctrl t" { SwitchToMode "tab"; }
          bind "p" { SwitchToMode "pane"; }
          bind "s" { SwitchToMode "scroll"; }
          bind "t" { SwitchToMode "tab"; }

          bind "Ctrl e" { TogglePaneEmbedOrFloating; SwitchToMode "locked"; }
          bind "Ctrl f" { ToggleFocusFullscreen; SwitchToMode "locked"; }
          bind "Ctrl w" { ToggleFloatingPanes; SwitchToMode "locked"; }
          bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "locked"; }
          bind "f" { ToggleFocusFullscreen; SwitchToMode "locked"; }
          bind "w" { ToggleFloatingPanes; SwitchToMode "locked"; }

          bind "d" { Detach; }

          bind "P" {
            LaunchOrFocusPlugin "zellij:plugin-manager" {
              floating true
              move_to_focused_tab true
            }
            SwitchToMode "locked"
          }
          bind "S" {
            LaunchOrFocusPlugin "zellij:session-manager" {
              floating true
              move_to_focused_tab true
            }
            SwitchToMode "locked"
          }
        }

        pane {
          bind "-" { Resize "Decrease"; }
          bind "=" { Resize "Increase"; }
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
          bind "r" { SwitchToMode "renamepane"; PaneNameInput 0; }
          bind "S" { NewPane "up"; SwitchToMode "locked"; }
          bind "s" { NewPane "down"; SwitchToMode "locked"; }
          bind "V" { NewPane "left"; SwitchToMode "locked"; }
          bind "v" { NewPane "right"; SwitchToMode "locked"; }
          bind "p" { SwitchToMode "normal"; }
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

        shared_except "locked" "renametab" "renamepane" {
          bind "Ctrl g" { SwitchToMode "locked"; }
          bind "Ctrl q" { Quit; }
        }

        shared_except "locked" "entersearch" {
          bind "enter" { SwitchToMode "locked"; }
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

      theme "iceberg-dark"
      // theme "night-owl"
      default_mode "locked"
      default_shell "/etc/profiles/per-user/s3igo/bin/fish"
      default_layout "simple"
      pane_frames false
      pane_viewport_serialization true
    '';

    "zellij/layouts/simple.kdl".text = ''
      layout {
        pane size=1 borderless=true {
          plugin location="zellij:compact-bar"
        }
        pane
      }
    '';

    "zellij/layouts/simple.swap.kdl".text = ''
      tab_template name="ui" {
        pane size=1 borderless=true {
          plugin location="zellij:compact-bar"
        }
        children
      }

      swap_tiled_layout name="vertical" {
        ui max_panes=4 {
          pane split_direction="vertical" {
            pane
            pane { children; }
          }
        }
        ui max_panes=7 {
          pane split_direction="vertical" {
            pane { children; }
            pane { pane; pane; pane; pane; }
          }
        }
        ui max_panes=11 {
          pane split_direction="vertical" {
            pane { children; }
            pane { pane; pane; pane; pane; }
            pane { pane; pane; pane; pane; }
          }
        }
      }

      swap_tiled_layout name="horizontal" {
        ui max_panes=3 {
          pane
          pane
        }
        ui max_panes=7 {
          pane {
            pane split_direction="vertical" { children; }
            pane split_direction="vertical" { pane; pane; pane; pane; }
          }
        }
        ui max_panes=11 {
          pane {
            pane split_direction="vertical" { children; }
            pane split_direction="vertical" { pane; pane; pane; pane; }
            pane split_direction="vertical" { pane; pane; pane; pane; }
          }
        }
      }

      swap_tiled_layout name="stacked" {
        ui min_panes=4 {
          pane split_direction="vertical" {
            pane
            pane stacked=true { children; }
          }
        }
      }

      swap_floating_layout name="staggered" {
        floating_panes
      }

      swap_floating_layout name="enlarged" {
        floating_panes max_panes=10 {
          pane { x "5%"; y 1; width "90%"; height "90%"; }
          pane { x "5%"; y 2; width "90%"; height "90%"; }
          pane { x "5%"; y 3; width "90%"; height "90%"; }
          pane { x "5%"; y 4; width "90%"; height "90%"; }
          pane { x "5%"; y 5; width "90%"; height "90%"; }
          pane { x "5%"; y 6; width "90%"; height "90%"; }
          pane { x "5%"; y 7; width "90%"; height "90%"; }
          pane { x "5%"; y 8; width "90%"; height "90%"; }
          pane { x "5%"; y 9; width "90%"; height "90%"; }
          pane focus=true { x 10; y 10; width "90%"; height "90%"; }
        }
      }

      swap_floating_layout name="spread" {
        floating_panes max_panes=1 {
          pane { y "50%"; x "50%"; }
        }
        floating_panes max_panes=2 {
          pane { x "1%"; y "25%"; width "45%"; }
          pane { x "50%"; y "25%"; width "45%"; }
        }
        floating_panes max_panes=3 {
          pane focus=true { y "55%"; width "45%"; height "45%"; }
          pane { x "1%"; y "1%"; width "45%"; }
          pane { x "50%"; y "1%"; width "45%"; }
        }
        floating_panes max_panes=4 {
          pane { x "1%"; y "55%"; width "45%"; height "45%"; }
          pane focus=true { x "50%"; y "55%"; width "45%"; height "45%"; }
          pane { x "1%"; y "1%"; width "45%"; height "45%"; }
          pane { x "50%"; y "1%"; width "45%"; height "45%"; }
        }
      }
    '';
  };
}
