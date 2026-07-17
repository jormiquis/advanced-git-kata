# 07 — Finding a bug with git bisect

## Scenario

You have 9 commits. The first one (`feat: add is_prime function with
tests`) works perfectly. At some point in the history, an
"optimization" was introduced that broke `is_prime()` for certain
numbers (for example, it no longer correctly detects that 4 and 9
aren't prime).

You don't know which of the in-between commits introduced the bug, and
you don't want to check them one by one by hand.

## Goal

1. Confirm the bug exists in the current commit (`HEAD`):
   ```
   python3 -c "from math_utils import is_prime; assert is_prime(9) is False, 'BUG present'"
   ```
   (if no error is raised, the bug isn't there — but it should be at
   `HEAD` as the exercise is set up).

2. Confirm the first commit **doesn't** have the bug (same command, but
   first do `git checkout <hash-of-first-commit>`, test it, then switch
   back to `git checkout main`).

3. Use `git bisect` to automatically find the exact commit that
   introduced the bug, using a test script Git can run for you at each
   step (`git bisect run`).

## Verification

At the end, `git bisect` should point you to the commit with message
`perf: optimize is_prime by limiting the check range` as the culprit —
and, looking at its diff with `git show <hash>`, you should be able to
explain why it breaks cases like 4 or 9.

Don't forget to finish with `git bisect reset` to go back to normal
`HEAD` when you're done.
