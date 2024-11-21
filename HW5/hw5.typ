#import "@preview/fletcher:0.5.2"
#set page(height: auto)
#set text(font: "New Computer Modern")

= Homework 5
Ethan Meltzer\
I have adhered to the Honor Code on this assignment.

== Indices

#let arraybox(..args) = {
    let items = args.pos()
    grid(
      inset: 5pt,
      stroke: 1pt,
      rows: 1.5em,
      columns: items.len(),
      ..items.map(i => [#i])
    )
}

#fletcher.MARKS.update(m => m + (
  ">": (inherit: "solid", rev: false),
  "<": (inherit: "solid", rev: true),
))

1\
#align(center)[
#fletcher.diagram({
  import fletcher: node, edge
  let node = node.with(inset: 0pt, stroke: none)
  node((0, 0), arraybox("", "Srinivasan", "", " ", "", " ", ""))
})]

2\
#align(center)[
#fletcher.diagram({
  import fletcher: node, edge
  let node = node.with(inset: 0pt, stroke: none)
  node((0, 0), arraybox("", "Srinivasan", "", "Wu", "", " ", ""))
})]

3\
#align(center)[
#fletcher.diagram({
  import fletcher: node, edge
  let node = node.with(inset: 0pt, stroke: none)
  node((0, 0), arraybox("", "Srinivasan", "", "Wu", "", "Mozart", ""))
})]

4\
#align(center)[
#fletcher.diagram({
  import fletcher: node, edge
  let node = node.with(inset: 0pt, stroke: none)
  node((0, 0), arraybox("", "Mozart", "", " ", "", " ", ""), name: <r>)
  node((-0.65, 1), arraybox("", "Srinivasan", "", "Wu", "", " ", ""), name: <l1>)
  node((0.65, 1), arraybox("", "Mozart", "", "Einstein", "", " ", ""), name: <l2>)
  edge(<l1>, <l2>, "->")
  edge((name: <r>, anchor: -160deg), (name: <l1>, anchor: 160deg), "->")
  edge(<r>, <l2>, "->")
})]
