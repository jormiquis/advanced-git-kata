# 02 — Squash with interactive rebase

## Scenario

You worked on the `feature/login` branch across several sessions and
your history ended up full of progress commits with no value on their
own: `wip`, `fix typo`, `asdf`... You're about to open a Pull Request
and you want the reviewer to see a clean story, not your raw thought
process.

Run `setup.sh` and look at the result of:

```
git log --oneline main..feature/login
```

You'll see something like this (hashes will differ):

```
a1b2c3d asdf
e4f5g6h wip logout
i7j8k9l fix typo
m1n2o3p wip login validation
q4r5s6t wip
```

## Goal

Using `git rebase -i main` (while on `feature/login`), reduce those 5
commits down to **2 atomic, well-named commits**:

1. One implementing the login (validation + `login` function)
2. One implementing `logout`

The final `TODO` commit doesn't add anything — drop it or fold it in
wherever it makes sense (you can discard its content if it's trivial,
or include it in the login commit if it adds real context).

## Constraints

- No commit should be left with the message `wip`, `fix typo`, or
  `asdf` in the final history.
- `main` isn't touched — you only rewrite `feature/login`.
- Final messages must follow the `type: description` format.

## Verification

```
git log --oneline main..feature/login
```
Should show exactly 2 commits, with clear messages.
