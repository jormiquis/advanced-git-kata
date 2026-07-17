# Solution — 07 git bisect

```bash
# hash of the first commit
FIRST=$(git log --oneline | tail -1 | awk '{print $1}')

cat > check.sh <<'EOF'
#!/usr/bin/env bash
python3 -c "from math_utils import is_prime; assert is_prime(9) is False; assert is_prime(4) is False"
EOF
chmod +x check.sh

git bisect start
git bisect bad HEAD
git bisect good "$FIRST"
git bisect run ./check.sh
```

Expected output (summary): Git shows you
`<hash> is the first bad commit`, with the message `perf: optimize
is_prime by limiting the check range`.

```bash
git show <that-hash>
git bisect reset
rm check.sh   # optional, it was only for the bisect
```

The diff shows the change from:
```python
for i in range(2, n):
```
to:
```python
for i in range(2, int(n ** 0.5)):
```
which is mathematically wrong: to check primality you need
`range(2, int(n ** 0.5) + 1)` (the `+1` is critical — without it,
numbers like 4 or 9, whose square root is exact, never get checked
against their own divisor).

## Why this is "senior"

- `git bisect` turns a search that would be O(n), going commit by
  commit, into a binary search O(log n) — with 1000 commits, that's
  about 10 steps instead of up to 1000.
- `git bisect run` automates the "check and say good/bad" step,
  removing the human error of saying "good" when you actually meant
  "bad" midway through a long session.
- This only works well if the history has **atomic commits that build
  and pass tests in isolation** — another good reason for everything
  practiced in exercises 01, 02, and 03: a messy history full of
  commits that can't be run in isolation makes `bisect` much less
  reliable (or downright unusable in stretches where the build is
  intentionally broken).
