# dotfiles
Personal Configuration for my development environment

## Main Files

### Setup.sh

- Submodule update before copying over files onto local computer
    - Inside `~/.zshrc`, the `ZSH` should point to the .oh-my-zsh folder
    - For example, the user path is under `/Users/bekzod` not `/Users/bekzodtursunov`
        ```
        export ZSH="/Users/bekzod/.oh-my-zsh"
        ```

### Update.sh

- Bring over changes from local computer into repo

### Copy.sh

- Copy over files in this repo onto local computer
