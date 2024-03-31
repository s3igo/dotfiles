{
  pkgs,
  grammars ? [ ],
  ...
}:

{
  plugins = {
    treesitter = {
      enable = true;
      grammarPackages =
        with pkgs.vimPlugins.nvim-treesitter;
        if grammars == "all" then
          allGrammars
        else
          map (name: builtGrammars.${name}) (
            [
              "vimdoc"
              "comment"
            ]
            ++ grammars
          );
      # folding = true;
      indent = true;
      incrementalSelection = {
        enable = true;
        keymaps = {
          initSelection = "<tab>";
          scopeIncremental = "<cr>";
          nodeIncremental = "<tab>";
          nodeDecremental = "<s-tab>";
        };
      };
    };
    treesitter-textobjects = {
      enable = true;
      select = {
        enable = true;
        lookahead = true;
        keymaps = {
          ak = {
            query = "@block.outer";
            desc = "Around block";
          };
          ik = {
            query = "@block.inner";
            desc = "Inside block";
          };
          ac = {
            query = "@class.outer";
            desc = "Around class";
          };
          ic = {
            query = "@class.inner";
            desc = "Inside class";
          };
          "a?" = {
            query = "@conditional.outer";
            desc = "Around conditional";
          };
          "i?" = {
            query = "@conditional.inner";
            desc = "Inside conditional";
          };
          af = {
            query = "@function.outer";
            desc = "Around function";
          };
          "if" = {
            query = "@function.inner";
            desc = "Inside function";
          };
          al = {
            query = "@loop.outer";
            desc = "Around loop";
          };
          il = {
            query = "@loop.inner";
            desc = "Inside loop";
          };
          aa = {
            query = "@parameter.outer";
            desc = "Around argument";
          };
          ia = {
            query = "@parameter.inner";
            desc = "Inside argument";
          };
        };
      };
      move = {
        enable = true;
        setJumps = true;
        gotoNextStart = {
          "]k" = {
            query = "@block.outer";
            desc = "Next block start";
          };
          "]f" = {
            query = "@function.outer";
            desc = "Next function start";
          };
          "]a" = {
            query = "@parameter.inner";
            desc = "Next argument start";
          };
        };
        gotoNextEnd = {
          "]K" = {
            query = "@block.outer";
            desc = "Next block end";
          };
          "]F" = {
            query = "@function.outer";
            desc = "Next function end";
          };
          "]A" = {
            query = "@parameter.inner";
            desc = "Next argument end";
          };
        };
        gotoPreviousStart = {
          "[k" = {
            query = "@block.outer";
            desc = "Previous block start";
          };
          "[f" = {
            query = "@function.outer";
            desc = "Previous function start";
          };
          "[a" = {
            query = "@parameter.inner";
            desc = "Previous argument start";
          };
        };
        gotoPreviousEnd = {
          "[K" = {
            query = "@block.outer";
            desc = "Previous block end";
          };
          "[F" = {
            query = "@function.outer";
            desc = "Previous function end";
          };
          "[A" = {
            query = "@parameter.inner";
            desc = "Previous argument end";
          };
        };
      };
    };
    treesitter-context.enable = true;
    rainbow-delimiters.enable = true;
  };

  highlight = {
    "@comment.todo.comment".link = "NightflyBlueMode";
    "@comment.note.comment".link = "NightflyPurpleMode";
    "@comment.warning.comment".link = "NightflyTanMode";
    "@comment.danger.comment".link = "NightflyWatermelonMode";
  };
}
