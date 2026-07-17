# 09 — Rewriting past commit messages

## Scenario

```
git log --oneline
```
```
d4e5f6a more stuff
c3d4e5f various fixes
b2c3d4e changes
a1b2c3d chore: initial commit
```

The last 3 commits are yours, local (not pushed), and their messages
say nothing. Looking at their content with `git show <hash>`:

- `changes` → added `process_payment(amount)`
- `various fixes` → added the `currency` parameter to `process_payment`
- `more stuff` → added the `refund` function

## Goal

Using `git rebase -i main` and the `reword` action, change the 3
messages to descriptive Conventional Commits messages, for example:

- `feat: add process_payment with USD amounts`
- `feat: support currency parameter in process_payment`
- `feat: add refund function`

**You must not change a single line of code** — only the messages. The
final content of `payments.py` must be identical to before you started.

## Verification

```
git log --oneline
```
Should show the same 4 commits in the same order, but with descriptive
messages (except `chore: initial commit`, which you don't touch).

The final content of `payments.py` (`cat payments.py`) must be exactly
the same as before starting the exercise (the commit hashes will
change, that's normal: `reword` rewrites the commit even though you
only touch the message).
