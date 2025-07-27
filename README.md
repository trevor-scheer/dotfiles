# Dotfiles Repository

This repository contains my personal dotfiles and configuration scripts for setting up my development environment across different platforms, including macOS, Linux, and GitHub Codespaces.

## Structure

- **install.sh**: The main bootstrapping script that sets up the dotfiles. It automatically detects your operating system and environment, and applies the appropriate configurations. It is designed to be idempotent, ensuring that running it multiple times does not cause issues.
- **scripts/**: Contains various setup scripts:
  - **setup-common.sh**: Cross-platform setup script that installs Homebrew and essential packages common to all environments.
  - **setup-macos.sh**: Contains setup instructions specific to macOS.
  - **setup-linux.sh**: Contains setup instructions specific to Linux.
  - **setup-codespaces.sh**: Contains setup instructions specific to GitHub Codespaces.
- **config/**: Contains configuration files for various tools:
  - **git/**: Git configuration settings.
  - **shell/**: Shell configuration files for Bash and Zsh.
  - **vscode/**: Settings for Visual Studio Code.
- **bin/**: Contains any executable scripts or binaries related to the dotfiles setup.
- **.gitignore**: Specifies files and directories to be ignored by Git.

## Usage

To set up your environment, run the following command:

```bash
./install.sh
```

This will execute the main installation script, which will automatically detect your operating system and environment, and apply the appropriate configurations.

## Notes

- Ensure that you have the necessary permissions to execute the scripts.
- Review the individual setup scripts for any additional dependencies or configurations that may be required.

Feel free to customize the dotfiles and scripts to suit your personal preferences and workflow!
