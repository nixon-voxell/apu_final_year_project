#import "monokai_pro.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge, cetz
#import fletcher.shapes: house, hexagon, octagon

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

#let blob(pos, label, tint: base7, ..args) = node(
  pos,
  align(center, label),
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

#let gradient_blob(pos, label, colors, ..args) = node(
  pos,
  align(center, label),
  fill: gradient.linear(..colors.map(c => c.lighten(60%))),
  stroke: 0.1em + gradient.linear(..colors.map(c => c.darken(20%))),
  corner-radius: 0.5em,
  ..args,
)

#let diag_world(body) = [
  #set text(font: "New Computer Modern")
  #body
]

#let cell_diag(..args) = diagram(
  spacing: 0.8em,
  cell-size: (0.8em, 1em),
  edge-stroke: 1pt,
  edge-corner-radius: 5pt,
  mark-scale: 80%,
  ..args,
)

