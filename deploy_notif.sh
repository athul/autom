#!/bin/sh

# Get the token from Travis environment vars and build the bot URL:
BOT_URL="https://api.telegram.org/bot${INPUT_TOKEN}/sendMessage"

# Set formatting for the message. Can be either "Markdown" or "HTML"
PARSE_MODE="Markdown"

status=$INPUT_STATUS
# Define send message function. parse_mode can be changed to
# HTML, depending on how you want to format your message:

# Send message to the bot with some pertinent details about the job
# Note that for Markdown, you need to escape any backtick (inline-code)
# characters, since they're reserved in bash

send_msg"
The DEPLOY Action was **${status}**

The ${GITHUB_REF} is now deployed by ${GITHUB_ACTOR} 

[Build log here]("https://github.com/${GITHUB_REPOSITORY}/commit/${GITHUB_SHA}/checks")
"
send_msg() {
    curl -s -X POST ${BOT_URL} -d chat_id=$INPUT_CHAT \
        -d text="$1" -d parse_mode=${PARSE_MODE}
}
