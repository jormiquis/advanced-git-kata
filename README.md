# Git Exercises — Clean History and Advanced Git

A collection of hands-on exercises to build "senior-level" commit habits
and get comfortable with Git's trickier corners: interactive rebase,
cherry-pick, reflog, bisect, revert vs reset, and more.

## How to use this repo

Each numbered folder is a self-contained exercise:

```
NN-exercise-name/
├── STATEMENT.md   ← what you need to achieve
├── setup.sh       ← generates a mini-repo with the scenario already set up
├── HINTS.md       ← progressive hints (only open if you get stuck)
└── SOLUTION.md    ← commands and explanation of the solution
```

Recommended workflow:

1. Enter the exercise folder: `cd 01-atomic-commits`
2. Run `./setup.sh`. This creates a `repo/` subfolder with a Git
   repository already initialized and containing the exercise scenario.
3. Go into `repo/` and solve the exercise following `STATEMENT.md`,
   working with Git as you would on a real project.
4. If you get stuck, check `HINTS.md` (hints that don't spoil the
   solution).
5. Once done (or if you want to compare), check `SOLUTION.md`.
6. You can re-run `./setup.sh` at any point: it deletes `repo/` and
   regenerates it from scratch so you can repeat the exercise as many
   times as you like.

## Requirements

- Git >= 2.30 (for good `git switch`/`git restore` and
  `rebase --autosquash` support)
- Bash (the `setup.sh` scripts are bash; on Windows use Git Bash or WSL)

## Recommended order and what each exercise trains

| # | Exercise | What you practice |
|---|-----------|----------------|
| 01 | Atomic commits | Splitting mixed-up changes into atomic commits with `git add -p` and good messages |
| 02 | Squash with rebase -i | Cleaning up a series of "WIP" commits before opening a PR |
| 03 | Fixup and autosquash | `git commit --fixup` + `rebase -i --autosquash` |
| 04 | Cherry-pick | Bringing one specific commit from one branch to another (e.g. a hotfix) |
| 05 | Rebase conflicts | Resolving conflicts during a rebase, `--continue`/`--abort` |
| 06 | Amend and reflog | Fixing the last commit and recovering "lost" commits |
| 07 | Bisect | Finding the commit that introduced a bug with `git bisect run` |
| 08 | Revert vs reset | When to undo with `revert` (shared history) and when with `reset` (local) |
| 09 | Rewriting messages | `rebase -i` with `reword` to fix old commit messages |
| 10 | Splitting a commit | Splitting a large commit into several atomic ones with `rebase -i edit` |

## The philosophy behind these exercises

A "senior" Git history isn't just about looking nice: it's what makes
`git log`, `git blame`, and `git bisect` useful tools instead of noise.
The criteria these exercises ask for are:

- **Atomicity**: each commit represents one complete, self-contained
  logical change (it builds, passes tests, makes sense on its own).
- **Clear messages**: imperative-mood subject (`Add`, `Fix`,
  `Refactor`), ~50 characters max, optional body explaining *why*, not
  *what*.
- **Readable history**: no `wip`, `fix typo`, `asdf` commits in the
  final branch — clean those up with interactive rebase before sharing
  the work.
- **Don't rewrite shared history**: rebase/amend only on commits that
  haven't been pushed to a branch others use; if it's already public,
  use `revert` instead.

Good luck. Remember: `git reflog` is your safety net — almost nothing
in Git is truly lost as long as you haven't run an aggressive `git gc`
or `git reflog expire`.
