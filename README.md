# Resume

My resume created using Typst and the [basic-typst-resume-template](https://github.com/stuxf/basic-typst-resume-template).

## 🚀 Getting Started

1. Install Typst:
   ```bash
   # For Linux/macOS
   curl -fsSL https://typst.app/install.sh | sh
   ```

2. Install VSCode:
   - Download from [Visual Studio Code](https://code.visualstudio.com/)
   - Install the [TinyMist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) extension for Typst support in VSCode

## 🛠️ Tech Stack

This resume is created using:
- [Typst](https://typst.app/) for typesetting
- Based on the [basic-typst-resume-template](https://github.com/stuxf/basic-typst-resume-template) (version 0.2.4)
- Using version 0.2.4 of the template as the preview functionality doesn't work in newer versions

## 📝 Resume Generation

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

## 🤖 GitHub Actions & Automation

### Setup
Add these variables in repo settings (Settings → Variables → Actions):
- `RESUME_EMAILS`: Comma-separated email list (optional)
- `PHONE`: Phone number (optional)
- `TELEGRAM_BOT_TOKEN`: Bot token (required for Telegram)
- `TELEGRAM_CHAT_ID`: Chat ID (required for Telegram)

### Workflows

#### 1. Auto-Build
- Triggers on `src/main.typ` changes
- Generates PDFs as artifacts (30-day retention)

#### 2. Manual Release
- Trigger from Actions tab
- Options: Telegram, phone, custom email
- Creates dated release (YYYY.MM.DD)
- PDFs available as artifacts and release assets