# README.md

## Collection of AutoHotKey Scripts

This repository contains a collection of AutoHotKey scripts designed for various purposes. Below are detailed descriptions and usage instructions for each script.

---

### Machine Activity Monitor

#### Overview

This script is designed to monitor the activity of a machine and send a webhook notification based on the machine's state (active or inactive). The script checks the machine's activity every 3 seconds and sends a webhook notification when the machine has been inactive for more than 60 seconds.

#### Setup

1. **Dependencies**: 
   - Ensure you have AutoHotKey installed on your machine.

2. **Script Configuration**:
   - Replace `<path_to_variable_in_txt>` with the path to your text file containing the variable you want to send in the webhook.
   - Replace `<your_webhook_url_machine_is_inactive>` with the webhook URL you want to call when the machine is inactive.
   - Replace `<your_webhook_url_machine_is_active>` with the webhook URL you want to call when the machine becomes active again.
   - Replace `<your_GET_variable>` with the name of the GET variable you want to send in the webhook.

3. **Time Configuration**:
   - The script checks the machine's activity every 3 seconds by default. If you want to change this interval, modify the value `3000` in the `SetTimer, Check, 3000` line to your desired interval in milliseconds.

4. **Webhook Construction**:
   - The webhook should be constructed as a GET request.
   - Example for inactive state: `<your_webhook_url_machine_is_inactive>?<your_GET_variable>=<value_from_txt_file>`
   - Example for active state: `<your_webhook_url_machine_is_active>?<your_GET_variable>=<value_from_txt_file>`

#### How It Works

1. The script reads a variable from a specified text file.
2. It then continuously checks the machine's physical idle time.
3. If the machine has been inactive for more than 60 seconds, it sends a webhook notification indicating that the machine is inactive.
4. When the machine becomes active again, it sends another webhook notification indicating that the machine is active.

#### Why Use This Script?

This script is useful for scenarios where you want to monitor the activity of a machine and take actions based on its state. For example, you might want to turn off certain services or applications when the machine is inactive to save resources.

---

### Continuous Scrolling Toggle

#### Overview

This script allows the user to toggle continuous scrolling using the spacebar. When activated, the script simulates the "WheelDown" action, which is equivalent to scrolling down on a mouse wheel.

#### Setup

1. **Dependencies**: 
   - Ensure you have AutoHotKey installed on your machine.

2. **Usage**:
   - Run the script.
   - Press the spacebar to start continuous scrolling.
   - Press the spacebar again to stop continuous scrolling.

#### How It Works

1. The script sets a maximum of 2 threads per hotkey to ensure smooth toggling.
2. When the spacebar (`*Space::`) is pressed, the `Toggle` variable is switched between its active and inactive states.
3. If `Toggle` is active, the script enters a loop where it simulates the "WheelDown" action, causing the screen to scroll down.
4. Pressing the spacebar again deactivates the `Toggle`, breaking out of the loop and stopping the scrolling.

#### Use Cases

This script is useful for reading long articles, documents, or web pages without manually scrolling. By simply pressing the spacebar, the user can have a hands-free scrolling experience.

---

### Window Transparency Toggle

#### Overview

This script provides functionality to toggle the transparency of the currently active window using the hotkey combination `Alt + 2`. When activated, the script sets the transparency of the active window to 150 (on a scale of 0-255, with 255 being fully opaque). Pressing the hotkey combination again will revert the window back to its original state.

#### Setup

1. **Dependencies**: 
   - Ensure you have AutoHotKey installed on your machine.

2. **Usage**:
   - Run the script.
   - Press `Alt + 2` to make the currently active window semi-transparent.
   - Press `Alt + 2` again to revert the window back to its original opacity.

#### How It Works

1. The script sets some recommended directives for performance and compatibility.
2. The hotkey combination `Alt + 2` (`!2::`) is defined to toggle the transparency of the active window.
3. When the hotkey is pressed, the `toggle` variable switches between its active and inactive states.
4. If `toggle` is active, the script sets the transparency of the active window (`A`) to 150.
5. If `toggle` is inactive, the script turns off the transparency for the active window.

#### Use Cases

This script is useful for users who often work with multiple overlapping windows and want to quickly peek at the content behind the active window without minimizing or moving it. By simply pressing `Alt + 2`, the user can make the active window semi-transparent and see the content behind it.

---

### Continuous Right Arrow and Esc Key Press aka. Tinder Swipe

#### Overview

This script continuously simulates the pressing of the `Right` arrow key followed by the `Esc` key at regular intervals. The script is designed to send the `Right` key press, wait for 700 milliseconds
