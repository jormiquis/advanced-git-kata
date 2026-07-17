#!/usr/bin/env bash
set -e
rm -rf repo
mkdir repo
cd repo
git init -q -b main
git config user.email "you@example.com"
git config user.name "Your Name"

cat > server.py <<'EOF'
def handle_request(req):
    return {"status": 200, "body": "ok"}
EOF
git add . && git commit -q -m "chore: initial commit"

git checkout -q -b release/v1.0

git checkout -q -b develop

cat > auth.py <<'EOF'
def authenticate(token):
    return token == "valid-token"
EOF
git add . && git commit -q -m "feat: add basic authentication"

sed -i 's/{"status": 200, "body": "ok"}/{"status": 200, "body": "ok"} if authenticate(req.get("token")) else {"status": 401, "body": "unauthorized"}/' server.py
git add . && git commit -q -m "feat: protect endpoint with authentication"

# This is the critical commit: security fix that needs to reach release/v1.0 NOW
cat > server.py <<'EOF'
def handle_request(req):
    token = req.get("token")
    if token is None:
        return {"status": 401, "body": "missing token"}
    return {"status": 200, "body": "ok"}
EOF
git add . && git commit -q -m "fix: reject requests without a token (security)"

cat >> auth.py <<'EOF'

def refresh_token(token):
    return token + "-refreshed"
EOF
git add . && git commit -q -m "feat: add token refresh"

echo "Repo generated at: $(pwd)"
echo ""
echo "Branches:"
git branch
echo ""
echo "Log of develop:"
git log --oneline develop
echo ""
echo "Log of release/v1.0:"
git log --oneline release/v1.0
