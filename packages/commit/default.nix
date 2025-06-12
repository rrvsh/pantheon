{ pkgs, ... }:
pkgs.writeShellScriptBin "commit" # bash
  ''
    PROMPT="Please generate a one-line commit message using."
    GUIDELINES="1. Use conventional commit syntax, following the context."
    NUM_ANCESTORS=0
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --num-ancestors | -n)
          NUM_ANCESTORS="$2"
          shift 2
          ;;
        *)
          echo "Unrecognised argument: $1. Exiting..."
          exit 1
          ;;
      esac
    done
    CONTEXT=$(git --no-pager log -n 10)
    DIFF=$(git --no-pager diff HEAD~$NUM_ANCESTORS)
    RESPONSE=$(aichat "$PROMPT\nGuidelines: $GUIDELINES\nContext from git log: $CONTEXT\nDiff from git diff HEAD: $DIFF")
    #TODO: revise commit message
    git commit -am "$RESPONSE"
  ''
