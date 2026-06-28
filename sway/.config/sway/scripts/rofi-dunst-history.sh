#!/usr/bin/env bash

# 1. Grab raw history data out of Dunst
RAW_DATA=$(dunstctl history)

# 2. Extract fields cleanly, matching modern Dunst JSON structure
FORMATTED_LIST=$(echo "$RAW_DATA" | jq -r '.data[] | "[\(.id.data)] \(.appname.data): \(.body.data)"' 2>/dev/null)

# 3. Fallback: If your Dunst version uses alternative data wrappers
if [ -z "$FORMATTED_LIST" ] || [ "$FORMATTED_LIST" = "[]" ]; then
    FORMATTED_LIST=$(echo "$RAW_DATA" | jq -r '.data[0][] | "[\(.id.data)] \(.appname.data): \(.body.data)"' 2>/dev/null)
fi

# 4. If it's still completely blank, alert the desktop safely
if [ -z "$FORMATTED_LIST" ] || [[ "$FORMATTED_LIST" == *"null"* ]]; then
    # Final legacy fallback query format
    FORMATTED_LIST=$(echo "$RAW_DATA" | jq -r '.data[] | "[\(.id.data)] \(.summary.data): \(.body.data)"' 2>/dev/null)
fi

# 5. Filter out empty lines or broken null fields from reaching Rofi
CLEAN_LIST=$(echo "$FORMATTED_LIST" | grep -v "null" | sed '/^[[:space:]]*$/d')

# 6. If the list is empty, notify instead of opening a blank launcher
if [ -z "$CLEAN_LIST" ]; then
    notify-send -a "History Tracker" "No Alerts Logged" "Dunst background cache is currently empty." -t 2000
    exit 0
fi

# 7. Open Rofi selection panel
CHOSEN=$(echo "$CLEAN_LIST" | rofi -dmenu -p "Notification History" -i)

# 8. If an item is clicked, strip the ID brackets and trigger the pop event
if [ -n "$CHOSEN" ]; then
    ID=$(echo "$CHOSEN" | awk -F'[][]' '{print $2}')
    if [[ "$ID" =~ ^[0-9]+$ ]]; then
        dunstctl history-pop "$ID"
    fi
fi

