-- PTA product data model (practice project, fictional DemoFoods data). SQLite syntax.
CREATE TABLE supplier (
  supplier_id TEXT PRIMARY KEY,
  name        TEXT NOT NULL
);
CREATE TABLE category (
  category_id TEXT PRIMARY KEY,
  name        TEXT NOT NULL
);
CREATE TABLE product (
  gtin         TEXT PRIMARY KEY,            -- 13 digits, demo prefix 20 (internal use)
  item_no      TEXT NOT NULL,
  supplier_id  TEXT NOT NULL REFERENCES supplier(supplier_id),
  category_id  TEXT REFERENCES category(category_id),
  name         TEXT,
  net_quantity REAL,
  unit         TEXT,
  ingredients  TEXT,
  front_image  TEXT,
  data_version INTEGER NOT NULL
);
CREATE TABLE product_allergen (
  gtin          TEXT REFERENCES product(gtin),
  allergen_code TEXT,                       -- one of the 14 EU allergens, or 'none'
  PRIMARY KEY (gtin, allergen_code)
);
CREATE TABLE product_text (
  text_id        INTEGER PRIMARY KEY,
  gtin           TEXT NOT NULL REFERENCES product(gtin),
  version        INTEGER NOT NULL,
  status         TEXT NOT NULL,             -- draft / flagged / approved / rejected
  prompt_version TEXT NOT NULL,
  data_version   INTEGER NOT NULL,
  approved_by    TEXT,
  approved_at    TEXT,
  body           TEXT
);

INSERT INTO supplier VALUES ('DEMOFOODS', 'DemoFoods AG');
INSERT INTO category VALUES ('CER','Breakfast cereals'),('SAU','Sauces'),('CHO','Chocolate'),('PAS','Pasta'),('SNA','Snacks');
INSERT INTO product VALUES
 ('2000000010014','DF-1001','DEMOFOODS','CER','Oat Crunch Muesli',500,'g','oat flakes, wheat flakes, hazelnuts, honey','df1001_front.jpg',3),
 ('2000000010038','DF-1003','DEMOFOODS','SAU','Tomato Sauce',400,'g','tomatoes, onions, olive oil, salt, basil',NULL,1),
 ('2000000010045','DF-1004','DEMOFOODS','CHO','Dark Chocolate 70 %',NULL,'g','cocoa mass, sugar, cocoa butter, soy lecithin','df1004_front.jpg',2),
 ('2000000010076','DF-1007','DEMOFOODS','PAS','Fusilli Pasta',500,'g','durum wheat semolina','df1007_front.jpg',1),
 ('2000000010083','DF-1017','DEMOFOODS','PAS','Fusilli Pasta',500,'g','durum wheat semolina','df1017_front.jpg',1),
 ('2000000010113','DF-1011','DEMOFOODS','SNA','Rice Waffles Natural',100,'g','whole grain rice, salt','df1011_front.jpg',1);
INSERT INTO product_allergen VALUES
 ('2000000010038','none'),('2000000010045','soy'),('2000000010076','gluten'),('2000000010083','gluten'),('2000000010113','none');
