# pta-data-checks

Practice project (Nov 2026) – goal: learn data checks, Git and pull requests in practice.
Fictional case: retailer DemoRetail GmbH, supplier DemoFoods AG. All data is made up; GTINs use prefix 20 (GS1 internal-use range).

| File | What |
|---|---|
| `check_mandatory.py` | lists missing mandatory fields in a supplier JSON file |
| `products.json` | 5 test records with planted errors |
| `schema_demo.sql` | product data model + demo data (SQLite) |
| `checks.sql` | 3 data-quality checks |

Run: `python check_mandatory.py products.json`
