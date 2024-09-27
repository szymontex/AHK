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
