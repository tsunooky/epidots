***

# ☁️ Epidots

A clean, automated, and aesthetic NixOS configuration designed specifically for **EPITA** school computers.

This setup enhances the default environment with a modern status bar, custom Vim bindings, and dynamic theming using **Matugen**.

Inspired by my [**Arch Linux dotfiles**](https://github.com/tsunooky/dotfiles) for the visuals and [**Epiconf**](https://https://github.com/ilil2/Epiconf) for vim and scripts.

## 📦 Installation

> **Backup required:** This configuration will override your existing `i3`, `.vimrc`, and `.bashrc` settings. Please back up your current config before proceeding.

Run the following command in your terminal to install everything automatically:

```bash
curl -L https://raw.githubusercontent.com/tsunooky/epidots/refs/heads/main/installer.sh | sh -s
```

### 🦊 Installation Requirement
For the automatic theming to work with Firefox, you must install the [**Pywalfox**](https://addons.mozilla.org/en-US/firefox/addon/pywalfox/) extension.

---

## 🎨 Theming using Matugen

This configuration uses **Matugen**, a **Material You** color scheme generator. It creates a cohesive look across your system by extracting colors from your wallpaper and applying them everywhere (i3, status bar, terminal, Vim, Firefox, GTK, Qt, ...).

### How to change the theme
You can either use `WIN + Shift + W` or `rbg` to randomly change the wallpaper from the **wallpaper directory**, or change the wallpaper to a specific picture
with `bg <path-to-image>`

You can access the **wallpaper directory** with `bgdir` and add a picture to the directory with `bgadd <file>`.

---

## ⌨️ Keybinds (i3)



### Window Management
| Keybind | Action |
| :--- | :--- |
| `WIN` + `Enter` | Open Terminal |
| `WIN` + `Shift` + `q` | Kill focused window |
| `WIN` + `d` | Open Application Launcher |
| `WIN` + `f` | Toggle Fullscreen |
| `WIN` + `Arrow Keys` | Focus window (Left/Down/Up/Right) |
| `WIN` + `Shift` + `Arrows` | Move window |

### System & Media
| Keybind | Action |
| :--- | :--- |
| `$mod` + `Shift` + `e` | Open **Power Menu** (Shutdown/Reboot/Logoff) |
| `$mod` + `Shift` + `w` | Set random wallpaper (in the **Wallpaper Directory**) |
| `$mod` + `i` | Launches i3lock |
| `Ctrl` + `b` | Open **Bluetooth Manager** |
| `$mod` + `Shift` + `F` | Open **Firefox** |

---

## 🚀 Aliases & Functions

This configuration includes a suite of commands you can use inside the terminal to speed up your workflow at EPITA.

### EPITA & C Programming
| Alias | Command / Description |
| :--- | :--- |
| `afs` | goes into the **afs** directory |
| `intra` | Open Intranet |
| `moodle` | Open Moodle |
| `tarpls` | Moves all tar files from Downloads, and extracts the content in current directory |
| `makec` | runs `make && make check && make clean` (The holy trinity) |
| `gcw` | `gcc` with all required EPITA flags (`-Werror -Wall -Wextra -Wvla`...) |
| `cf` | Run `clang-format -i` on current files |
| `cfe` | Apply **Clang Format** on every files in current repository |
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

### General Utilities
| Alias | Command / Description |
| :--- | :--- |
| `extract <file>` | Extract a file of any type (`.tar`, `.zip`, `.rar`, etc.) |
| `copy <file(s)>` | Copy content of a file to clipboard  |
| `copyfile <file(s)>` | Copy content of a file to clipboard with the name of the file above |
| `double` | Spawns a new terminal instance in the current directory |

---

## 📝 Vim Configuration

### ⚡ General Shortcuts

| Keybind | Action |
| :--- | :--- |
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

### 🛠️ Code & Compilation

| Keybind | Action |
| :--- | :--- |
| `Ctrl` + `f` | Run **Clang Format** on the file (BEST KEYBIND) |
| `Ctrl` + `r` | **Compile and run** the file (Experimental)|

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
