# Solution — 03 Fixup and autosquash

```bash
# 1. Find the hash of "feat: add User class"
git log --oneline
# e.g.: c3d4e5f feat: add User class

# 2. Fix the bug
cat > user.py <<'EOF'
class User:
    def __init__(self, name, email):
        if "@" not in email:
            raise ValueError("invalid email")
        self.name = name
        self.email = email
EOF

git add user.py

# 3. Fixup commit pointing at the original commit
git commit --fixup c3d4e5f

# 4. Interactive rebase with autosquash from before that commit
git rebase -i --autosquash c3d4e5f~1
# the editor already has the correct plan: just save and close
```

Result — `git log --oneline` still shows 4 commits, and
`git show <hash-of-User>` now includes the validation.

## Why this is "senior"

- `--fixup` + `--autosquash` is the standard flow for "fix an earlier
  commit without having to hand-edit the rebase plan and without
  risking folding the wrong hunk".
- It keeps the history as if the bug **had never existed** at that
  point — which is exactly true, since the commit never left your
  machine. This is only correct while the commit stays **local /
  unshared**; if it were already on a remote branch other people use,
  a plain `fix` commit would be the right call instead (see exercise
  08, revert vs reset).
- It's much safer than hand-editing the rebase plan line by line when
  you have many commits: less chance of moving the `fixup!` to the
  wrong spot.
