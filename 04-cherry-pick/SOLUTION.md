# Solution — 04 Cherry-pick

```bash
git log --oneline develop
# find the hash of "fix: reject requests without a token (security)"
# e.g.: c3d4e5f

git switch release/v1.0
git cherry-pick c3d4e5f

git log --oneline release/v1.0
ls   # auth.py should not be here
```

If there were a conflict:
```bash
# resolve conflicts in the flagged files
git add <resolved-files>
git cherry-pick --continue
```

## Why this is "senior"

- `cherry-pick` is the right tool when you need **one** specific commit
  from another branch without bringing in all the history behind it —
  typical for security hotfixes, backports to old release branches, or
  bringing a one-off fix to another team's branch.
- It's different from a `merge` (which brings *all* the diverging
  history) and a `rebase` (which moves an entire branch). `cherry-pick`
  is surgical: one commit, one new commit.
- Something to keep in mind: if later on you `merge` `develop` into
  `release/v1.0` (or vice versa), Git usually detects that the content
  is already applied and shouldn't duplicate the change — but in more
  complex histories this can produce "phantom" conflicts. That's why
  cherry-pick is used sparingly, for one-off cases like this, not as a
  regular integration strategy between branches.
