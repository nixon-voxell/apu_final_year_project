#let velyst = box(
  outset: (y: 0.3em),
  inset: (x: 0.2em),
  radius: 0.2em,
  fill: gradient.linear(orange.lighten(70%), purple.lighten(70%)),
  stroke: 0.07em + gradient.linear(orange.darken(20%), purple.darken(20%)),
  text(fill: gradient.linear(orange.darken(10%), purple.darken(10%)))[*Velyst*],
)
#let lumina = box(
  outset: (y: 0.3em),
  inset: (x: 0.2em),
  radius: 0.2em,
  fill: gradient.linear(blue.lighten(70%), purple.lighten(70%)),
  stroke: 0.07em + gradient.linear(blue.darken(20%), purple.darken(20%)),
  text(fill: gradient.linear(blue.darken(10%), purple.darken(10%)))[*Lumina*],
)
#let typst_elem = [*_Typst Element_*]
#let typst_vello = [*_Typst Vello_*]
