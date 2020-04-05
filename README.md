# tmux-task-watcher

![MIT](https://img.shields.io/github/license/PatOConnor43/tmux-task-watcher)

This plugin allows you to watch the currently active pane's process and then get
notified once it has finished. This is useful for long running builds or async
tasks that you need to know have finished but don't want to consistently check
on them.

## Demo
[![asciicast](https://asciinema.org/a/316769.svg)](https://asciinema.org/a/316769)

## Features
- [x] Configurable key start watcher
- [x] Support for macOS notifications using AppleScript
- [ ] Support for watching multiple tasks
- [ ] See history of watched jobs (command that was run, from where, etc.)
- [x] Cancel watching

## Install
### [TPM](https://github.com/tmux-plugins/tpm) (Recommend)
Add this line to your tmux config file, then hit `prefix + I`:

``` tmux
set -g @plugin 'PatOConnor43/tmux-task-watcher'
```
### Manually
Clone this repo and source the tmux-task-watcher.tmux in your config file.

## Usage
The default key binding is `W`, it can be modified by setting
@tmux-task-watcher-key.

## Options
| Option                               | Description                                | Default  | Example                                            |
| ------                               | -----------                                | -------- | --------                                           |
| @tmux-task-watcher-key               | Controls the key used to toggle watching   | `W`      | set -g @tmux-task-watcher 'x'                      |
| @tmux-task-watcher-mac-notifications | Enables notifications via AppleScript      | `false`  | set -g @tmux-task-watcher-mac-notifications 'true' |

## Something broke?
- If you feel like the watcher isn't working as expected, please try deleting
    the `~/.tmux/plugins/tmux-task-watcher/PID` file. This should reset you to a
    clean state.
- File an issue describing what happened.
- Pull requests welcome!
