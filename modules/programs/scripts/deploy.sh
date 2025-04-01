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
  --extra-files "${root}" \
  --chown /persist/home/rafiq 1000:100

# Clean up the temporary directory
sudo rm -rf "$root"
