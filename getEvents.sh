# Define the ICS URL of your calendar
ics_url="your_url"

# Get today's date in YYYYMMDD format
today=$(date +%Y%m%d)

# Use curl to fetch the ICS data and process it
curl -s "$ics_url" | awk -v date="$today" '
BEGIN {
    inEvent = 0;
    matched = 0;
    eventBuffer = "";
}
/BEGIN:VEVENT/ {
    inEvent = 1;
    matched = 0;
    eventBuffer = "";  # Reset event buffer at the beginning of a new event
}
/END:VEVENT/ {
    if (matched) {
        print eventBuffer;  # Print the event buffer if matched
        print "";  # Print an empty line after each event
    }
    inEvent = 0;
}
/DTSTART/ {
    eventBuffer = $0;
    if (index($0, date) > 0) {
        matched = 1;
    }
}
/SUMMARY|DESCRIPTION|DTEND/ {
    eventBuffer = eventBuffer "\n" $0;
}
' 
