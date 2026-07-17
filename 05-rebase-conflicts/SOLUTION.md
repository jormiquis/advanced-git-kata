# Solution — 05 Conflicts during a rebase

```bash
git switch feature/tuning
git rebase main
```

Git stops with a conflict in `config.py`. The file looks like this:

```
DEBUG = False
<<<<<<< HEAD
MAX_CONNECTIONS = 20
=======
MAX_CONNECTIONS = 50
>>>>>>> abc1234 (feat: increase MAX_CONNECTIONS to 50)
TIMEOUT_SECONDS = 30
```

Resolve it, respecting main's value:

```
DEBUG = False
MAX_CONNECTIONS = 20
TIMEOUT_SECONDS = 30
```

```bash
git add config.py
git rebase --continue
```

The second commit might also conflict (the surrounding context
changed), producing something like:

```
DEBUG = False
<<<<<<< HEAD
MAX_CONNECTIONS = 20
TIMEOUT_SECONDS = 30
=======
MAX_CONNECTIONS = 50
TIMEOUT_SECONDS = 60
RETRY_ATTEMPTS = 3
>>>>>>> b1fe139 (feat: increase timeout and add retries)
```

Resolve it to:

```
DEBUG = False
MAX_CONNECTIONS = 20
TIMEOUT_SECONDS = 60
RETRY_ATTEMPTS = 3
```

```bash
git add config.py
git rebase --continue
```

Final result:

```
DEBUG = False
MAX_CONNECTIONS = 20
TIMEOUT_SECONDS = 60
RETRY_ATTEMPTS = 3
```

## Why this is "senior"

- During a rebase, Git reapplies your commits **one at a time** onto
  the new base, so you might have to resolve the same kind of conflict
  more than once if several commits touch the same area — that's
  normal, not a mistake.
- The orientation of `<<<<<<< HEAD` / `>>>>>>>` is flipped compared to
  a `merge`: in a rebase, `HEAD` is the new base (here, `main`), not
  your branch. Mixing this up is the number one source of mistakes when
  resolving rebase conflicts.
- Resolving "blindly" by always keeping your version (`ours`) or always
  the other side (`theirs`) is tempting but risky: here, keeping your
  `50` would have silently reverted a production fix. You need to
  understand *why* each side changed before deciding, not just
  mechanically pick one.
- The result is a linear history, no merge commit — easier to read with
  `git log` and no "knots" in the graph.
