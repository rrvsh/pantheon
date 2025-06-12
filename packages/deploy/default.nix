{ pkgs, ... }:
pkgs.writeShellScriptBin "deploy" # sh
  ''
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --user)
          USER="$2"
          shift 2
          ;;
        --ip)
          IP="$2"
          shift 2
          ;;
        --hostname)
          HOSTNAME="$2"
          shift 2
          ;;
        *)
          echo "Error: Unknown parameter: $1"
          exit 1
          ;;
      esac
    done

    # Check if required arguments are provided
    if [[ -z "$USER" || -z "$IP" || -z "$HOSTNAME" ]]; then
      echo "Usage: $0 --user <user> --ip <ip_address> --hostname <hostname> [--wait-timeout <seconds>]"
      exit 1
    fi

    # --- Helper Functions ---

    wait_for_ping() {
      local ip="$1"

      echo "Waiting for ping to $ip..."
      while true; do
        if ping -c 1 -W 1 "$ip"; then
          echo "Ping successful."
          return 0
        fi
        sleep 2
      done
    }

    wait_for_ssh() {
      local ip="$1"

      echo "Waiting for SSH to $ip..."
      while true; do
        ssh-keygen -R "$ip" || true  # Suppress error if key doesn't exist
        if ssh -o StrictHostKeyChecking=no root@"$ip" exit; then
          echo "SSH connection successful."
          return 0
        fi
        sleep 2
      done
    }

    retry_rebuild() {
      local ip="$1"

      echo "Attempting rebuild..."
      while true; do
        if nixos-rebuild switch --flake . --target-host root@"$ip"; then
          echo "Rebuild successful."
          return 0
        fi
        sleep 2
      done
    }

    test_connection() {
      local ip="$1"
      # Wait for the server to come back up after the reboot. Ping first.
      if ! wait_for_ping $ip; then
        echo "Error: Server did not respond to ping after reboot."
        exit 1
      fi

      # Wait for SSH access after reboot
      if ! wait_for_ssh $ip; then
        echo "Error: SSH access not available after reboot."
        exit 1
      fi
    }

    # --- Deployment Steps ---

    test_connection "$IP"

    # Copy SSH key to remote server
    ssh-copy-id -o StrictHostKeyChecking=no root@"$IP" || { echo "Error: Failed to copy SSH key."; exit 1; }

    # Deploy NixOS configuration using nixos-anywhere
    nix run github:nix-community/nixos-anywhere -- \
    -i ~/.ssh/id_ed25519 --ssh-option StrictHostKeyChecking=no \
    --flake .#"$HOSTNAME" --target-host root@"$IP" || { echo "Error: nixos-anywhere failed."; exit 1; }

    test_connection "$IP"

    # Create SSH directory on the remote server (if not already present)
    ssh root@"$IP" -o StrictHostKeyChecking=no mkdir -p "/persist/home/$USER/.ssh" || { echo "Error: Failed to create SSH directory."; exit 1; }

    # Set owner of the user's home directory
    ssh root@"$IP" -o StrictHostKeyChecking=no chown -R "$USER:users" "/persist/home/$USER" || { echo "Error: Failed to set ownership."; exit 1; }

    # Copy SSH keys to the remote server
    scp -r ~/.ssh root@"$IP":/persist/home/"$USER" || { echo "Error: Failed to copy SSH keys."; exit 1; }

    #TODO: remove device from tailscale

    # Build and switch the configuration
    retry_rebuild "$IP"

    # Reboot the system
    ssh root@"$IP" -o StrictHostKeyChecking=no systemctl reboot || { echo "Error: Failed to reboot."; exit 1; }

    test_connection "$IP"
    test_connection "$HOSTNAME"

    echo "Deployment complete.  System should be ready."
  ''
