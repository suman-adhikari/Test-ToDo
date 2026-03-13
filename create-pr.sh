#!/bin/bash

# ACT-36721 Pull Request Creation Script
# Usage: GITHUB_TOKEN=your_token ./create-pr.sh

REPO_OWNER="suman-adhikari"
REPO_NAME="Test-ToDo"
BRANCH="ACT-36721"
BASE_BRANCH="main"

PR_TITLE="ACT-36721: Add game mode selector and state management for Tic-Tac-Toe"
PR_BODY="## Summary
This PR implements ACT-36721 - Add game mode selector and state management for Tic-Tac-Toe game.

## Changes
- Added radio button UI for game mode selection (Single Game vs Best of 3)
- Implemented centralized state management object (\`gameState\`)
- Added series score tracking with visual scoreboard
- Mode switching includes confirmation dialog to prevent accidental resets
- Dynamic UI updates based on selected mode
- Proper reset logic for both individual games and full series

## Files Modified
- \`tic-tac-toe.html\` - Added game mode selector, state management, and Best of 3 functionality
- \`test-tictactoe.md\` - Test documentation and results

## Testing
All test cases passed:
- ✅ Radio button UI displays correctly
- ✅ Mode selection persists during gameplay
- ✅ State management handles mode switching
- ✅ Clean integration with existing game logic

## Technical Details
- Pure vanilla JavaScript, HTML, CSS (no frameworks)
- Clean separation of concerns
- Responsive design maintained
- No breaking changes to existing functionality

## Jira Ticket
https://zerotheft.atlassian.net/browse/ACT-36721

## Acceptance Criteria
All acceptance criteria met:
- [x] Radio button UI displays correctly
- [x] Mode selection persists during gameplay
- [x] State management handles mode switching
- [x] Clean integration with existing game logic"

if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN environment variable is not set"
    echo ""
    echo "To create the PR manually, visit:"
    echo "https://github.com/${REPO_OWNER}/${REPO_NAME}/pull/new/${BRANCH}"
    echo ""
    echo "Or set your GitHub token and run this script:"
    echo "GITHUB_TOKEN=your_token ./create-pr.sh"
    exit 1
fi

# Create PR using GitHub API
response=$(curl -s -X POST \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/pulls \
    -d "{\"title\":\"${PR_TITLE}\",\"head\":\"${BRANCH}\",\"base\":\"${BASE_BRANCH}\",\"body\":$(echo "$PR_BODY" | jq -Rs .)}")

# Check if PR was created successfully
if echo "$response" | grep -q '"number"'; then
    pr_number=$(echo "$response" | grep -o '"number": [0-9]*' | head -1 | grep -o '[0-9]*')
    pr_url=$(echo "$response" | grep -o '"html_url": "[^"]*"' | head -1 | cut -d'"' -f4)
    echo "✅ Pull Request created successfully!"
    echo "PR Number: #${pr_number}"
    echo "PR URL: ${pr_url}"
else
    echo "❌ Failed to create PR"
    echo "Response: $response"
    echo ""
    echo "You can create the PR manually at:"
    echo "https://github.com/${REPO_OWNER}/${REPO_NAME}/pull/new/${BRANCH}"
fi
