"""check_mandatory.py - flags missing mandatory fields in a supplier JSON file.
Practice project (Nov 2026) - fictional case DemoRetail / DemoFoods.
Usage: python check_mandatory.py products.json
"""
import json
import sys

# Mandatory fields for every product (rule from Confluence 1.4, R1).
# Fields per category are still open (Q3).
MANDATORY = ["gtin", "name", "net_quantity", "unit",
             "ingredients", "allergens", "category", "front_image"]


def is_missing(value):
    """A field counts as missing if it is absent (None), empty text or an empty list."""
    return value is None or value == "" or value == []


def check(products):
    """Return a list of (item_no, field) pairs for every missing field."""
    problems = []
    for product in products:
        item = product.get("item_no", "?")
        for field in MANDATORY:
            if is_missing(product.get(field)):
                problems.append((item, field))
    return problems


def main():
    if len(sys.argv) != 2:
        print("Usage: python check_mandatory.py <file.json>")
        sys.exit(2)
    with open(sys.argv[1], encoding="utf-8") as f:
        products = json.load(f)
    problems = check(products)
    for item, field in problems:
        print(f"{item}: missing mandatory field '{field}'")
    bad = len({item for item, _ in problems})
    print(f"Checked {len(products)} products - {bad} with missing fields, "
          f"{len(products) - bad} OK.")
    sys.exit(1 if problems else 0)   # 1 = problems found (useful for automation)


if __name__ == "__main__":
    main()
