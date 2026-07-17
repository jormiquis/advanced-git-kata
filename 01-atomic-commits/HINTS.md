# Hints — 01 Atomic commits

**Hint 1**
`calculator.py` has two new code blocks appended at the end:
`divide()` (bugfix) and `power()` (feature). They're in the same file
but are separate, contiguous blocks of code, not interleaved lines.

**Hint 2**
`git add -p calculator.py` walks you through each "hunk" (block of
changes) and asks `y/n/s/...`. If a hunk mixed both things together,
`s` (split) tries to break it into smaller pieces.

**Hint 3**
Suggested order of commands for the first commit:
```
git add -p calculator.py   # select only the divide() block
git add test_calculator.py
git commit -m "fix: handle division by zero in divide()"
```

**Hint 4**
For the second commit, whatever's left unstaged in `calculator.py`
should be exactly the `power()` block:
```
git add calculator.py
git commit -m "feat: add power() function"
```

**Hint 5**
The README is independent and unrelated to the code:
```
git add README.md
git commit -m "docs: document available functions in the README"
```
