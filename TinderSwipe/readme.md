# README.md

## Overview

This script continuously simulates the pressing of the `Right` arrow key followed by the `Esc` key at regular intervals. The script is designed to send the `Right` key press, wait for 700 milliseconds, send the `Esc` key press, and then wait for another 700 milliseconds before repeating the sequence.

## Setup

1. **Dependencies**: 
   - Ensure you have AutoHotKey installed on your machine.

2. **Usage**:
   - Run the script.
   - The script will automatically start sending the `Right` and `Esc` key presses at the specified intervals.
   - To stop the script, right-click on the AutoHotKey icon in the system tray and select "Exit".

## How It Works

1. The script sets a maximum of 1 thread per hotkey to ensure that the loop runs smoothly without interruptions.
2. The script enters a continuous loop where:
   - It simulates the pressing of the `Right` arrow key.
   - Waits for 700 milliseconds.
   - Simulates the pressing of the `Esc` key.
   - Waits for another 700 milliseconds.
   - Repeats the sequence.

## Use Cases

This script can be useful in scenarios where a user needs to automate the process of navigating through a sequence of screens or slides and then exiting out of them repeatedly. For example, it can be used to cycle through a slideshow or a series of images in a viewer.

## Notes

- The `#MaxThreadsPerHotkey` directive is set to 1 to ensure that the loop runs without interruptions.
- The `Send` command is used to simulate key presses.
- The `sleep` command introduces a delay, specified in milliseconds, between actions.
