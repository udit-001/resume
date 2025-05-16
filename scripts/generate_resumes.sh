#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Get the project root directory (one level up from scripts)
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

# Create dist directory if it doesn't exist
mkdir -p "$PROJECT_ROOT/dist"

# Default values
SEND_TELEGRAM=false
EMAILS=""
PHONE=""
INCLUDE_PHONE=false
TELEGRAM_BOT_TOKEN="${TELEGRAM_BOT_TOKEN:-}"
TELEGRAM_CHAT_ID="${TELEGRAM_CHAT_ID:-}"

# Parse command line arguments
while getopts "te:p:b:c:" opt; do
    case $opt in
        t)
            SEND_TELEGRAM=true
            ;;
        e)
            EMAILS="$OPTARG"
            ;;
        p)
            INCLUDE_PHONE=true
            if [ -n "$OPTARG" ]; then
                PHONE="$OPTARG"
            fi
            ;;
        b)
            TELEGRAM_BOT_TOKEN="$OPTARG"
            ;;
        c)
            TELEGRAM_CHAT_ID="$OPTARG"
            ;;
        :)
            case $OPTARG in
                p)
                    INCLUDE_PHONE=true
                    ;;
                b|c)
                    echo "Option -$OPTARG requires an argument" >&2
                    exit 1
                    ;;
                *)
                    echo "Option -$OPTARG requires an argument" >&2
                    exit 1
                    ;;
            esac
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            echo "Usage: $0 [-t] [-e \"email1@domain.com,email2@domain.com\"] [-p [\"1234567890\"]] [-b \"bot_token\"] [-c \"chat_id\"]"
            echo "  -t: Enable Telegram sending"
            echo "  -e: Comma-separated list of email addresses (optional)"
            echo "  -p: Phone number (optional, can be empty)"
            echo "  -b: Telegram bot token (optional if TELEGRAM_BOT_TOKEN env var is set)"
            echo "  -c: Telegram chat ID (optional if TELEGRAM_CHAT_ID env var is set)"
            exit 1
            ;;
    esac
done

# Function to send file via Telegram
send_telegram_file() {
    local file_path="$1"
    local caption="$2"

    if [ "$SEND_TELEGRAM" = false ]; then
        echo "Telegram sending is disabled"
        return
    fi

    if [ -z "$TELEGRAM_BOT_TOKEN" ] || [ -z "$TELEGRAM_CHAT_ID" ]; then
        echo "Error: Telegram bot token and chat ID are required when -t is used"
        echo "You can provide them either through environment variables (TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID)"
        echo "or through command-line arguments (-b, -c)"
        exit 1
    fi

    # Get current date in YYYY-MM-DD format
    current_date=$(date +"%Y-%m-%d")

    curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendDocument" \
        -F "chat_id=${TELEGRAM_CHAT_ID}" \
        -F "document=@${file_path}" \
        -F "caption=${caption} (Generated on ${current_date})"
}

# Change to project root directory
cd "$PROJECT_ROOT"

if [ -n "$EMAILS" ]; then
    # Read email addresses into array
    IFS=',' read -ra EMAIL_ARRAY <<< "$EMAILS"

    # Generate and send each version
    for email in "${EMAIL_ARRAY[@]}"; do
        email=$(echo "$email" | xargs)  # Trim whitespace
        # Extract username from email for filename
        username=$(echo "$email" | cut -d@ -f1)
        output_file="dist/resume_${username}.pdf"

        echo "Generating resume for ${email}..."
        # Build typst command
        TYPST_CMD=(typst compile src/main.typ "$output_file" --input "email=${email}")
        if [ "$INCLUDE_PHONE" = true ]; then
            TYPST_CMD+=(--input "phone=${PHONE}")
        fi
        # Run typst command
        "${TYPST_CMD[@]}"

        if [ $? -eq 0 ]; then
            echo "Successfully generated ${output_file}"
            # Send the file if Telegram sending is enabled
            send_telegram_file "$output_file" "Resume"
        else
            echo "Failed to generate ${output_file}"
        fi
    done
else
    # Generate a single version without email
    output_file="dist/resume.pdf"
    echo "Generating resume without email..."
    # Build typst command
    TYPST_CMD=(typst compile src/main.typ "$output_file")
    if [ "$INCLUDE_PHONE" = true ]; then
        TYPST_CMD+=(--input "phone=${PHONE}")
    fi
    # Run typst command
    "${TYPST_CMD[@]}"

    if [ $? -eq 0 ]; then
        echo "Successfully generated ${output_file}"
        # Send the file if Telegram sending is enabled
        send_telegram_file "$output_file" "Resume"
    else
        echo "Failed to generate ${output_file}"
    fi
fi