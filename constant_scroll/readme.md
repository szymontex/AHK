# README.md

## Overview

This script allows the user to toggle continuous scrolling using the spacebar. When activated, the script simulates the "WheelDown" action, which is equivalent to scrolling down on a mouse wheel.

## Setup

1. **Dependencies**: 
   - Ensure you have AutoHotKey installed on your machine.

2. **Usage**:
   - Run the script.
   - Press the spacebar to start continuous scrolling.
   - Press the spacebar again to stop continuous scrolling.

## How It Works

1. The script sets a maximum of 2 threads per hotkey to ensure smooth toggling.
2. When the spacebar (`*Space::`) is pressed, the `Toggle` variable is switched between its active and inactive states.
3. If `Toggle` is active, the script enters a loop where it simulates the "WheelDown" action, causing the screen to scroll down.
4. Pressing the spacebar again deactivates the `Toggle`, breaking out of the loop and stopping the scrolling.

## Use Cases

This script is useful for reading long articles, documents, or web pages without manually scrolling. By simply pressing the spacebar, the user can have a hands-free scrolling experience.

## Notes

- The script uses the `MaxThreadsPerHotkey` directive set to 2 to ensure that the hotkey can be toggled on and off smoothly.
- The `*` modifier in the hotkey (`*Space::`) allows the hotkey to be triggered even if other modifiers (like Shift or Ctrl) are held down.
