#!/bin/sh

# Get the token from Travis environment vars and build the bot URL:
BOT_URL="https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage"

# Set formatting for the message. Can be either "Markdown" or "HTML"
PARSE_MODE="Markdown"


status=$INPUT_STATUS
stars=$STARGAZERS
# Define send message function. parse_mode can be changed to
# HTML, depending on how you want to format your message:
send_msg () {
    curl -s -X POST ${BOT_URL} -d chat_id=$TELEGRAM_CHAT_ID \
        -d text="$1" -d parse_mode=${PARSE_MODE}
}

# Send message to the bot with some pertinent details about the job
# Note that for Markdown, you need to escape any backtick (inline-code)
# characters, since they're reserved in bash
send_msg "
⭐️⭐️⭐️

*${GITHUB_ACTOR}* starred ${GITHUB_REPOSITORY}

ID: ${GITHUB_WORKFLOW}
Action was a *${status}!*

\`Repository:  ${GITHUB_REPOSITORY}\` 

On:          *${GITHUB_EVENT_NAME}*

By:            *${GITHUB_ACTOR}* 

No of Stars:    ${stars}

[Link to Repo ]("https://github.com/${GITHUB_REPOSITORY}/")

[Link to ${GITHUB_ACTOR}'s Profile]("https://github.com/${GITHUB_ACTOR}/")

[Build log here]("https://github.com/${GITHUB_REPOSITORY}/commit/${GITHUB_SHA}/checks")
-----
"
