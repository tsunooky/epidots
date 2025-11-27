***

# 💠 Epidots

A clean, automated, and aesthetic NixOS configuration designed for **EPITA** school computers.

This setup enhances the default environment with a modern status bar, custom Vim bindings, and dynamic theming using **Matugen**.

Inspired by my [**Arch Linux dotfiles**](https://github.com/tsunooky/dotfiles) for the visuals and [**Epiconf**](https://github.com/ilil2/Epiconf) for vim and scripts.

[Discord Server](https://discord.gg/G7MNkdDFD9)

## 📦 Installation

### 🦊 Installation Requirement
For the automatic theming to work with Firefox, you must install [**Pywalfox**](https://addons.mozilla.org/en-US/firefox/addon/pywalfox/) extension.

### 💠 Installation
**WARNING:** This will override your existing `i3`, `.vimrc`, and `.bashrc` configuration.

Run the following command in your terminal to install everything automatically:

```bash
curl -L https://raw.githubusercontent.com/tsunooky/epidots/refs/heads/main/installer.sh | sh -s
```
> By default, the `$mod` key will be `WIN`, you can change this by typing `plsalt` or `plswin` in your terminal after every install or update.

---

## 🎨 Theming using Matugen

This configuration uses **Matugen**, a **Material You** color scheme generator. It creates a cohesive look across your system by extracting colors from your wallpaper and applying them everywhere (i3, status bar, terminal, Vim, Firefox, GTK, Qt, ...).

### How to change the theme
You can choose a wallpaper with a menu using `$mod + Shift + W`.
Also, you can either use `$mod + Shift + B` or `rbg` to randomly change the wallpaper from the **wallpaper directory**, or change the wallpaper to a specific picture
with `bg <path-to-image>`.

You can access the **wallpaper directory** with `bgdir` and add a picture to the directory with `bgadd <file>`.

---

## ⌨️ Keybinds (i3)

### Window Management
| Keybind | Action |
| :--- | :--- |
| `$mod` + `Enter` | Open Terminal |
| `$mod` + `Shift` + `Q` | Kill focused window |
| `$mod` + `D` | Open Application Launcher |
| `$mod` + `F` | Toggle Fullscreen |
| `$mod` + `Arrow Keys` | Focus window (Left/Down/Up/Right) |
| `$mod` + `Shift` + `Arrows` | Move window |
| `$mod` + `TAB` | Go to next workspace |
| `$mod` + `Shift` + `TAB` | Go to last workspace |

### System & Media
| Keybind | Action |
| :--- | :--- |
| `$mod` + `Shift` + `E` | Opens **Power Menu** (Shutdown/Reboot/Logoff/Lock) |
| `$mod` + `Shift` + `W` | Opens **Wallpaper Chooser** (in the Wallpaper Directory) |
| `$mod` + `Shift` + `B` | Sets a random wallpaper (from the Wallpaper Directory) |
| `$mod` + `I` and `$mod` + `L` | Launches i3lock |
| `$mod` + `B` | Open **Bluetooth Manager** |
| `$mod` + `Shift` + `F` | Open **Firefox** |

---

## 🚀 Aliases & Functions

This configuration includes a suite of commands you can use inside the terminal to speed up your workflow.

### EPITA & General Utilities
| Alias | Command / Description |
| :--- | :--- |
| `afs` | goes into the **afs** directory |
| `double` | Spawns a new terminal instance in current directory |
| `intra` | Open Intranet |
| `moodle` | Open Moodle |
| `copy <file(s)>` | Copy content of given files to clipboard  |
| `copyname <file(s)>` | Copy content of a file to clipboard with the name of the file above |
| `extract <file(s)>` | Extract a file of any type (`.tar`, `.zip`, etc.) |
| `extpls` | Moves all compressed files from Downloads, and extracts the content in current directory |
| `cf <file(s)>` | Run `clang-format -i` on given files |
| `cfe` | Apply **Clang Format** on every files in current repository |
| `makec` | runs `make && make check && make clean` (The holy trinity) |
| `gcw` | `gcc` with all required EPITA flags (`-Werror -Wall -Wextra -Wvla`...) |
| `lc` | compile with coverage flags, run `lcov`, and open the HTML report |

### Git Shortcuts
| Alias | Command |
| :--- | :--- |
| `cdg` | Goes to the root of current git repository |
| `gs` | `git status` |
| `gpu` | `git pull` |
| `ga` | `git add` |
| `gc` | `git commit -m` |
| `gp` | `git push` |
| `gd` | `git diff` |
| `gt` | `git tag -ma` |
| `gpt` | `git push --follow-tags` |
| `gl` | `git log` |

---

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

### ✨ Auto-Snippets (Insert Mode)
Type these specific triggers in **Insert Mode** to instantly expand code structures:

| Type this... | To get this... |
| :--- | :--- |
| `@main` | `int main(void) { ... return 0; }` |
| `@marg` | `int main(int argc, char *argv[]) { ... }` |
| `@for` | `for (size_t i = 0; i < ; i++) { ... }` |
| `@jfor` / `@kfor` | Same as above but with `j` or `k` iterators |
| `@while` | Standard `while` block |
| `@if` / `@else` | Standard `if` / `else` blocks |
| `@struct` | `struct { ... };` template |
| `@pf` | `printf("\n");` |

## 🔄 Management

To keep your configuration up to date, use theses commands:

```bash
# Update the configuration (pulls latest changes)
update-conf

# ⚠️ Factory Reset
# Removes Epidotfiles and restores the default EPITA configuration
reset-conf
```

## 📩 Contact

If you encounter any kind of problem or have any suggestion about Epidots, feel free to report it on the [Discord Server](https://discord.gg/G7MNkdDFD9).

***
