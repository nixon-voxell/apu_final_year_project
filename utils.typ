#import "monokai_pro.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge, cetz
#import fletcher.shapes: house, hexagon, octagon, chevron

#let info_box(title, body) = {
  box(
    inset: 1em,
    radius: 0.5em,
    fill: yellow.lighten(80%),
    stroke: 0.1em,
  )[
    #set par(leading: 0.8em, spacing: 1em)
    #place(right, stack(dir: ltr, [_Info_], rotate(30deg, emoji.lightbulb)))
    #set text(size: 0.9em)
    #title

    #body
  ]
}

#let source_file_icon = box(
  height: 1em,
  width: 0.8em,
  fill: white,
  radius: 0.1em,
  stroke: base3 + 0.04em,
)[
  #set line(length: 0.6em, stroke: (thickness: 0.06em))
  #stack(spacing: 0.15em, line(), line(), line(), line())
]

#let blob(pos, label, tint: base7, lean: center, ..args) = node(
  pos,
  align(lean, label),
  fill: tint.lighten(60%),
  stroke: 0.1em + tint.darken(20%),
  corner-radius: 0.5em,
  ..args,
)

#let dotted_blob(pos, label, tint: base8, ..args) = node(
  pos,
  align(center, label),
  fill: tint.lighten(60%),
  stroke: (thickness: 0.1em, paint: tint.darken(20%), dash: "dashed"),
  corner-radius: 0.5em,
  ..args,
)

#let gradient_blob(pos, label, colors, lean: center, ..args) = node(
  pos,
  align(lean, label),
  fill: gradient.linear(..colors.map(c => c.lighten(60%))),
  stroke: 0.1em + gradient.linear(..colors.map(c => c.darken(20%))),
  corner-radius: 0.5em,
  ..args,
)

#let diag_world(body) = [
  #set text(font: "New Computer Modern")
  #body
]

#let cell_diag(cell-size: (0.8em, 1em), ..args) = diagram(
  spacing: 0.8em,
  cell-size: cell-size,
  edge-stroke: 1pt,
  edge-corner-radius: 5pt,
  mark-scale: 80%,
  ..args,
)

#let unit_test(
  caption: content,
  tests: ((desc: content, expected: content),),
) = {
  let table_conts = ()
  for (i, t) in tests.enumerate() {
    i += 1
    table_conts.push([#i])
    table_conts.push(t.desc)
    table_conts.push(t.expected)
    table_conts.push([])
    table_conts.push([])
  }

  set text(size: 0.9em)
  set par(justify: false)
  show figure: set block(breakable: true)
  figure(caption: caption)[
    #table(
      columns: (auto, 1fr, 1fr, auto, auto),
      align: left,
      table.header(
        [],
        [*Description/Actions*],
        [*Expected Output*],
        [*Actual Output*],
        [*Test Result\ (Pass/Fail)*],
      ),
      ..table_conts
    )
  ]
}

#let unit_test_result(
  caption: content,
  tests: ((desc: content, expected: content),),
) = {
  let table_conts = ()
  for (i, t) in tests.enumerate() {
    i += 1
    table_conts.push([#i])
    table_conts.push(t.desc)
    table_conts.push(t.expected)
    table_conts.push([As expected])
    table_conts.push([Pass])
  }

  set text(size: 0.9em)
  set par(justify: false)
  show figure: set block(breakable: true)
  figure(caption: caption)[
    #table(
      columns: (auto, 1fr, 1fr, auto, auto),
      align: left,
      table.header(
        [],
        [*Description/Actions*],
        [*Expected Output*],
        [*Actual Output*],
        [*Test Result\ (Pass/Fail)*],
      ),
      ..table_conts
    )
  ]
}

#let ques_design_obj(
  caption: content,
  quests: ((quest: content, ans: content, just: content, obj: content),),
) = {
  let table_conts = ()
  for (i, q) in quests.enumerate() {
    i += 1
    table_conts.push([#i])
    table_conts.push(q.quest)
    table_conts.push(box(q.ans))
    table_conts.push(q.just)
    table_conts.push(q.obj)
  }

  set text(size: 0.9em)
  set par(justify: false)
  show figure: set block(breakable: true)
  figure(caption: caption)[
    #table(
      columns: (auto, 1fr, 1fr, 1fr, 0.6fr),
      align: left,
      table.header(
        [],
        [*Question*],
        [*Answer*],
        [*Justification*],
        [*Relevant\ Research\ Objective*],
      ),
      ..table_conts
    )
  ]
}

#let ques_design2_obj(
  caption: content,
  quests: ((quest: content, ans: content, obj: content),),
) = {
  let table_conts = ()
  for (i, q) in quests.enumerate() {
    i += 1
    table_conts.push([#i])
    table_conts.push(q.quest)
    table_conts.push(box(q.ans))
    table_conts.push(q.obj)
  }

  set text(size: 0.9em)
  set par(justify: false)
  show figure: set block(breakable: true)
  figure(caption: caption)[
    #table(
      columns: (auto, 1fr, 0.7fr, 0.4fr),
      align: left,
      table.header(
        [],
        [*Question*],
        [*Answer*],
        [*Relevant\ Research\ Objective*],
      ),
      ..table_conts
    )
  ]
}

#let q_analysis(
  contents: ((ques: content, data: content, analysis: content),),
) = {
  for (i, cont) in contents.enumerate() {
    let table_cont = ()
    let idx = i + 1
    table_cont.push([#idx])
    table_cont.push(cont.ques)
    table_cont.push("Data")
    table_cont.push(cont.data)
    table_cont.push("Analysis")
    table_cont.push(cont.analysis)

    box(
      table(
        columns: (auto, 1fr),
        ..table_cont
      ),
    )
  }
}
