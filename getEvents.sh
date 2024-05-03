ics_url="your_url"

# Get today's date in YYYYMMDD format
today=$(date +%Y%m%d)

# Use curl to fetch the ICS data and process it
curl -s "$ics_url" | awk -v date="$today" '
BEGIN {
    inEvent = 0;
    matched = 0;
}
/BEGIN:VEVENT/ {
    inEvent = 1;
    matched = 0;  # Reset the matched flag at the beginning of a new event
    start = "";  # Reset variables at the start of a new event
    end = "";
    summary = "";
}
/END:VEVENT/ {
    if (matched) {
        # Extract hour and minute from start and end variables

	timeshift="2"

        start1 = substr(start, 10, 2);
        start2 = substr(start, 12, 2);
	start1= start1+timeshift;
 
        end1 = substr(end, 10, 2);
        end2 = substr(end, 12, 2);
	end1= end1+timeshift;


        # Output the data in the specified order
        print "Termin: " summary;
        print "Beginn: " start1 ":" start2;
        print "Ende: " end1 ":" end2;
        print "";  # Print an empty line to separate events 
    }
    inEvent = 0;
}
/^DTSTART:/ {
    if (index($0, date) > 0) {
        matched = 1;
    }
    # Store the start time without the label
    sub(/^DTSTART:/, "", $0);
    if (matched) {
        start = $0;
    }
}
/^DTEND:/ {
    # Store the end time without the label
    sub(/^DTEND:/, "", $0);
    if (matched) {
        end = $0;
    }
}
/^SUMMARY:/ {
    # Store the summary without the label
    sub(/^SUMMARY:/, "", $0);
    if (matched) {
        summary = $0;
    }
}'
