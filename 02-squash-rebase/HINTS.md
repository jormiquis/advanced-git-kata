# Hints — 02 Squash with interactive rebase

**Hint 1**
The base command is:
```
git rebase -i main
```
This opens your editor with the list of 5 commits, oldest (top) to
newest (bottom).

**Hint 2**
In the editor, every line starts with `pick`. To merge a commit into
the previous one, change `pick` to `squash` (or `s`) on the ones you
want folded upward. The first commit in the list must **always stay as
`pick`** (it's the base the others get folded onto).

**Hint 3**
To end up with 2 final commits out of 5, group them like this (top to
bottom): the 1st stays `pick`, the 2nd and 3rd become `squash` (folded
into the 1st), the 4th stays `pick` (starts the second group), and the
5th becomes `squash` (folded into the 4th).

**Hint 4**
After you save and close that first screen, Git will open the editor
again, once per merged group, so you can write the combined final
message. Delete the old messages (`wip`, `fix typo`...) and write a
single clean one, e.g. `feat: implement login with user validation`.

**Hint 5**
If something goes wrong halfway through, `git rebase --abort` takes you
straight back to the state before you started, no changes applied.
