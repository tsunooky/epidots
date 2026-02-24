# 💠 Epidots

⚠️ If you have a problem, first type `update-conf`, `reboot`, and look if the problem is still here.
> To restore the default EPITA configuration : `reset-conf`.

A clean, automated, and aesthetic NixOS configuration designed for **EPITA** school computers.

This setup enhances the default environment with terminal autocompletion, a modern status bar, custom Vim bindings, and dynamic color theming using **Matugen**.

Inspired by my [**Arch Linux dotfiles**](https://github.com/tsunooky/dotfiles) for the visuals and [**Epiconf**](https://github.com/ilil2/Epiconf) for the vimrc.

[**Join the Discord Server**](https://discord.gg/G7MNkdDFD9) (important in case of problems!)

## 📦 Installation

### 🦊 Installation Requirement
For the automatic theming to work with Firefox, you must install [**Pywalfox**](https://addons.mozilla.org/en-US/firefox/addon/pywalfox/) extension.

### 💠 Installation
**WARNING:** This will override your existing `i3`, `.vimrc`, `.bashrc` and `.zshrc` configuration.

Run the following command in your terminal to install everything automatically:

```bash
curl -L epidots.dserv.fr | sh -s
```
> By default, the `$mod` key will be `WIN`, you can change this by typing `altpls` (`winpls` to revert) in your terminal after install.

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
| `$mod` + `Shift` + `Enter` | Spawns a new terminal instance in current focused terminal directory |
| `$mod` + `Shift` + `Q` | Kill focused window |
| `$mod` + `D` | Open Application Launcher |
| `$mod` + `F` | Toggle Fullscreen |
| `$mod` + `Arrow Keys` | Focus window (Left/Down/Up/Right) |
| `$mod` + `Shift` + `Arrows` | Move window |
| `$mod` + `TAB` | Go to next workspace |
| `$mod` + `Shift` + `TAB` | Go to previous workspace |

### Numpad / Special Keys (Midlab & Cisco)
| Key | Action |
| :--- | :--- |
| `Lock` | Launches i3lock |
| `Web` | Opens Epidots documentation |
| `Mail` | Sets a random wallpaper |
| `Calc` | Throws a flashbang on screen (`flash` command) |

### System & Media
| Keybind | Action |
| :--- | :--- |
| `$mod` + `D` | Opens **Application Menu** |
| `$mod` + `Shift` + `E` | Opens **Power Menu** (Shutdown/Reboot/Logoff/Lock) |
| `$mod` + `Shift` + `W` | Opens **Wallpaper Chooser** (in the Wallpaper Directory) |
| `$mod` + `Shift` + `B` | Sets a random wallpaper (from the Wallpaper Directory) |
| `$mod` + `N` | Opens your floating **personal note** |
| `$mod` + `I` / `$mod` + `L` | Launches i3lock |
| `$mod` + `B` | Open **Bluetooth Manager** |
| `$mod` + `Shift` + `F` | Open **Firefox** |

---

## 🚀 Aliases & Functions

This configuration includes a suite of commands you can use inside the terminal to speed up your workflow.

### EPITA & General Utilities
| Alias | Command / Description |
| :--- | :--- |
| `afs` | goes into the **afs** directory |
| `clean-afs`| Cleans cache and useless config files to free afs space (**Deletes Thunderbird config folder**)
| `double` | Spawns a new terminal instance in current directory |
| `intra` | Open Intranet |
| `moodle` | Open Moodle |
| `copy <file(s)>` | Copy content of given files to clipboard  |
| `extract <file(s)>` | Extract a file of any type (`.tar`, `.zip`, etc.) |
| `extpls` | Moves all compressed files from Downloads, and extracts the content in current directory |
| `cf <file(s)>` | Run `clang-format -i` on given files |
| `cfe` | Apply **Clang Format** on every files in current repository |
| `makec` | runs `make && make check && make clean` (The holy trinity) |
| `gcw` | `gcc` with all required EPITA flags (`-Werror -Wall -Wextra -Wvla`...) |

### SQL Utilities
| Command | Description |
| :--- | :--- |
| `sqlsetup` | Initialize the database (same location as `roger_roger.dump`) |
| `sqlserv` | Start the SQL server |
| `sqlrun <request>` | Execute a SQL request and show colored output |
| `sqlfix <request>` | Format your SQL request using `sqlfluff` |

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
| `gg <optional_tag>` | `git add .` at root, `git commit -m "added features"` and `git push`. The `optional_tag` will be pushed if precised |

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

## ⚙️ Customization

### Startup Scripts
You can add your own shell scripts to run automatically when you log in (after package installation).
Simply place your scripts in:
`~/afs/.confs/config/scripts/startup_scripts/`
or use the command `scriptadd <script>` to add it automatically to the folder.

## 🔄 Management

To keep your configuration up to date, use theses commands:

```bash
# Update the configuration (pulls latest changes)
update-conf

# ⚠️ Factory Reset
# Removes Epidots and restores the default EPITA configuration
reset-conf
```

## 📩 Contact

If you encounter any kind of problem or have any suggestion about Epidots, feel free to report it on the [Discord Server](https://discord.gg/G7MNkdDFD9).
