# Bash Utilities

A collection of useful bash scripts, commands and files.

## Installations

A list of commands to install the necessary tools for a new machine.

```bash
sudo add-apt-repository ppa:deadsnakes/ppa ; sudo apt-get update ; sudo apt-get upgrade ; sudo apt-get install -y build-essential make wget git zip postgresql-client build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev  curl libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev llvm jq libpq-dev default-jdk apt-transport-https ca-certificates gnupg google-cloud-cli google-cloud-sdk-gke-gcloud-auth-plugin
```

### Pyenv

Tool to manage multiple versions of Python.

1. Start by installing it with the following command:

   ```bash
   curl https://pyenv.run | bash
   ```

2. Add the following lines to your `.bashrc` file:

   ```bash
   # Pyenv configuration
   export PYENV_ROOT="$HOME/.pyenv"
   command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

   export PATH="$HOME/.pyenv/bin:$PATH"
   eval "$(pyenv init --path)"
   eval "$(pyenv init -)"
   eval "$(pyenv virtualenv-init -)"
   ```

3. Restart the terminal (or `source ~/.bashrc`) and check if the installation was successful with the command `pyenv --version`.

4. Then install the version of Python you want to use, for example:

   ```bash
   pyenv install 3.12.4
   ```

5. Or if you have a `.python-version` file in your project, you can use the following commands:

   ```bash
   pyenv install $(cat .python-version)
   pyenv shell $(cat .python-version)
   ```

### Oh My Posh

For using the Oh My Posh theme

<p align="center">
  <img src="https://github.com/user-attachments/assets/9f36e26c-8527-42c2-b709-9c9067bbb266" width="100%"/>
</p>

1. you need to install the necessary fonts.

   ```bash
   FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
   FONT_DIR="$HOME/.local/share/fonts"
   wget $FONT_URL -O ${FONT_NAME}.zip
   unzip ${FONT_NAME}.zip -d $FONT_NAME
   mkdir -p $FONT_DIR
   mv ${FONT_NAME}/*.ttf $FONT_DIR/
   # Update the font cache
   fc-cache -fv
   # delete the files created from this
   rm -rf ${FONT_NAME} ${FONT_NAME}.zip
   echo "'$FONT_NAME' installed successfully."
   ```

1. Install [Oh My Posh](https://ohmyposh.dev/docs/installation/linux):

   ```bash
   sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
   sudo chmod +x /usr/local/bin/oh-my-posh
   sudo apt install unzip; curl -s https://ohmyposh.dev/install.sh | sudo bash -s
   ```

1. Go to your `.bashrc` file:

   ```bash
   code ~/.bashrc
   ```

1. Paste this line at the end:

   ```bash
   eval "$(oh-my-posh init bash --config 'https://raw.githubusercontent.com/v-amorim/self_development/main/config/oh-my-posh/themes/viniam_bubblesextra.omp.json')"
   ```

## Files

### [.bashrc][bashrc]

Useful configurations for the terminal.

Append the contents of the `.bashrc` file to your `code ~/.bashrc` file.

### [.bash_aliases][bash_aliases]

Useful aliases for the terminal.

Append the contents of the `.bash_aliases` file to your `code ~/.bash_aliases` file.

### [.inputrc][inputrc]

To enable command completion based on the history of commands.

Append the contents of the `.inputrc` file to your `code ~/.inputrc` file.

## Guides

Some useful command guides for using bash.

### Git Setup

```bash
git config --global user.name "username"
git config --global user.email "email@email.com"
```

### Generate a new SSH key pair

Useful for GitHub authentication.

```bash
ssh-keygen -t ed25519 -C "email@email.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

Then copy the output and paste it in the GitHub settings.

<!-- URLS -->

[bashrc]: ./.bashrc
[bash_aliases]: ./.bash_aliases
[inputrc]: ./.inputrc
[oh_my_posh]: ../oh-my-posh/README.md
