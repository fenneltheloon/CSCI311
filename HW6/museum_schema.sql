CREATE TABLE IF NOT EXISTS "objects" (
  "ObjectID"                        INTEGER PRIMARY KEY,
  "Accession Number"                TEXT,
  "Object Number"                   REAL,
  "Sort Number"                     TEXT,
  "Department"                      TEXT,
  "Classification"                  TEXT,
  "Acquisition Method"              TEXT,
  "Object Status"                   TEXT,
  "Artist/Maker"                    TEXT,
  "Title"                           TEXT,
  "Object Name (Ctrl + Insert)"     TEXT,
  "Dated"                           TEXT,
  "Materials / Techniques"          TEXT,
  "Dimensions"                      TEXT,
  "Description"                     TEXT,
  "Credit Line (Ctrl + Insert)"     TEXT,
  "Culture (Ctrl + Insert)"         TEXT,
  "Period/Dynasty (Ctrl + Insert)"  TEXT,
  "eMuseum Label Text"              TEXT
);

CREATE TABLE IF NOT EXISTS "dates" (
  "ObjectID"    INTEGER,
  "Start Year"  INTEGER,
  "End Year"    INTEGER,
  "Approximate" INTEGER,
  FOREIGN KEY("ObjectID") REFERENCES "objects"("ObjectID")
);

CREATE TABLE IF NOT EXISTS "materials" (
  "MaterialID" INTEGER PRIMARY KEY,
  "Material" TEXT
);

CREATE TABLE IF NOT EXISTS "dimensions" (
  "ObjectID"            INTEGER,
  "Type"                TEXT,
  "Axis"                TEXT,
  "Value (cm/min/kg)"   REAL,
  FOREIGN KEY("ObjectID") REFERENCES "objects"("ObjectID")
);

CREATE TABLE IF NOT EXISTS "object_has_material" (
  "ObjectID"    INTEGER,
  "MaterialID"  INTEGER,
  FOREIGN KEY("ObjectID") REFERENCES "objects"("ObjectID"),
  FOREIGN KEY("MaterialID") REFERENCES "materials"("MaterialID")
);