# 💠 Epidots

A clean, automated, and aesthetic **NixOS** configuration designed specifically for **EPITA** school computers.

This setup enhances the default environment with terminal auto-completion, a modern status bar, cool menus, custom Vim and Neovim configuration, and dynamic color theming using **Matugen**.

Inspired by my [**Arch Linux dotfiles**](https://github.com/tsunooky/dotfiles) and [**Epiconf**](https://github.com/ilil2/Epiconf) for the vimrc.

[**Join the Discord Server**](https://discord.gg/G7MNkdDFD9) (Important in case of any critical problem!)

> **⚠️ If you run into a problem:** Run `update-conf`, `reboot`, and check if the problem persists.
> To restore default EPITA configuration, run `reset-conf`.

## 📦 Installation

### 🦊 Requirement
For the automatic theming to work with Firefox using your wallpaper color, you **must** install [**Pywalfox**](https://addons.mozilla.org/en-US/firefox/addon/pywalfox/) extension.

### 💠 Installation
**WARNING:** This will override your existing `i3`, `nvim`, `.vimrc`, `.bashrc`, and `.zshrc` configurations.

Run the following command in your terminal to install everything automatically:

```bash
curl -L epidots.dserv.fr | sh -s
```
> By default, the `$mod` key will be `WIN`. You can switch to `ALT` by running the command `altpls` after install (`winpls` to revert).

## 🎨 Theming with Matugen

This configuration uses **Matugen**, a **Material You** color scheme generator. It creates a common look across your system by extracting colors from your wallpaper and applying them everywhere (i3, status bar, terminal, Vim, Firefox, GTK, Qt, ...).

### How to change the theme
You can choose a wallpaper with a menu using `$mod + Shift + W`.
Also, you can either use `$mod + Shift + B` or `rbg` to randomly change the wallpaper from the **wallpaper directory**, or change the wallpaper to a specific picture with `bg <path-to-image>`.

You can access the **wallpaper directory** with `bgdir` and add a picture to the directory with `bgadd <file>`.

## ⌨️ Keybinds (i3)

### Window Management
| Keybind | Action |
| :--- | :--- |
| `$mod` + `Enter` | Open Terminal |
| `$mod` + `Shift` + `Enter` | Spawns a new terminal instance in current focused terminal directory |
| `$mod` + `Shift` + `Q` | Kill focused window |
| `$mod` + `F` | Toggle Fullscreen |
| `$mod` + `Arrow Keys` | Focus window (Left/Down/Up/Right) |
| `$mod` + `Shift` + `Arrows` | Move window |
| `$mod` + `TAB` | Go to next workspace |
| `$mod` + `Shift` + `TAB` | Go to previous workspace |

### System & Media
| Keybind | Action |
| :--- | :--- |
| `$mod` + `D` | Open **Application Launcher** |
| `$mod` + `Shift` + `E` | Open **Power Menu** (Shutdown/Reboot/Logout/Lock) |
| `$mod` + `Shift` + `W` | Open **Wallpaper Chooser** |
| `$mod` + `Shift` + `B` | Set a random wallpaper |
| `$mod` + `N` | Open your floating **personal note** stored in AFS |
| `$mod` + `I` / `$mod` + `L` | Launch i3lock |
| `$mod` + `B` | Open **Bluetooth Manager** |
| `$mod` + `Shift` + `F` | Open **Firefox** |
| `$mod` + `Shift` + `S` / `Print Screen` | Take a **screenshot** of the selected screen part|

### Numpad / Special Keys (Midlab & Cisco)
| Key | Action |
| :--- | :--- |
| `Lock` | Launch i3lock |
| `Web` | Open Epidots documentation |
| `Mail` | Set a random wallpaper |
| `Calc` | Throw a flashbang on screen! (`flash` command) |

## 🚀 Aliases & Functions

This configuration includes a suite of commands you can use inside the terminal to speed up your workflow.

### EPITA & Utilities
| Alias | Command / Description |
| :--- | :--- |
| `afs` | Go into the **afs** directory |
| `clean-afs`| Clean cache and useless config files to free afs space
| `double` | Spawn a new terminal instance in current directory |
| `copy <file(s)>` | Copy content of given files to clipboard |
| `extract <file(s)>` | Extract a file of any type (`.tar`, `.zip`, etc.) |
| `extpls` | Move all compressed files from Downloads, and extract the content in current directory |
| `cf <file(s)>` | Run `clang-format -i` on given files |
| `cfe` | Apply **Clang Format** on every files in current repository |
| `makec` | Run `make && make check && make clean` |
| `gcw` | `gcc` with all required EPITA flags (`-Werror -Wall -Wextra -Wvla`...) |

### Git Shortcuts
| Alias | Command |
| :--- | :--- |
| `cdg` | Go to the root of current git repository |
| `gs` | `git status` |
| `gpu` | `git pull` |
| `ga` | `git add` |
| `gc` | `git commit -m` |
| `gp` | `git push` |
| `gd` | `git diff` |
| `gt` | `git tag -ma` |
| `gpt` | `git push --follow-tags` |
| `gl` | `git log` |
| `gg <optional_tag>` | `git add .` at root, `git commit -m "added features"` and `git push`. The `optional_tag` will be pushed if precised |

## 📝 Vim Configuration

### ⚡ General Shortcuts

| Keybind | Action |
| :--- | :--- |
| `Ctrl` + `f` | Run **Clang Format** on the file (BEST KEYBIND) |
| `Ctrl` + `s` | **Save** file (`:w`) |
| `Ctrl` + `x` | **Save & Quit** (`:x`) |
| `Ctrl` + `q` | **Force Quit** (`:q!`) |
| `Ctrl` + `u` | **Undo** |
| `Ctrl` + `y` | **Redo** |
| `Ctrl` + `c` | Copy (Visual Mode) |
| `Ctrl` + `v` | Paste (Insert/Normal Mode) |
| `Ctrl` + `t` | Toggle File Explorer (**NERDTree**) |
|`+` | Open New Tab |
| `<` / `>` | Previous / Next Tab |


## ⚙️ Customization

`kinit -R && aklog` is run automatically every 8 hours to refresh your AFS session token.

You can add your own shell scripts to run automatically when you log in (after package installation) by placing your scripts inside:
`~/afs/.confs/config/scripts/startup_scripts/`
or use the command `scriptadd <script>` to add it automatically to the folder.

## 🔄 Management

To keep your configuration up to date, use theses commands:

```bash
# Update the configuration (pulls latest changes)
update-conf

# To remove Epidots and restore the default EPITA configuration
reset-conf
# (It now backups your custom added scripts/wallpapers to ~/afs/user_scripts/ and ~/afs/user_wallpapers/!)
```

## 📩 Contact

If you encounter any kind of problem or have any suggestion about Epidots, feel free to report it on the [Discord Server](https://discord.gg/G7MNkdDFD9).