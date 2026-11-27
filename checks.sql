-- 3 data-quality checks for PTA (practice project). Each query returns the rows that need a DQ ticket.

-- Check 1: missing mandatory fields (R1). TRIM catches values that are only spaces.
SELECT item_no, gtin
FROM product
WHERE name IS NULL OR TRIM(name) = ''
   OR net_quantity IS NULL
   OR unit IS NULL OR TRIM(unit) = ''
   OR ingredients IS NULL OR TRIM(ingredients) = ''
   OR category_id IS NULL
   OR front_image IS NULL OR TRIM(front_image) = '';

-- Check 2: no allergen declared at all (R3, "0 allergen errors"). LEFT JOIN keeps products without a match.
SELECT p.item_no, p.name
FROM product p
LEFT JOIN product_allergen a ON a.gtin = p.gtin
WHERE a.gtin IS NULL;

-- Check 3: same product sent twice under two GTINs (duplicate, see DQ-7).
SELECT supplier_id, name, net_quantity, COUNT(*) AS copies
FROM product
GROUP BY supplier_id, name, net_quantity
HAVING COUNT(*) > 1;
