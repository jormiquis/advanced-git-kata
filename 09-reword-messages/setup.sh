#!/usr/bin/env bash
set -e
rm -rf repo
mkdir repo
cd repo
git init -q -b main
git config user.email "you@example.com"
git config user.name "Your Name"

echo "v1" > payments.py
git add . && git commit -q -m "chore: initial commit"

echo "def process_payment(amount): return amount * 1.0" > payments.py
git add . && git commit -q -m "changes"

echo "def process_payment(amount, currency='USD'): return amount * 1.0" > payments.py
git add . && git commit -q -m "various fixes"

cat > payments.py <<'EOF'
def process_payment(amount, currency="USD"):
    return amount * 1.0

def refund(amount, currency="USD"):
    return -amount
EOF
git add . && git commit -q -m "more stuff"

echo "Repo generated at: $(pwd)"
echo ""
git log --oneline
echo ""
echo "These last 3 commits (not counting the initial one) have messages that"
echo "say nothing: 'changes', 'various fixes', 'more stuff'. None of them have"
echo "been pushed. Your task: rewrite their messages with 'git rebase -i'"
echo "and the 'reword' action, WITHOUT changing the content of any commit."
