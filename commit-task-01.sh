#!/bin/bash
# Script to commit Task 1 implementation (ACT-36313)

set -e  # Exit on any error

echo "=== Task 1 Git Workflow ==="
echo ""

# Create and switch to feature branch
echo "1. Creating feature branch..."
git checkout -b feature/task-01-html-structure-add 2>/dev/null || git checkout feature/task-01-html-structure-add
echo "   ✓ Branch: feature/task-01-html-structure-add"
echo ""

# Stage the files
echo "2. Staging files..."
git add todo-app.html TASK-01-VERIFICATION.md
echo "   ✓ Staged: todo-app.html, TASK-01-VERIFICATION.md"
echo ""

# Check status
echo "3. Git status:"
git status --short
echo ""

# Commit with clear message
echo "4. Creating commit..."
git commit -m "feat(ACT-36313): Implement HTML structure and add task functionality

- Create single-page HTML todo application
- Add form with input field and Add button
- Implement task addition via form submit and Enter key
- Store tasks in-memory as array of {id, text, completed} objects
- Render tasks dynamically with createElement/appendChild
- Validate empty input (trim and prevent empty tasks)
- Use textContent for XSS prevention (not innerHTML)
- Style with centered layout, max-width 600px
- Implement mobile-friendly responsive design

Acceptance criteria: All met ✓
Files: todo-app.html, TASK-01-VERIFICATION.md"

echo "   ✓ Commit created"
echo ""

# Show commit details
echo "5. Commit details:"
git log -1 --stat
echo ""

echo "=== Task 1 Implementation Complete ==="
echo ""
echo "Next steps:"
echo "  - Manual testing: Open todo-app.html in a browser"
echo "  - Review verification checklist: TASK-01-VERIFICATION.md"
echo "  - Ready for QA testing"
