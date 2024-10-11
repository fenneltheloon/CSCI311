#set page(height: auto)
#set text(font: "New Computer Modern")

= Homework 3
Ethan Meltzer\
I have adhered to the Honor Code on this assignment.

+ \
  #set enum(numbering: "(a)")
  + author, name\
    publisher, name\
    customer, email\
    shopping_basket, basket_id\
    book, ISBN\
    warehouse, code
  + \
    #image("hw3-1b.png")
  + \
    #image("hw3-1c.png")
+ \
  #image("hw3-2.png")
  Below is the list of SQL commands used to generate the above ER diagram. The
  DDL contains both relationship schema as well as primary and foreign key 
  constraints.

  #raw(read("car_dealer.sql"), lang: "sql")
