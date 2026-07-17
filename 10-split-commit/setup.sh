#!/usr/bin/env bash
set -e
rm -rf repo
mkdir repo
cd repo
git init -q -b main
git config user.email "you@example.com"
git config user.name "Your Name"

cat > api.py <<'EOF'
def health_check():
    return {"status": "ok"}
EOF
git add . && git commit -q -m "chore: initial commit"

# This giant commit mixes 3 things: a new model, a new endpoint, and a fix
cat > models.py <<'EOF'
class Product:
    def __init__(self, name, price):
        self.name = name
        self.price = price
EOF

cat > api.py <<'EOF'
def health_check():
    return {"status": "ok"}

def get_product(id):
    return {"id": id, "name": "demo"}
EOF

cat > utils.py <<'EOF'
def format_price(price):
    return "{:.2f}".format(price)
EOF

git add . && git commit -q -m "feat: add Product model, get_product endpoint and price formatting helper"

echo "Repo generated at: $(pwd)"
echo ""
git log --oneline
echo ""
echo "The last commit mixes 3 independent things into a single commit:"
echo "  1) models.py:  the Product class (new)"
echo "  2) api.py:     the get_product endpoint (new)"
echo "  3) utils.py:   format_price (new, unrelated to the other two)"
echo ""
echo "Your task: split that ONE commit into 3 atomic commits, using"
echo "'git rebase -i' with the 'edit' action."
