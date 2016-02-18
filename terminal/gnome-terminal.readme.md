First get the id of your profile using:
```
dconf list /org/gnome/terminal/legacy/profiles:/
```

Then execute the following command, replacing $profile by the id of your profile.
```
cat ~/.dotfiles/terminal/gnome-terminal.txt | dconf load /org/gnome/terminal/legacy/profiles:/$profile/
```

For example, for my home pc its:
```
cat ~/.dotfiles/terminal/gnome-terminal.txt | dconf load /org/gnome/terminal/legacy/profiles:/:9b755ead-1abd-4897-aa4d-45b0e06f3b4b/
```
