# Set up the terminal to read input immediately, without waiting for Enter.
# This is done using the `stty` command.
# `stty` controls terminal settings.
# `-icanon` disables canonical mode.  In canonical mode, the terminal buffers input until a newline is received.  Disabling it makes input available immediately.
# `min 1` specifies that at least 1 character should be read.
# `time 0` specifies that the read should return immediately if a character is available.
stty -icanon min 1 time 0

# Prompt the user to enter 'y' or 'n' to confirm or cancel the poweroff.
# `echo -n` prints the prompt without a trailing newline, so the input will appear on the same line.
echo -n "Poweroff system? (y/n) [n]: "

# Read a single character from the input and store it in the 'answer' variable.
# `read -n 1 answer` reads only 1 character.
read -n 1 answer

# Print a newline character after the input has been read.
# This makes the output more readable, as the subsequent messages will appear on a new line.
echo

# Restore the terminal settings to their default values.
# This is important, as leaving the terminal in non-canonical mode can cause unexpected behavior.
# `stty icanon` re-enables canonical mode.
stty icanon

# Check the value of the 'answer' variable.
# `[[ ... ]]` is a more robust and feature-rich way to perform conditional tests than `[ ... ]`.
# `"y"` matches only the lowercase "y".  If you want case-insensitive matching, consider using `[[ ${answer,,} == "y" ]]` (converts answer to lowercase).
if [[ "$answer" == "y" ]]; then
  # If the user entered 'y', proceed with the poweroff.
  echo "Powering off..."

  # Execute the systemctl poweroff command with root privileges using sudo.
  # `sudo` allows you to run commands as the superuser (root).
  # `systemctl poweroff` sends the command to the systemd init system to shut down the machine.
  sudo systemctl poweroff
else
  # If the user entered anything other than 'y', cancel the poweroff.
  echo "Poweroff cancelled."
fi
