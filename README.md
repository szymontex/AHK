# README.md

## Collection of AutoHotKey Scripts

This repository contains a collection of AutoHotKey scripts designed for various purposes. Below are detailed descriptions and usage instructions for each script.

---
# Antelope Audio Sample Rate Synchronization Script

## Overview

This AutoHotkey script synchronizes the sample rate between the ASIO drivers and Windows WDM (Windows Driver Model) drivers for Antelope Audio interfaces. It ensures that when the sample rate changes in the ASIO control panel, the corresponding Windows audio devices update their sample rates accordingly. This prevents situations where audio playback fails because the ASIO and WDM drivers have mismatched sample rates.

## How It Works

- **Monitoring the Log File**: The script continuously monitors the Antelope Audio log file located at `C:\Users\Public\.AntelopeAudio\discrete8_hybrid_tb3\panels\1.1.6\panel_log.txt`. Check your version of the interface and change the path accordingly.
- **Detecting Sample Rate Changes**: It looks for changes in the `sync_freq` parameter within the log file.
- **Updating Audio Devices**: When a change is detected, it uses the `SoundVolumeView` utility to update the sample rate of specified Windows audio devices to match the new `sync_freq`.
- **Control Panel Integration**: The script also includes integration to automatically start the Antelope Audio Control Panel using a specific device ID and to change the position of the control panel window based on settings specified in a separate text file. This feature ensures that the control panel launches with the correct settings and can be positioned on the screen as desired.

## Requirements

- **AutoHotkey**: Install from [https://www.autohotkey.com/](https://www.autohotkey.com/). Choose V1.
- **SoundVolumeView Utility**: Download from [https://www.nirsoft.net/utils/sound_volume_view.html](https://www.nirsoft.net/utils/sound_volume_view.html) and place it in `C:\IT\!AHK\SoundVolumeView\`.

## Setup Instructions

1. **Download the Script**

   Save the provided `AsioWdmSRSync.ahk` script to a location of your choice.

2. **Adjust the Log Path (if necessary)**

   Ensure the `LogPath` variable points to the correct log file location for your Antelope Audio device.

   ```autohotkey
   LogPath := "C:\Users\Public\.AntelopeAudio\discrete8_hybrid_tb3\panels\1.1.6\panel_log.txt"
   ```

3. **Update Device Names (if necessary)**

   Modify the `Devices` array to include all the audio devices you wish to synchronize. You can find the correct names for your devices using the SoundVolumeView utility, specifically in the "Command-Line Friendly" column.

   ```autohotkey
   Devices := ["Your Device Name Here\\Render", "Another Device\\Capture"]
   ```

4. **Ensure SoundVolumeView Path is Correct**

   The script assumes `SoundVolumeView.exe` is located at `C:\IT\!AHK\SoundVolumeView\SoundVolumeView.exe`. Update the `Command` variable in the script if your path is different.

   ```autohotkey
   Command := "Your Path to SoundVolumeView.exe /SetDefaultFormat ..."
   ```

5. **Launch the Antelope Audio Control Panel**

   The script automatically launches the Antelope Audio Control Panel using a specific device ID. The control panel is started via the command line using the `--use-device` flag, which specifies the interface's device ID. This method of launching the control panel is essential for capturing logs and saving them to the specified log file. This device ID can be obtained from the Antelope Launcher logs after the control panel has been started manually.

   ```autohotkey
   ; Example of starting the control panel with device ID
   Run, %ComSpec% /c ""%ExePath%" --use-device 3424222000110 > "%LogPath%"", , Hide
   ```

6. **Configure Window Positioning (Optional)**

   The script includes an integration to move the control panel window to specific screen positions based on values read from a text file (`!GdzieTV.txt`). This can be useful for setting up your workspace, but you can remove this feature if it's not needed.

   ```autohotkey
   ; Example of moving the control panel window
   if (InStr(TVPosition, "TVup"))
   {
       WinMove, ahk_exe discrete4_hybrid_tb3.exe,, 665, -768, 1360, 768 
   }
   ```

7. **Compile the Scripts**

   Both the `AsioWdmSRSync.ahk` and `antelope4discrete.ahk` scripts should be compiled into `.exe` files using AutoHotkey. Place both `.exe` files in the same directory.

8. **Run the Script**

   To start, run the `antelope4discrete.exe` file. This will launch the Antelope Audio Control Panel and automatically trigger the execution of `AsioWdmSRSync.exe`, ensuring that the sample rates are synchronized properly.

## Usage

- **Automatic Synchronization**: The script runs in the background and checks for sample rate changes every second.
- **Control Panel Management**: The script also handles the launching and positioning of the Antelope Audio Control Panel, ensuring it's properly configured each time it's started.
- **Debugging**: Uncomment the `MsgBox` lines in the script if you want to see pop-up messages for debugging purposes.

## Troubleshooting

- **Log File Access Issues**: If the script cannot open the log file, check the file path and permissions.
- **Device Not Updating**: Ensure that the device names in the `Devices` array exactly match those recognized by `SoundVolumeView`.
- **SoundVolumeView Errors**: Verify that `SoundVolumeView.exe` is accessible and not blocked by antivirus software.
- **Control Panel Not Starting**: Double-check the device ID used in the `--use-device` flag and ensure it's correctly retrieved from the Antelope Launcher logs.

## Contributing

If you have suggestions or improvements, feel free to fork the repository and submit a pull request.

## License

This project is licensed under the MIT License.


If you have suggestions or improvements, feel free to fork the repository and submit a pull request.

## License



---




# Machine Activity Monitor

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



# Continuous Scrolling Toggle

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



# Window Transparency Toggle

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



This project is licensed under the MIT License.
