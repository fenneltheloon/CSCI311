#set page(paper: "us-letter", margin: 1in)
#set text(font: "New Computer Modern")
#set enum(numbering: "(a)")

= Homework 1
Ethan Meltzer, CSCI 311\
2024-09-15

== Question 1
+ $Pi_("person_name") (sigma_("company_name" eq.not "BigBank") ("works"))$
+ $Pi_("person_name") ("employee")$ because the query could be defined in English
  better as "find the name of every employee." Or, if you prefer the redundant
  version, $ x <- "min" (Pi_("salary") ("works")),\ Pi_("person_name") (sigma_("salary" > x) ("works")) $
+ $Pi_("employee.person_name") ("employee" join_("employee.city" = "company.city") "city")$

== Question 2
+ \
  - branch: branch_name
  - customer: ID
  - loan: loan_number
  - borrower: ID
  - account: account_number
  - depositor: ID
+ \
  - branch: loan.branch_name, account.branch_name
  - customer: borrower.ID, depositor.ID
  - loan: borrower.loan_number
  - borrower: customer.ID, depositor.ID
  - account: depositor.account_number
  - depositor: customer.ID, borrower.ID

== Question 3
$ Pi_("depositor.ID") ("account" join_("account.account_number" = 
"depositor.account_number" and "account.balance" > 6000) "depositor") $

== Question 4
- recipie(name, author, prep_time, cook_time, instructions)
- ingredient(name, recipie, amount_needed, unit, contains) (contains will store a non-empty string listing any allergens that may be contained in the ingredient)
- cookware(name, recipie, amount_needed, dimension, material)
- stock(ingredient, quantity, supplier, use_by, location)
- appliance(name, recipie, available, needed, time_needed)

== Question 5
I filled it out :>
