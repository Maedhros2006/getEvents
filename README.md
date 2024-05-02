# getEvents
The getEvents script fetches calendar event data from a specified ICS (iCalendar) URL and displays events for the current date. This script can be used as a user command in the obsidian community plugin templater. 
## Usage

1. **Configure the ICS URL:**
   In the script, set the `ics_url` variable to your desired ICS URL:

   ```bash
   ics_url="your_url"
   ```

2. **Execute the script:**
   Run the script using a Bash shell:

   ```bash
   bash getEvents
   ```

3. **View the output:**
   The script fetches the ICS data from the URL, processes it, and displays the events for the current date in a readable format. Each event is followed by an empty line for better separation and readability.

## How It Works

1. **Fetch ICS Data:**
   The script uses `curl` to fetch ICS data from the specified URL.

2. **Process ICS Data:**
   The fetched data is piped to an `awk` script that processes the events:

   - Initializes variables to track whether an event is being processed (`inEvent`) and if it matches today's date (`matched`).
   - Begins processing an event when a `BEGIN:VEVENT` line is found.
   - Checks if the event's `DTSTART` line matches today's date. If a match is found, the event is deemed relevant.
   - Collects relevant data (`DTSTART`, `SUMMARY`, `DESCRIPTION`, and `DTEND`) into an event buffer as the event is processed.
   - Prints the event's information from the buffer when the end of the event (`END:VEVENT`) is reached, followed by an empty line if the event is relevant.

3. **Output:**
   The script outputs matching events for the current date, including their start date, summary, description, and end date. An empty line is printed after each event for easier differentiation.


## Troubleshooting

- Ensure the ICS URL is valid and accessible from your network.
- If you encounter formatting issues or missing data, verify that the ICS data is in the expected format and that the relevant fields are present.
