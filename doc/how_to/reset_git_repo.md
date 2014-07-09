How to reset a git repository
=============================

This process eliminates all history in a git repo.

Warning: All remotes will have to be deleted and cloned again since we're changing
a repo's history in a big way.


1. cd (project-directory)
1. Delete git meta data
    rm -rf .git
1. Re-create the repo
    git init
1. Prepare the working tree, add and modify files for initial commit
1. Stage all files
    git add .
1. Do initial commit
    git commit -m 'Initial commit'
1. Add remote
    git remote add origin <url>
1. Push changes to remote
    git push --force

Inspired by http://stackoverflow.com/a/2006252
