# Solution — 09 Rewriting messages

```bash
git rebase -i main~3
```

In the editor:
```
reword b2c3d4e changes
reword c3d4e5f various fixes
reword d4e5f6a more stuff
```

Save and close. The editor will open 3 times, once per commit, in
order. In each one, delete the old message and write:

1. `feat: add process_payment with USD amounts`
2. `feat: support currency parameter in process_payment`
3. `feat: add refund function`

```bash
git log --oneline
cat payments.py   # identical to the original
```

## Why this is "senior"

- Commit messages are permanent documentation of the *why* behind a
  change. `git blame` and `git log -p -- file` show them to anyone
  investigating that code 2 years later — messages like "changes" or
  "various fixes" are noise that forces a full diff read every time
  just to understand what happened.
- `reword` is the right tool when the problem is **only** the message:
  it doesn't touch a single line of code, so there's no risk of
  accidentally introducing a functional change while "just" fixing
  text.
- As with previous exercises, this is only acceptable on **local**
  commits. Rewriting the message of a commit already on `origin`
  changes its hash — in practice, you'd instead use `git commit
  --allow-empty -m "..."` explaining the context in a new commit, or
  simply accept the historical message as-is (see exercise 08).
