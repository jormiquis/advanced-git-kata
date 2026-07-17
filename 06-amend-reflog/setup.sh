#!/usr/bin/env bash
set -e
rm -rf repo
mkdir repo
cd repo
git init -q -b main
git config user.email "you@example.com"
git config user.name "Your Name"

echo "v1" > file.txt
git add . && git commit -q -m "chore: initial commit"

echo "v2" > file.txt
git add . && git commit -q -m "feat: first version of the core logic"

echo "v3" > file.txt
git add . && git commit -q -m "feat: second improvement to the logic"

echo "v4" > file.txt
git add . && git commit -q -m "feat: third improvement, almost ready"

echo "Repo generated at: $(pwd)"
echo ""
git log --oneline
echo ""
echo "PART A: you just realized the LAST commit"
echo "('feat: third improvement, almost ready') has a poor message and"
echo "you also forgot to include a new file. Practice 'git commit --amend'."
echo ""
echo "PART B: once you finish part A, simulate a disaster:"
echo "  git reset --hard HEAD~2"
echo "This will 'lose' 2 commits from the tip of your branch (apparently)."
echo "Your job will be to recover them using 'git reflog'."
