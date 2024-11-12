#import "monokai_pro.typ": *
#import "keywords.typ": *

#set text(font: "Times New Roman", size: 12pt, hyphenate: false)

#include "cover_page.typ"

#pagebreak()

#set page(numbering: "1 / 1", number-align: right)
#set par(justify: true, leading: 1em, spacing: 2em)
#set enum(indent: 1em)
#set table(inset: 6pt, stroke: 0.6pt)
#set raw(theme: "Monokai Pro.tmTheme")

#show heading: set block(height: 1.5em)
// #show link: set text(style: "italic", fill: base0.mix(blue))
#show outline.entry.where(level: 1): it => {
  v(14pt, weak: true)
  strong(it)
}
#show heading: it => {
  if it.level > 2 {
    underline(it.body)
  } else {
    it
  }
}
#show raw: it => {
  set text(fill: base7, size: 8pt)
  box(it, fill: base0, inset: 1.5em, radius: 1em)
}

#align(center)[= Acknowledgement]

#pagebreak()

= Abstract
// Summary, Introduction, Methodology (purposive sampling, qualitative/quantitative), NO result

Despite the widespread use of raster graphics in games, vector graphics remain underutilized and largely absent, with little integration and no established framework for their effective use in modern game development.
This project introduces #velyst, a streamlined framework for integrating interactive and dynamic vector graphics into real-time video games.
It leverages Typst for vector content creation and Vello for real-time rendering of dynamic vector graphics.
By simplifying the process, this framework enables developers to produce high-quality and engaging content without needing to delve deeply into technical complexities.
Our study employs purposive sampling to collect valuable insights from developers in the gaming and interactive application sectors.
We will conduct three in-depth interviews with industry professionals to gain expert perspectives.
Additionally, online survey questionnaires will be distributed to a broader developer audience to capture a wider range of opinions.
This uncovers the challenges and opportunities of integrating vector graphics, with insights that contributes to the framework on reducing technical barriers, enhancing interactivity, and highlighting areas for further innovation in the field.
This research aims to demonstrate the untapped potential of vector graphics in modern gaming and provide a practical solution for their seamless integration.
Our approach contributes to advancing infrastructure and fostering innovation, aligning with the goals of _Sustainable Development Goal (SDG) 9_.

// Keywords - Max 6
*Keywords* --- Typesetting, Markdown, Workflow, Dynamic content, Compute-centric, Typst

#pagebreak()

#outline(indent: 1em)

#pagebreak()

#outline(title: "Figures", target: figure.where(kind: image))

// #pagebreak()

#outline(title: "Tables", target: figure.where(kind: table))

// #pagebreak()

#outline(title: "Codes", target: figure.where(kind: raw))

#pagebreak()

#let heading_numbering(.., last) = [CHAPTER #last: ]
#set heading(numbering: "1.")
#show heading.where(level: 1): set heading(numbering: heading_numbering)
#show heading.where(level: 1): it => underline(it)
#set enum(numbering: "1.a.")

#include "introduction.typ"

#pagebreak()

#include "literature_review.typ"

= Methodology

== System Development Methodology

== Data Gathering Design

== Analysis

#show heading.where(level: 1): set heading(numbering: none)

= References

= Appendices

#pagebreak()

= References
#bibliography("citation.bib", style: "apa", title: none)
