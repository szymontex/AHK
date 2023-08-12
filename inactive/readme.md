# README.md

## Overview

This script is designed to monitor the activity of a machine and send a webhook notification based on the machine's state (active or inactive). The script checks the machine's activity every 3 seconds and sends a webhook notification when the machine has been inactive for more than 60 seconds.

## Setup

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

## How It Works

1. The script reads a variable from a specified text file.
2. It then continuously checks the machine's physical idle time.
3. If the machine has been inactive for more than 60 seconds, it sends a webhook notification indicating that the machine is inactive.
4. When the machine becomes active again, it sends another webhook notification indicating that the machine is active.

## Why Use This Script?

This script is useful for scenarios where you want to monitor the activity of a machine and take actions based on its state. For example, you might want to turn off certain services or applications when the machine is inactive to save resources.

## Notes

- Ensure that the specified text file exists and contains the variable you want to send in the webhook.
- Make sure your webhook endpoint is set up to handle GET requests and can process the data sent by this script.
