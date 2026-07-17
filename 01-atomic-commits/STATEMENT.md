# 01 — Atomic commits

## Scenario

You've been "vibe coding" on `calculator.py` and you have three unrelated
things mixed together in the working directory, all uncommitted:

1. A **real bugfix**: `divide()` was added with its division-by-zero
   validation, plus a `test_calculator.py` file that tests exactly that.
2. An **unrelated new feature**: the `power()` function.
3. A **documentation change**: `README.md` was rewritten to list the
   available functions.

Everything is uncommitted (`git status` will confirm this).

## Goal

Create **3 atomic commits**, each representing a single logical change,
in this order:

1. The `divide()` bugfix **together with** its test (they belong
   together: a fix without a test covering it isn't complete).
2. The `power()` feature.
3. The `README.md` update.

## Message requirements

Use the [Conventional Commits](https://www.conventionalcommits.org/)
format:

```
<type>: <description in imperative mood, lowercase, no trailing period>
```

Types to use here: `fix`, `feat`, `docs`.

Valid example: `fix: handle division by zero in divide()`

## Commands you'll need

- `git status` / `git diff` to inspect what's uncommitted
- `git add <file>` to stage whole files
- `git add -p <file>` to stage **only parts** of a file (you'll need
  this because `calculator.py` has the bugfix and the feature mixed
  into the same file)

## How to check you got it right

```
git log --oneline
```

Should show (oldest to newest): initial commit → fix → feat → docs.
And each commit, viewed with `git show <hash>`, should contain **only**
the changes that belong to it — no bits of "feat" leaking into "fix".
