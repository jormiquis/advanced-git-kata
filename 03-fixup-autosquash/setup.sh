#!/usr/bin/env bash
set -e
rm -rf repo
mkdir repo
cd repo
git init -q -b main
git config user.email "you@example.com"
git config user.name "Your Name"

cat > utils.py <<'EOF'
def slugify(text):
    return text.lower().replace(" ", "-")
EOF
git add . && git commit -q -m "chore: initial commit"

cat > formatting.py <<'EOF'
def truncate(text, length):
    return text[:length]
EOF
git add . && git commit -q -m "feat: add formatting.py with truncate()"

cat > user.py <<'EOF'
class User:
    def __init__(self, name, email):
        self.name = name
        self.email = email
EOF
git add . && git commit -q -m "feat: add User class"

cat > order.py <<'EOF'
class Order:
    def __init__(self, items):
        self.items = items

    def total(self):
        return sum(i["price"] for i in self.items)
EOF
git add . && git commit -q -m "feat: add Order class with total calculation"

echo "Repo generated at: $(pwd)"
echo ""
echo "git log --oneline:"
git log --oneline
echo ""
echo "You currently have a pending bug to fix: the User class"
echo "(commit 'feat: add User class') doesn't validate that the email has an '@'."
echo "The goal is to fold that fix INTO that commit using"
echo "commit --fixup + rebase --autosquash, without manually touching"
echo "the later commits."
