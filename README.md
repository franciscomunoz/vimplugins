# Introduction
This is my latest plugin configuration for writing code. It's based on vimplug for managing plugins. 
The previous version was based on gitsubmodules and pathogen which made the process of trying plugins a
little convoluted. The `.vimrc` file has code that downloads vimplug and installs all the plugins when vim 
is opened for the first time. 

# Configuration
Rename the folder `vimplugins` to `.vim` and create a symbolic link to `.vimrc` which is located inside `vimplugins`.

# Testing new plugins via vimplug
Add new entries in the vimrc file and run `:PlugInstall`

Refer to [vimplug] (https://github.com/junegunn/vim-plug)
