# 💠 Epidots

A clean, automated, and aesthetic **NixOS** configuration designed specifically for **EPITA** school computers. It is inspired by my [**Arch Linux dotfiles**](https://github.com/tsunooky/dotfiles).

This setup enhances the default environment with terminal auto-completion, a modern status bar, cool menus, custom Vim and Neovim configs, and dynamic color theming using **Matugen**.

[**Join the Discord server !**](https://discord.gg/ftsGDqBfWY) (Important in case of problems)

> **⚠️ If you run into any problem:** Run `update-conf`, `reboot`, and check if the problem persists. To restore default EPITA configuration, run `reset-conf`.

## 📦 Installation

### 🦊 Requirement
For the color theming to work with Firefox, you **must** install [**Pywalfox**](https://addons.mozilla.org/en-US/firefox/addon/pywalfox/) extension.

### 💠 Installation
**WARNING:** This will override your existing `i3`, `nvim`, `.vimrc`, `.bashrc`, and `.zshrc` configurations.

Run the following command in your terminal to install everything:

```bash
curl -L epidots.dserv.fr | sh -s
```
> By default, the `$mod` key will be `WIN`. You can switch to `ALT` by running the command `altpls` after install (`winpls` to revert).

## 🎨 Theming with Matugen

This configuration uses **Matugen**, a color scheme generator. It creates a common look across your system by extracting colors from your wallpaper and applying them everywhere (i3, status bar, terminal, Vim, Firefox, GTK, ...).

### How to change the wallpaper
You can choose a wallpaper using `$mod + Shift + W`.

You can use `$mod + Shift + B` or `rbg` to randomly change the wallpaper from the **wallpaper directory**, and `bg <path-to-image>` to change the wallpaper to a specific picture.

## ⌨️ Keybinds (i3)

### Window Management
| Keybind | Action |
| :--- | :--- |
| `$mod` + `Enter` | Open a new terminal instance in AFS |
| `$mod` + `Ctrl` + `Enter` | Open a new terminal instance |
| `$mod` + `Shift` + `Enter` | Open a new terminal instance in current focused terminal directory |
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
| `$mod` + `C` | Open **Epita Hub**: Check Presence, Moodle, Intra, ... |
| `$mod` + `Shift` + `B` | Set a random wallpaper from the wallpaper directory |
| `$mod` + `N` | Open your **personal note** stored in AFS |
| `$mod` + `I` / `$mod` + `L` | Launch i3lock |
| `$mod` + `B` | Open **Bluetooth Manager** |
| `$mod` + `Shift` + `F` | Open **Firefox** |
| `$mod` + `Shift` + `S` / `Print Screen` | Take a **screenshot** of the selected screen part|

<details>

<summary>Numpad / Special Keys (Midlab & Cisco) (Click to expand!)</summary>

| Key | Action |
| :--- | :--- |
| `Lock` | Launch i3lock |
| `Web` | Open Epidots documentation |
| `Mail` | Set a random wallpaper |
| `Calc` | Throw a flashbang on screen! (`flash` command) |
</details>

## ⚡ Aliases & Functions

This configuration includes custom commands you can use in your terminal to go faster.

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

 <details>

<summary>Git Shortcuts (Click to expand!)</summary>

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

 </details>

## 📝 Vim/Nvim Configuration

| Keybind | Action |
| :--- | :--- |
| `Ctrl` + `f` | Run **Clang Format** on current file |
| `Ctrl` + `s` | **Save** (`:w`) and clang-formats current file  |
| `Ctrl` + `x` | **Save & Quit** (`:x`) |
| `Ctrl` + `q` | **Force Quit** (`:q!`) |
| `Ctrl` + `u` | **Undo** |
| `Ctrl` + `y` | **Redo** |
| `Ctrl` + `c` | Copy (Visual Mode) |
| `Ctrl` + `v` | Paste (Insert/Normal Mode) |
| `Ctrl` + `t` | Toggle File Explorer |
|`+` | Open New Buffer |
| `<` / `>` | Previous / Next Buffer |


## ⚙️ Customization

- You can add your own aliases and functions in `~/afs/.confs/zshrc`, this file will never be overwritten by an update.

- You can add your own shell scripts to run automatically when you log in (after package installation) by placing them inside
`~/afs/.confs/config/scripts/startup_scripts/`.
You can use the command `scriptadd <script>` to add a file to this folder.

- You can access the wallpaper directory with `bgdir` and add a wallpapers to the menu with `bgadd <file>`.

- `kinit -R && aklog` runs automatically every 8 hours to refresh your AFS session token.

## 🔄 Management

To keep your configuration up to date and pull the latest changes :

```bash
update-conf
```

To remove Epidots and restore the default EPITA configuration :

```bash
reset-conf
```
>This move your custom added scripts/wallpapers to ~/afs/user_scripts/ and ~/afs/user_wallpapers/

## 📩 Contact

If you encounter any problem or have any suggestion about Epidots, feel free to report it on the [Discord Server](https://discord.gg/ftsGDqBfWY).