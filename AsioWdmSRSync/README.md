# Antelope Audio Sample Rate Synchronization Script

## Overview

This AutoHotkey script synchronizes the sample rate between the ASIO drivers and Windows WDM (Windows Driver Model) drivers for Antelope Audio interfaces. It ensures that when the sample rate changes in the ASIO control panel, the corresponding Windows audio devices update their sample rates accordingly. This prevents situations where audio playback fails because the ASIO and WDM drivers have mismatched sample rates.

## How It Works

- **Monitoring the Log File**: The script continuously monitors the Antelope Audio log file located at `C:\Users\Public\.AntelopeAudio\discrete8_hybrid_tb3\panels\1.1.6\panel_log.txt`. Check your version of interface and change path according to it. 
- **Detecting Sample Rate Changes**: It looks for changes in the `sync_freq` parameter within the log file.
- **Updating Audio Devices**: When a change is detected, it uses the `SoundVolumeView` utility to update the sample rate of specified Windows audio devices to match the new `sync_freq`.

## Requirements

- **AutoHotkey**: Install from [https://www.autohotkey.com/](https://www.autohotkey.com/). Choose V1
- **SoundVolumeView Utility**: Download from [https://www.nirsoft.net/utils/sound_volume_view.html](https://www.nirsoft.net/utils/sound_volume_view.html) and place it in `C:\IT\!AHK\SoundVolumeView\`.

## Setup Instructions

1. **Download the Script**

   Save the provided `SyncSampleRate.ahk` script to a location of your choice.

2. **Adjust the Log Path (if necessary)**

   Ensure the `LogPath` variable points to the correct log file location for your Antelope Audio device.

   ```autohotkey
   LogPath := "C:\Users\Public\.AntelopeAudio\discrete8_hybrid_tb3\panels\1.1.6\panel_log.txt"
   ```

3. **Update Device Names (if necessary)**

   Modify the `Devices` array to include all the audio devices you wish to synchronize.

   ```autohotkey
   Devices := ["Your Device Name Here\Render", "Another Device\Capture"]
   ```

4. **Ensure SoundVolumeView Path is Correct**

   The script assumes `SoundVolumeView.exe` is located at `C:\IT\!AHK\SoundVolumeView\SoundVolumeView.exe`. Update the `Command` variable in the script if your path is different.

   ```autohotkey
   Command := "Your Path to SoundVolumeView.exe /SetDefaultFormat ..."
   ```

5. **Run the Script**

   Double-click the `SyncSampleRate.ahk` script to start it. You can also set it to run at startup by placing a shortcut in the Windows Startup folder.

## Usage

- **Automatic Synchronization**: The script runs in the background and checks for sample rate changes every second.
- **Debugging**: Uncomment the `MsgBox` lines in the script if you want to see pop-up messages for debugging purposes.

## Troubleshooting

- **Log File Access Issues**: If the script cannot open the log file, check the file path and permissions.
- **Device Not Updating**: Ensure that the device names in the `Devices` array exactly match those recognized by `SoundVolumeView`.
- **SoundVolumeView Errors**: Verify that `SoundVolumeView.exe` is accessible and not blocked by antivirus software.

## Contributing

If you have suggestions or improvements, feel free to fork the repository and submit a pull request.

## License

This project is licensed under the MIT License.
