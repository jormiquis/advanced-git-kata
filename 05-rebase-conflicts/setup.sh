#!/usr/bin/env bash
set -e
rm -rf repo
mkdir repo
cd repo
git init -q -b main
git config user.email "you@example.com"
git config user.name "Your Name"

cat > config.py <<'EOF'
DEBUG = False
MAX_CONNECTIONS = 10
TIMEOUT_SECONDS = 30
EOF
git add . && git commit -q -m "chore: initial commit"

git checkout -q -b feature/tuning

cat > config.py <<'EOF'
DEBUG = False
MAX_CONNECTIONS = 50
TIMEOUT_SECONDS = 30
EOF
git add . && git commit -q -m "feat: increase MAX_CONNECTIONS to 50"

cat > config.py <<'EOF'
DEBUG = False
MAX_CONNECTIONS = 50
TIMEOUT_SECONDS = 60
RETRY_ATTEMPTS = 3
EOF
git add . && git commit -q -m "feat: increase timeout and add retries"

git checkout -q main

cat > config.py <<'EOF'
DEBUG = False
MAX_CONNECTIONS = 20
TIMEOUT_SECONDS = 30
EOF
git add . && git commit -q -m "fix: lower MAX_CONNECTIONS to 20 after production incident"

echo "Repo generated at: $(pwd)"
echo ""
echo "main:"
git log --oneline main
echo ""
echo "feature/tuning:"
git log --oneline feature/tuning
echo ""
echo "You're on the main branch. For the exercise, switch to feature/tuning"
echo "and run: git rebase main"
