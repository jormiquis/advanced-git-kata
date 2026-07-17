#!/usr/bin/env bash
set -e
rm -rf repo
mkdir repo
cd repo
git init -q -b main
git config user.email "you@example.com"
git config user.name "Your Name"

echo "console.log('hello');" > app.js
git add .
git commit -q -m "chore: initial commit"

git checkout -q -b feature/login

echo "function login() {}" >> app.js
git add . && git commit -q -m "wip"

echo "function validateUser(u) { return !!u; }" >> app.js
git add . && git commit -q -m "wip login validation"

sed -i "s/function login() {}/function login() { if (!validateUser(arguments[0])) return false; console.log('logging in'); return true; }/" app.js
git add . && git commit -q -m "fix typo"

cat >> app.js <<'EOF'
function logout() {
  console.log('logging out');
}
EOF
git add . && git commit -q -m "wip logout"

echo "// TODO: add tests" >> app.js
git add . && git commit -q -m "asdf"

echo "Repo generated at: $(pwd)"
echo ""
echo "git log --oneline of feature/login:"
git log --oneline main..feature/login
