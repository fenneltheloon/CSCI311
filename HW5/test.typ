#import "@preview/fletcher:0.5.2"
#set page(height: auto)

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

#fletcher.diagram({
  import fletcher: node, edge
  let node = node.with(inset: 0pt, stroke: none)
  node((0, 0), arraybox("", "Mozart", "", " ", "", " ", ""), name: <r>)
  node((-0.65, 1), arraybox("", "Srinivasan", "", "Wu", "", " ", ""), name: <l1>)
  node((0.65, 1), arraybox("", "Mozart", "", "Einstein", "", " ", ""), name: <l2>)
  edge(<l1>, <l2>, "->")
  edge((rel: (-3em, 0em), to: <r>), (rel:(-7em, 0em), to: <l1>), "->")
  edge(<r>, <l2>, "->")
})

#fletcher.diagram({
  import fletcher: node, edge
  let node = node.with(inset: 0pt, stroke: none)
  node((0, 0), arraybox("", "Mozart", "", " ", "", " ", ""), name: <r>)
  node((-0.65, 1), arraybox("", "Srinivasan", "", "Wu", "", " ", ""), name: <l1>)
  node((0.65, 1), arraybox("", "Mozart", "", "Einstein", "", " ", ""), name: <l2>)
  edge(<l1>, <l2>, "->")
  edge((rel: (-3em, 0em), to: <r>), (rel:(-6em, 0em), to: <l1>), "->")
  edge(<r>, <l2>, "->")
})
