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
sudo mkdir -p ${root}/home/rafiq/.config/sops/age
sudo cp ~/.config/sops/age/keys.txt "${root}/home/rafiq/.config/sops/age/keys.txt"
sudo mkdir -p ${root}/home/rafiq/.ssh
sudo cp ~/.ssh/id_ed25519 "${root}/home/rafiq/.ssh/id_ed25519"
sudo cp ~/.ssh/id_ed25519.pub "${root}/home/rafiq/.ssh/id_ed25519.pub"

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
