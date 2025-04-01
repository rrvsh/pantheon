# Set default values
flake=".#default"              # Default flake attribute if none is provided
target_host="nixos@<hostname>" # Default target host

# Process command-line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
  --flake)
    flake="$2"
    shift # past argument
    shift # past value
    ;;
  --target-host)
    target_host="$2"
    shift # past argument
    shift # past value
    ;;
  *)
    echo "Unknown option: $1" >&2
    exit 1
    ;;
  esac
done

# Prepare temporary directory and copy necessary files
root=$(mktemp -d)
# Files should be copied to the persist directory
# because that's where impermanence looks for them in.
mkdir -p "${root}"/persist
root_persist=${root}/persist
sudo cp --verbose --archive --parents /etc/ssh/ssh_host_* "${root_persist}"
sudo cp --verbose --archive --parents /home/rafiq/.ssh/id_ed25519 "${root_persist}"
sudo cp --verbose --archive --parents /home/rafiq/.config/sops/age/keys.txt "${root_persist}"

# Run nixos-anywhere
# Copy over the necesary files to the persist directory.
sudo nix run github:nix-community/nixos-anywhere -- \
  --flake "${flake}" \
  --target-host "${target_host}" \
  --copy-host-keys \
  --extra-files "${root}" \
  --chown /persist/home/rafiq 1000:100 \
  --chown /home/rafiq 1000:100

# Clean up the temporary directory
sudo rm -rf "$root"

# Wait for SSH to be back up
MAX_TRIES=60    # Maximum attempts
SLEEP_SECONDS=5 # Time to wait between attempts
tries=0

while true; do
  tries=$((tries + 1))

  # Check network reachability with ping
  ping -c 1 "$(echo "${target_host}" | awk -F'@' '{print $NF}')" >/dev/null 2>&1 #Extract IP/hostname from username@host
  if [ $? -eq 0 ]; then
    # Network is reachable, try SSH
    ssh -q -o "ConnectTimeout=5" "${target_host}" 'exit 0'

    if [ $? -eq 0 ]; then
      echo "SSH is up. Connecting..."
      ssh "${target_host}" &&
        nixos-rebuild switch --flake "${flake}" --use-remote-sudo --target-host "${target_host}"
      exit 0
    else
      echo "SSH not yet available (attempt $tries/$MAX_TRIES).  Waiting..."
    fi
  else
    echo "Host is not reachable via ping (attempt $tries/$MAX_TRIES). Waiting..."
  fi

  if [ $tries -ge $MAX_TRIES ]; then
    echo "Maximum attempts reached. SSH still not available."
    exit 1
  fi
  sleep "$SLEEP_SECONDS"
done

echo "---DEPLOYMENT DONE!---"
