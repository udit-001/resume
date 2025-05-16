# Resume

My resume created using Typst and the [basic-typst-resume-template](https://github.com/stuxf/basic-typst-resume-template).

## Technical Details

This resume is created using:
- [Typst](https://typst.app/) for typesetting
- Based on the [basic-typst-resume-template](https://github.com/stuxf/basic-typst-resume-template) (version 0.2.4)
- Using version 0.2.4 of the template as the preview functionality doesn't work in newer versions

## GitHub Secrets

To use the GitHub Actions workflow for generating and releasing resumes, you need to set up the following secrets in your repository:

1. `RESUME_EMAILS`: Comma-separated list of email addresses to generate resumes for
2. `PHONE`: Phone number to include in the resume (optional)
3. `TELEGRAM_BOT_TOKEN`: Your Telegram bot token (required if sending to Telegram)
4. `TELEGRAM_CHAT_ID`: Your Telegram chat ID (required if sending to Telegram)

To add these secrets:
1. Go to your repository settings
2. Navigate to "Secrets and variables" → "Actions"
3. Click "New repository variable"
4. Add each secret with its corresponding value

## Setup

1. Install Typst:
   ```bash
   # For Linux/macOS
   curl -fsSL https://typst.app/install.sh | sh
   ```

2. Install VSCode:
   - Download from [Visual Studio Code](https://code.visualstudio.com/)
   - Install the [TinyMist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) extension for Typst support in VSCode

## Resume Generation Script

The project includes a bash script (`scripts/generate_resumes.sh`) that helps generate and distribute resumes with custom email addresses and optional phone numbers. The script can also send the generated resumes via Telegram.

### Usage

```bash
./scripts/generate_resumes.sh [-t] [-e "email1@domain.com,email2@domain.com"] [-p ["1234567890"]] [-b "bot_token"] [-c "chat_id"]
```

### Options

- `-t`: Enable Telegram sending
- `-e`: Comma-separated list of email addresses (optional)
- `-p`: Phone number (optional, can be empty)
- `-b`: Telegram bot token (optional if TELEGRAM_BOT_TOKEN env var is set)
- `-c`: Telegram chat ID (optional if TELEGRAM_CHAT_ID env var is set)

### Environment Variables

You can set the following environment variables instead of using command-line arguments:
- `TELEGRAM_BOT_TOKEN`: Your Telegram bot token
- `TELEGRAM_CHAT_ID`: Your Telegram chat ID

### Examples

1. Generate a single resume without email:
   ```bash
   ./scripts/generate_resumes.sh
   ```

2. Generate resumes for multiple email addresses:
   ```bash
   ./scripts/generate_resumes.sh -e "john@example.com,jane@example.com"
   ```

3. Generate resume with phone number:
   ```bash
   ./scripts/generate_resumes.sh -p "1234567890"
   ```

4. Generate and send via Telegram:
   ```bash
   ./scripts/generate_resumes.sh -t -e "john@example.com" -b "your_bot_token" -c "your_chat_id"
   ```

The script will generate PDF files in the `dist/` directory:
- For email-specific resumes: `dist/resume_username.pdf`
- For the default resume: `dist/resume.pdf`

When Telegram sending is enabled, it will send the generated files with a caption including the generation date.