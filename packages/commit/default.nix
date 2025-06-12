{ pkgs, ... }:
pkgs.writeShellScriptBin "commit" # bash
  ''
    PROMPT="Please generate a one-line commit message using conventional commit syntax, following the context."
    GUIDELINES="1. Use conventional commit syntax, following the context. "
    NUM_ANCESTORS=0

    # Parse arguments
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

    # Get context and diff
    CONTEXT=$(git --no-pager log -n 10)
    DIFF=$(git --no-pager diff HEAD~$NUM_ANCESTORS)

    # Generate initial response
    RESPONSE=$(aichat "$PROMPT\nGuidelines: $GUIDELINES\nContext from git log:\n$CONTEXT\nDiff from git diff HEAD:\n$DIFF")

    while true; do
      echo "Generated Commit Message:"
      echo "$RESPONSE"
      echo "Options: [y]es, [r]eroll, [e]dit, [q]uit?"
      read -r -p "Choose an action: " choice

      case "$choice" in
        y | yes)
          git commit -am "$RESPONSE"
          echo "Committed successfully."
          exit 0
          ;;
        r | reroll)
          RESPONSE=$(aichat "$PROMPT\nGuidelines: $GUIDELINES\nContext from git log:\n$CONTEXT\nDiff from git diff HEAD:\n$DIFF")
          ;;
        e | edit)
          echo "$RESPONSE" > /tmp/commit_msg.txt
          "$EDITOR" /tmp/commit_msg.txt
          RESPONSE=$(cat /tmp/commit_msg.txt)
          rm /tmp/commit_msg.txt
          ;;
        q | quit | "")
          echo "Aborted."
          exit 1
          ;;
        *)
          echo "Invalid choice. Please choose again."
          ;;
      esac
    done
  ''
