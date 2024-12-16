#set page(height: auto)
#set text(font: "New Computer Modern")
#show link: underline
#show link: set text(fill: blue)

= Homework 6
Ethan Meltzer\
I have adhered to the Honor Code on this assignment.

URL to code repo: #link("https://github.com/fenneltheloon/CSCI311/tree/main/HW6")\
URL to application: #link("https://everwild.dev/CSCI311/form.php")

Things to try/features:
- Keyword search is a _full-text_ search over the entire database, using `fts5`.
- Date search returns correct ranges
- Materials/Techniques form autocompletes
- All others perform wildcard search in their respective columns
All searches are case-insensitive. 