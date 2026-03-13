#!/bin/bash

# Player Naming Feature Pull Request Creation Script
# Usage: GITHUB_TOKEN=your_token ./create-player-naming-pr.sh

REPO_OWNER="suman-adhikari"
REPO_NAME="Test-ToDo"
BRANCH="feature/player-naming-scoreboard"
BASE_BRANCH="main"

PR_TITLE="Feature: Player Naming & Enhanced Scoreboard for Tic-Tac-Toe"
PR_BODY="## Summary
This PR implements a player naming feature and enhanced scoreboard for the Tic-Tac-Toe game, allowing players to personalize their gaming experience.

## Changes
### Player Naming
- Added player setup screen with input fields for Player 1 (X) and Player 2 (O) names
- Players can enter custom names (up to 20 characters) before starting the game
- Defaults to 'Player X' and 'Player O' if no names entered
- Player names stored in game state and persist throughout the session

### Enhanced Scoreboard
- Scoreboard now always visible (not just Best of 3 mode)
- Displays player names alongside scores
- Clean, color-coded design (blue for X, purple for O)

### Improved User Experience
- All status messages use player names instead of generic X/O
- Win messages personalized with player names (e.g., 'Alice Wins! 🎉')
- 'Back to Setup' button allows changing player names mid-session
- Confirmation dialog prevents accidental progress loss

## Files Modified
- **tic-tac-toe.html** - Main implementation with player naming feature

## Files Created
- **test-player-naming.html** - Comprehensive automated test suite
- **test-runner.md** - Test documentation and manual test checklist

## Testing
Automated test suite includes 12 tests covering:
- ✅ Player setup UI components
- ✅ Input validation and constraints
- ✅ Custom name entry and storage
- ✅ Default name fallback behavior
- ✅ Scoreboard display with names
- ✅ Status message personalization
- ✅ Win tracking with player names
- ✅ Navigation and state management

## Technical Details
- Pure vanilla JavaScript, HTML, CSS (no dependencies)
- Backwards compatible - existing functionality preserved
- Responsive design maintained across all screen sizes
- Clean state management with \`playerNames\` object
- Proper input sanitization (maxlength, trim)

## User Flow
1. Players enter their names on the setup screen
2. Click 'Start Game' to begin
3. Play with personalized messages and scoreboard
4. Can change names anytime via 'Back to Setup' button

## Acceptance Criteria
All requirements met:
- [x] Add input fields for player names
- [x] Display scores alongside player names
- [x] Track scoreboard with player names
- [x] Update all messages to use player names
- [x] Write comprehensive tests
- [x] Maintain backwards compatibility"

if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN environment variable is not set"
    echo ""
    echo "To create the PR manually, visit:"
    echo "https://github.com/${REPO_OWNER}/${REPO_NAME}/pull/new/${BRANCH}"
    echo ""
    echo "Or set your GitHub token and run this script:"
    echo "GITHUB_TOKEN=your_token ./create-player-naming-pr.sh"
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
