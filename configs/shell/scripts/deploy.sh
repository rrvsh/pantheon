# Set default values
flake=".#default" # Default flake attribute if none is provided
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
mkdir -p ${root}/persist
root=${root}/persist
sudo cp --verbose --archive --parents /etc/ssh/ssh_host_* ${root}
sudo cp --verbose --archive --parents ~/.ssh/id_ed25519 ${root}
sudo cp --verbose --archive --parents ~/.config/sops/age/keys.txt ${root}

# Run nixos-anywhere
sudo nix run github:nix-community/nixos-anywhere -- \
  --flake "${flake}" \
  --target-host "${target_host}" \
  --copy-host-keys \
  --extra-files "${root}" \
  --chown /home/rafiq/.config 1000:100 \
  --chown /home/rafiq/.ssh 1000:100

# Clean up the temporary directory
sudo rm -rf "$root"
