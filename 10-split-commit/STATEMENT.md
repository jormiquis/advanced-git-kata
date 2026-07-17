# 10 — Splitting a commit into several atomic ones

## Scenario

```
git log --oneline
```
```
b2c3d4e feat: add Product model, get_product endpoint and price formatting helper
a1b2c3d chore: initial commit
```

That single commit `b2c3d4e` mixes 3 new files, each an independent
logical change:

1. `models.py` → `Product` class
2. `api.py` → new `get_product` endpoint
3. `utils.py` → `format_price` helper

It hasn't been pushed. You want the history to reflect 3 atomic commits
instead of one mixed-up one.

## Goal

Using `git rebase -i main~1` with the `edit` action on commit
`b2c3d4e`, temporarily undo that commit (leaving its changes in the
working directory, uncommitted) and recreate it as 3 separate commits:

1. `feat: add Product model`
2. `feat: add get_product endpoint`
3. `feat: add format_price helper`

## Verification

```
git log --oneline
```
Should show 4 commits total (the initial one + the 3 new ones), in a
logical order (for example: Product → the endpoint that uses it →
helper).

`git show <hash>` for each of the 3 new commits should touch **only**
its corresponding file.
