#!/usr/bin/env python3
import os
import sys
import urllib.parse
import urllib.request


def main():
    token = os.environ.get("TELEGRAM_BOT_TOKEN")
    chat_id = os.environ.get("TELEGRAM_CHAT_ID")

    if not token:
        print(
            "Error: TELEGRAM_BOT_TOKEN environment variable is not set. Might need to export it",
        )
        sys.exit(1)

    if not chat_id:
        print("Error: TELEGRAM_CHAT_ID is not set. Might need to export it.")
        sys.exit(1)

    if len(sys.argv) < 2:
        print('Usage: tg "Your message here"')
        sys.exit(1)

    message = sys.argv[1]

    url = f"https://api.telegram.org/bot{token}/sendMessage"
    data = urllib.parse.urlencode({"chat_id": chat_id, "text": message}).encode("utf-8")

    try:
        req = urllib.request.Request(url, data=data, method="POST")
        with urllib.request.urlopen(req) as response:
            if response.status == 200:
                print("Telegram message sent!")
            else:
                print(f"Failed to send message: HTTP {response.status}")
                sys.exit(1)
    except Exception as e:
        print(f"Error sending message: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
