#!/usr/bin/env bash
set -euo pipefail

LOGFILE="$HOME/scripts/timer_log.txt"

while true; do
    # Run 5-minute countdown
    termdown 300

    # Start beeping in the background
    (
        while true; do
            play -nq -t alsa synth 0.15 sine 880
            sleep 0.2
        done
    ) &
    BEEP_PID=$!

    # Ask what you were doing
    echo -n "⏳ 5 min up! What were you doing? "
    read ACTIVITY

    # Stop the beeping
    kill $BEEP_PID

    # Log the activity with timestamp
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $ACTIVITY" >> "$LOGFILE"
    echo "✔ Logged: $ACTIVITY"
done

