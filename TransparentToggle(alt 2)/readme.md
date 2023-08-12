# README.md

## Overview

This script provides functionality to toggle the transparency of the currently active window using the hotkey combination `Alt + 2`. When activated, the script sets the transparency of the active window to 150 (on a scale of 0-255, with 255 being fully opaque). Pressing the hotkey combination again will revert the window back to its original state.

## Setup

1. **Dependencies**: 
   - Ensure you have AutoHotKey installed on your machine.

2. **Usage**:
   - Run the script.
   - Press `Alt + 2` to make the currently active window semi-transparent.
   - Press `Alt + 2` again to revert the window back to its original opacity.

## How It Works

1. The script sets some recommended directives for performance and compatibility.
2. The hotkey combination `Alt + 2` (`!2::`) is defined to toggle the transparency of the active window.
3. When the hotkey is pressed, the `toggle` variable switches between its active and inactive states.
4. If `toggle` is active, the script sets the transparency of the active window (`A`) to 150.
5. If `toggle` is inactive, the script turns off the transparency for the active window.

## Use Cases

This script is useful for users who often work with multiple overlapping windows and want to quickly peek at the content behind the active window without minimizing or moving it. By simply pressing `Alt + 2`, the user can make the active window semi-transparent and see the content behind it.

## Notes

- The `#NoEnv` directive is recommended for performance and compatibility with future AutoHotkey releases.
- The `SendMode Input` directive is recommended for new scripts due to its superior speed and reliability.
- The `SetWorkingDir %A_ScriptDir%` directive ensures that the script always starts in the directory where it is located.
