# Hints — 07 git bisect

**Hint 1**
Start the bisect session:
```
git bisect start
git bisect bad HEAD
git bisect good <hash-of-first-commit>
```
Git will automatically check out the commit "in the middle" of the
range.

**Hint 2 — manual mode**
At each step, you can check for yourself whether the bug is present and
say `git bisect good` or `git bisect bad` accordingly, until Git tells
you "first bad commit". This works, but it's slow with many commits.

**Hint 3 — automatic mode (recommended)**
Write a small script that returns exit code `0` if the commit is "good"
(test passes) and non-zero if it's "bad" (bug present). For example
`check.sh`:
```bash
#!/usr/bin/env bash
python3 -c "from math_utils import is_prime; assert is_prime(9) is False; assert is_prime(4) is False"
```
Make it executable: `chmod +x check.sh`.

**Hint 4**
```
git bisect start
git bisect bad HEAD
git bisect good <hash-of-first-commit>
git bisect run ./check.sh
```
Git will run the script on each candidate commit automatically and
converge on the culprit alone.

**Hint 5**
When done, don't forget:
```
git bisect reset
```
to exit bisect mode and go back to your normal branch (`HEAD` was
"detached" throughout the process).
