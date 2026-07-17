#!/usr/bin/env bash
set -e
rm -rf repo remote.git
mkdir repo
cd repo
git init -q -b main
git config user.email "you@example.com"
git config user.name "Your Name"

echo "v1" > feature_flags.py
git add . && git commit -q -m "chore: initial commit"

echo "FEATURE_X_ENABLED = False" > feature_flags.py
git add . && git commit -q -m "feat: add flag for feature X"

echo "FEATURE_X_ENABLED = True" > feature_flags.py
git add . && git commit -q -m "feat: enable feature X in production"

# Simulate that this commit has ALREADY been pushed and someone else already pulled it (simulated remote branch)
mkdir -p ../remote.git
git init -q --bare ../remote.git
git remote add origin ../remote.git
git push -q origin main

echo "audit logs" > audit.py
git add . && git commit -q -m "feat: add audit logging"
git push -q origin main

# Now, locally, we keep working and add a commit that has NOT been pushed yet
cat >> feature_flags.py <<'EOF'
FEATURE_Y_ENABLED = False
EOF
git add . && git commit -q -m "feat: add experimental flag for feature Y (not pushed)"

echo "Repo generated at: $(pwd)"
echo ""
echo "Local history (main):"
git log --oneline
echo ""
echo "What's already on the 'origin' remote (equivalent to what your teammates already have):"
git log --oneline origin/main
echo ""
echo "--- SCENARIO ---"
echo "1) 'feat: enable feature X in production' turned out to be a mistake: it enabled"
echo "   the feature too early and caused an incident. IT'S ALREADY ON THE REMOTE"
echo "   (origin/main), i.e. your teammates already have it / it's already deployed."
echo ""
echo "2) 'feat: add experimental flag for feature Y' is a commit you made yourself"
echo "   a moment ago, and you've decided you don't want that feature yet."
echo "   IT HAS NOT BEEN PUSHED."
