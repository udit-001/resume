#!/usr/bin/env python3

import os
import sys
import argparse
import subprocess
from pathlib import Path
from datetime import datetime
import requests
import logging
from typing import Optional


logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)
logger = logging.getLogger(__name__)

def get_project_root() -> Path:
    """Get the project root directory."""
    script_dir = Path(__file__).parent
    return script_dir.parent

def send_telegram_file(
    file_path: str,
    caption: str,
    bot_token: str,
    chat_id: str,
    custom_filename: Optional[str] = None,
    username: Optional[str] = None
) -> None:
    """Send a file via Telegram."""
    if not bot_token or not chat_id:
        error_msg = (
            "Telegram bot token and chat ID are required when -t is used\n"
            "You can provide them either through environment variables (TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID)\n"
            "or through command-line arguments (-b, -c)"
        )
        logger.error(error_msg)
        sys.exit(1)

    current_date = datetime.now().strftime("%Y-%m-%d")
    url = f"https://api.telegram.org/bot{bot_token}/sendDocument"
    
    with open(file_path, 'rb') as file:
        files = {'document': file}
        data = {
            'chat_id': chat_id,
            'caption': f"{caption} (Generated on {current_date})"
        }

        if custom_filename:
            filename = (
                f"{custom_filename} ({username.title()}).pdf"
                if username else f"{custom_filename}.pdf"
            )
            files['document'] = (filename, file)

        response = requests.post(url, files=files, data=data)
        if not response.ok:
            logger.error(f"Failed to send file via Telegram: {response.text}")

def generate_resume(
    output_file: str,
    email: Optional[str] = None,
    phone: Optional[str] = None
) -> bool:
    """Generate a resume using typst."""
    cmd = [
        "typst",
        "compile",
        "src/main.typ",
        output_file
    ]
    
    if email:
        cmd.extend(["--input", f"email={email}"])
    if phone:
        cmd.extend(["--input", f"phone={phone}"])
    
    try:
        subprocess.run(cmd, check=True)
        logger.info(f"Successfully generated {output_file}")
        return True
    except subprocess.CalledProcessError:
        logger.error(f"Failed to generate {output_file}")
        return False

def main():
    parser = argparse.ArgumentParser(description="Generate resumes with optional email and phone number")
    parser.add_argument("-t", "--telegram", action="store_true", help="Enable Telegram sending")
    parser.add_argument("-e", "--emails", help="Comma-separated list of email addresses")
    parser.add_argument("-p", "--phone", nargs="?", const="", help="Phone number (optional)")
    parser.add_argument("-b", "--bot-token", help="Telegram bot token")
    parser.add_argument("-c", "--chat-id", help="Telegram chat ID")
    parser.add_argument("-f", "--tg-filename", help="Custom filename for Telegram messages (without extension)")
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable verbose logging")
    
    args = parser.parse_args()
    
    if args.verbose:
        logger.setLevel(logging.DEBUG)

    config_msg = (
        f"Config: telegram={args.telegram}, "
        f"email={bool(args.emails)}, "
        f"phone={bool(args.phone)}, "
        f"tg_filename={args.tg_filename}, "
        f"log={logging.getLevelName(logger.level)}"
    )
    logger.info(config_msg)
    
    bot_token = args.bot_token or os.getenv("TELEGRAM_BOT_TOKEN")
    chat_id = args.chat_id or os.getenv("TELEGRAM_CHAT_ID")
    
    project_root = get_project_root()
    dist_dir = project_root / "dist"
    dist_dir.mkdir(exist_ok=True)
    
    os.chdir(project_root)
    
    if args.emails:
        emails = [email.strip() for email in args.emails.split(",")]
        for email in emails:
            username = email.split("@")[0]
            output_file = f"dist/resume_{username}.pdf"
            
            logger.info(f"Generating resume for {username}...")
            if generate_resume(output_file, email, args.phone):
                if args.telegram:
                    send_telegram_file(
                        output_file,
                        "Resume",
                        bot_token,
                        chat_id,
                        args.tg_filename,
                        username
                    )
    else:
        output_file = "dist/resume.pdf"
        logger.info("Generating resume without email...")
        if generate_resume(output_file, phone=args.phone):
            if args.telegram:
                send_telegram_file(
                    output_file,
                    "Resume",
                    bot_token,
                    chat_id,
                    args.tg_filename
                )

if __name__ == "__main__":
    main()
