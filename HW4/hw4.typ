#set page(height:auto)
#set text(font: "New Computer Modern")
#set enum(numbering: "1.")
#show link: set text(fill: blue)
#show link: underline

= Homework 4
Ethan Meltzer\
I have adhered to the Honor Code on this assignment.

== Part 1
+ http://sql.cs.oberlin.edu/emeltzer/dbForm.html
+ http://sql.cs.oberlin.edu/emeltzer/hw4-1-2.html

Make sure that you are using eduroam or the Oberlin VPN to access!

== Part 2
+ \
  - Fuzzy search over all attributes, or by category/label
  - Combine said above searches with logical operators (AND, OR, NOT)
  - Proper date search: exact and approximate modes, single or range input. When
    in exact mode, only works with exact dates will be returned.
  - Proper dimension search. User can filter for 2D vs. 3D, and enter ranges
    for up to 3 dimensions with measurements in cm or in. Can also have rough
    size categories (tiny, small, medium, large, huge) based on quintiles, standard deviation,
    or simply opinion.
  - Dropdown boxes for non-unique attributes (enums), especially highly repeated ones like Culture.
  This system should be picked over alternatives for its flexible precision. Want
  a rough keyword search? Yup, type anything in the dumb box and we'll scour the database
  for anything that matches. Want a painting that was completed in either date range A 
  or date range B with these specific dimensions? We can handle that too.
+ \
  - ObjectID: int,
  - Accession Number: counterintuitively, a string
  - Date acquired: int, derived from Accession Number
  - Department: int/foreign key to Department table
  - Classification: int, foreign key to classification table
  - Aquisition Method: int, foreign key to Aquisition method table
  - Object Status: Currently all objects in database are in permanent collection,
    but could change in future. Will create an attribute for it.
  - Artist/Maker: string
  - Title: string
  - Object Name: this could be an enum with a lot of options, or just stored as
    a string. Ideally, the search field for this could be an autocomplete box,
    like what is commonly implemented for doing something like selecting a country.
  - Start Date: int
  - End Date: int
  In the event of multiple date ranges, their union will be taken. Significant
  parsing will be neccesary to get proper integers for each piece.
  - Materials/Techniques: We'll split these entries on preposition/articles to isolate keywords,
    setup a many-many relationship between materials and artworks.
  NOTE: We'll store dimensions in cm and convert to in. application side/on user
  request. We'll need to pad out the bounds of ranges to account for conversion
  error. Dimension Category and Area/Volume are derived and can be calculated at
  time of insertion.
  - Dimension_X: float
  - Dimension_Y: float
  - Dimension_Z: opt float
  - Description: long string / text block
  - Credit Line: string (not worth dev time to implement comprehension for)
  NOTE: need to sanitize culture column for comprehension. One typo and at least
  one bad/missing entry found.
  - Culture: int, foreign key to culture entity
  - Period/Dynasty: int, foreign key to dynasty entity? OPTIONAL
    Separate the included date ranges and add an appropriate
    date filter? This is redundant behavior.
  - eMuseum Label Text: long string/text block

+ Relations:
  - Object has Department (\*:1)
  - Object has Classification (\*:1)
  - Object has Acquisition Method (\*:1)
  - Object has Name (\*:1)
  - Object has Materials/Techniques (\*:\*)
  - Object has Culture (\*:1) (OPTIONAL)
  - Object has Dynasty (\*:1) (OPTIONAL)

+ \
  #image("../../../Downloads/Untitled Diagram.drawio.svg")
