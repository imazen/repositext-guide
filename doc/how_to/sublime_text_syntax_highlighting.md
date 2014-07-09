How to set up Repositext syntax highlighting in Sublime Text
============================================================

There is a plugin for Sublime Text 2 and 3 for syntax highlighting repositext
AT files.

Installation
------------

For ST3:

    cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/

For ST2:

    cd ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/

Common steps:

    git clone https://github.com/maliayas/MarkdownEditing
    cd MarkdownEditing
    git checkout nathanael

Restart sublime.

This plugin is under active development, so you may have to pull from origin
once in a while to get the latest updates.

Customize colors
----------------

* Inspect the scope name of the area via ctrl+shift+p. The scope name will appear in the status bar.
* Find the scope name in the MarkdownEditor.tmTheme file and edit the color as you wish. You can set one or two of the foreground and background colors.
