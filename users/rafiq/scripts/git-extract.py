# flake8: noqa: E501
import subprocess
import os
import tempfile
import shutil
import argparse
import magic
import chardet
import math


def is_ascii(file_path):
    """
    Checks if a file contains only ASCII characters.

    Args:
        file_path (str): The path to the file.

    Returns:
        bool: True if the file contains only ASCII characters, False otherwise.
        None: If the file does not exist.
    """
    if not os.path.exists(file_path):
        return None  # Indicate file not found.

    try:
        with open(file_path, "r", encoding="ascii") as f:
            f.read()  # Attempt to read the entire file as ASCII
        return True
    except UnicodeDecodeError:
        return False


def has_high_entropy(file_path, threshold=0.7):
    """
    Checks if a file has high entropy, which might indicate it's not text.

    Args:
        file_path (str): The path to the file.
        threshold (float): Entropy threshold above which it's considered high entropy.

    Returns:
        bool: True if entropy is above the threshold, False otherwise.
        None: If the file does not exist.
    """
    if not os.path.exists(file_path):
        return None

    try:
        with open(file_path, "rb") as f:  # Important: Read as binary
            data = f.read()
    except IOError:
        return True  # Treat as non-text if there is an I/O error

    if not data:
        return False  # empty files considered text

    entropy = calculate_entropy(data)
    return entropy > threshold


def calculate_entropy(data):
    """
    Calculates the entropy of a byte string.

    Args:
        data (bytes): The byte string.

    Returns:
        float: The entropy.
    """
    if not data:
        return 0.0  # Avoid log(0)

    entropy = 0
    data_length = len(data)
    seen_bytes = bytearray(range(256))  # All possible byte values
    counts = [0] * 256

    for byte in data:
        counts[byte] += 1

    for byte in seen_bytes:
        probability = float(counts[byte]) / data_length
        if probability > 0:
            entropy -= probability * math.log(probability, 2)

    return entropy


def check_chardet_encoding(file_path, confidence_threshold=0.8):
    """
    Checks the file encoding using chardet library.

    Args:
        file_path (str): The path to the file.
        confidence_threshold (float): The minimum confidence level for encoding detection.

    Returns:
        bool: True if the encoding is detected with high confidence and is a text encoding, False otherwise.
        None: If the file does not exist.
    """
    if not os.path.exists(file_path):
        return None

    try:
        with open(file_path, "rb") as f:  # Important: Read as binary
            data = f.read()
    except IOError:
        return False  # If file can't be opened, assume it's not a simple text file.

    if not data:
        return True  # Empty files are usually considered text

    result = chardet.detect(data)
    encoding = result["encoding"]
    confidence = result["confidence"]

    if encoding and confidence > confidence_threshold:
        # Check if it's a recognized text encoding (not binary or None)
        if encoding != "binary" and encoding is not None:
            return True
    return False


def is_text_file(file_path, aggressive=False):
    """
    Wrapper function to check if a file is a text file using multiple methods.

    Args:
        file_path (str): The path to the file.
        aggressive (bool, optional): If True, combines all checks for stricter verification.
                         If False, returns True if any check passes. Defaults to False.

    Returns:
        bool: True if the file is a text file, False otherwise.
        None: If the file does not exist.
    """

    if not os.path.exists(file_path):
        return None

    # Basic checks
    ascii_check = is_ascii(file_path)
    if ascii_check is None:
        return None  # File not found

    if aggressive:
        # Run all checks and require them all to pass
        high_entropy_check = not has_high_entropy(
            file_path
        )  # Invert because we want to know if it DOESN'T have high entropy
        chardet_check = check_chardet_encoding(file_path)

        return ascii_check and high_entropy_check and chardet_check
    else:
        # Run checks and return True if any of them pass
        high_entropy_check = not has_high_entropy(file_path)
        chardet_check = check_chardet_encoding(file_path)
        return ascii_check or high_entropy_check or chardet_chec


def get_latest_text_files_to_stdout(remote_repo_url, ignored_files=None):
    """
    Checks out the latest commit from a remote Git repository to a temporary folder,
    and then prints the contents of all files identified as text files to stdout,
    prepended by their relative paths from the repository root, excluding specified
    ignored files.

    Args:
        remote_repo_url: The URL of the remote Git repository.
        ignored_files: A list of files or directories to ignore (relative to the repo root).
    """

    temp_dir = None
    if ignored_files is None:
        ignored_files = []

    # Ensure .git and .gitignore are always ignored
    ignored_files.extend([".git", ".gitignore"])
    ignored_files = list(set(ignored_files))  # remove duplicates

    try:
        # Create a temporary directory
        temp_dir = tempfile.mkdtemp()

        # Clone the repository, but only the latest commit (shallow clone)
        subprocess.run(
            ["git", "clone", "--depth", "1", remote_repo_url, temp_dir],
            check=True,
            capture_output=True,
            text=True,
        )

        # Find all files and filter for text files
        text_files = []
        for root, _, files in os.walk(temp_dir):
            for file in files:
                file_path = os.path.join(root, file)
                relative_path = os.path.relpath(file_path, temp_dir)

                # Check if the file or any of its parent directories are ignored
                ignore = False
                path_components = relative_path.split(
                    os.sep
                )  # split based on OS-specific path separator
                current_path = ""
                for component in path_components:
                    current_path = (
                        os.path.join(current_path, component)
                        if current_path
                        else component
                    )  # prevent empty first join
                    if current_path in ignored_files:
                        ignore = True
                        break

                if not ignore:
                    if is_text_file(file_path):  # Use the is_text_file function
                        text_files.append(file_path)

        # Print the contents of each text file, prepended by its relative path
        for file_path in text_files:
            relative_path = os.path.relpath(file_path, temp_dir)
            print(f"--- {relative_path} ---")
            try:
                with open(file_path, "r", encoding="utf-8") as f:  # Use UTF-8 encoding
                    print(f.read())
            except UnicodeDecodeError:
                print(
                    f"Error: Could not decode file {relative_path} using UTF-8.  Skipping file contents."
                )  # handle binary or other non-UTF-8 encodings
            print()  # Add a blank line between files

    except subprocess.CalledProcessError as e:
        print(f"Error executing Git command: {e.stderr}")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        # Clean up the temporary directory
        if temp_dir:
            shutil.rmtree(temp_dir)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Checkout and print text files from a remote Git repository."
    )
    parser.add_argument(
        "-r", "--repo", required=True, help="The URL of the remote Git repository."
    )
    parser.add_argument(
        "-i",
        "--ignored-files",
        nargs="+",
        default=[],
        help="Files or directories to ignore (space-separated).",
    )

    args = parser.parse_args()

    remote_repository_url = args.repo
    ignored_files = args.ignored_files

    # Verify the URL
    if (
        "github.com" not in remote_repository_url
        and "gitlab.com" not in remote_repository_url
        and "bitbucket.org" not in remote_repository_url
    ):
        print(
            "Warning: This script is designed for common public repository hosting providers. Ensure the Git URL is correct."
        )

    get_latest_text_files_to_stdout(remote_repository_url, ignored_files)

