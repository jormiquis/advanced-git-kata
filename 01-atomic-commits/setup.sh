#!/usr/bin/env bash
set -e
rm -rf repo
mkdir repo
cd repo

cat > calculator.py <<'EOF'
def add(a, b):
    return a + b


def subtract(a, b):
    return a - b


def multiply(a, b):
    return a * b
EOF

cat > README.md <<'EOF'
# Calculator

A simple library of math operations.
EOF

git add .
git commit -q -m "Initial commit: basic calculator"

# --- Now we generate UNCOMMITTED changes that mix 3 unrelated things ---

# 1) Real bugfix: divide/multiply by zero not handled (existing bug)
python3 - <<'PYEOF'
content = open("calculator.py").read()
content = content.replace(
    "def multiply(a, b):\n    return a * b\n",
    "def multiply(a, b):\n    return a * b\n\n\ndef divide(a, b):\n    if b == 0:\n        raise ValueError(\"cannot divide by zero\")\n    return a / b\n"
)
open("calculator.py", "w").write(content)
PYEOF

# 2) Unrelated new feature: power function
python3 - <<'PYEOF'
content = open("calculator.py").read()
content += "\n\ndef power(base, exponent):\n    return base ** exponent\n"
open("calculator.py", "w").write(content)
PYEOF

# 3) Unrelated formatting/style change: rewrite the README
cat > README.md <<'EOF'
# Calculator

A simple library of math operations written in pure Python,
no external dependencies.

## Available functions

- add
- subtract
- multiply
- divide
- power
EOF

# 4) A new test file, related to the divide function (bugfix)
cat > test_calculator.py <<'EOF'
from calculator import divide

def test_divide_by_zero_raises_error():
    try:
        divide(10, 0)
        assert False, "should have raised ValueError"
    except ValueError:
        assert True

def test_divide_normal():
    assert divide(10, 2) == 5
EOF

echo "Repo generated at: $(pwd)"
echo "Run 'git status' and 'git diff' to see the pending changes."
