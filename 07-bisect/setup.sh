#!/usr/bin/env bash
set -e
rm -rf repo
mkdir repo
cd repo
git init -q -b main
git config user.email "you@example.com"
git config user.name "Your Name"

cat > math_utils.py <<'EOF'
def is_prime(n):
    if n < 2:
        return False
    for i in range(2, n):
        if n % i == 0:
            return False
    return True
EOF
cat > test_math_utils.py <<'EOF'
from math_utils import is_prime

def test_primes():
    assert is_prime(2) is True
    assert is_prime(17) is True
    assert is_prime(4) is False
    assert is_prime(1) is False
EOF
git add . && git commit -q -m "feat: add is_prime function with tests"

echo "def helper_one(): pass" >> math_utils.py
git add . && git commit -q -m "chore: add unused helper"

echo "def helper_two(): pass" >> math_utils.py
git add . && git commit -q -m "chore: add another unused helper"

echo "# minor comment" >> math_utils.py
git add . && git commit -q -m "docs: minor comment"

# This is where the bug is introduced: changes the range and breaks is_prime for 9 and similar numbers
python3 - <<'PYEOF'
content = open("math_utils.py").read()
content = content.replace(
    "    for i in range(2, n):\n        if n % i == 0:\n            return False\n",
    "    for i in range(2, int(n ** 0.5)):\n        if n % i == 0:\n            return False\n"
)
open("math_utils.py", "w").write(content)
PYEOF
git add . && git commit -q -m "perf: optimize is_prime by limiting the check range"

echo "def helper_three(): pass" >> math_utils.py
git add . && git commit -q -m "chore: add third unused helper"

echo "# more cleanup" >> math_utils.py
git add . && git commit -q -m "chore: minor comment cleanup"

cat >> math_utils.py <<'EOF'

def is_even(n):
    return n % 2 == 0
EOF
git add . && git commit -q -m "feat: add is_even function"

echo "Repo generated at: $(pwd)"
echo ""
git log --oneline
echo ""
echo "The test 'test_math_utils.py' now FAILS at HEAD (check it with"
echo "'python3 -m pytest test_math_utils.py' if you have pytest, or with"
echo "'python3 -c \"from math_utils import is_prime; assert is_prime(9) is False\"')."
echo "But it used to pass on the first commit. Find which commit introduced the bug"
echo "using 'git bisect'."
