#import "monokai_pro.typ": *
#import "keywords.typ": *

#set text(font: "Times New Roman", size: 12pt, hyphenate: false)

#include "cover_page.typ"

#pagebreak()

#set page(
  header: context [
    #set text(size: 10pt, fill: base3)
    #place(bottom + right)[#counter(page).display("1")]
  ],
  footer: [
    #set text(size: 10pt, fill: base6)
    #place(top + left)[TP058994]
    #place(top + right)[Cheng Yi Heng]
  ],
)
#set par(justify: true, leading: 1em, spacing: 2em)
#set enum(indent: 1em)
#set table(inset: 6pt, stroke: 0.6pt)
#set raw(theme: "Monokai Pro.tmTheme")

#show heading: set block(height: 1.5em)
#show figure.caption: set text(style: "italic")
#show outline.entry.where(level: 1): it => {
  v(14pt, weak: true)
  strong(it)
}
#show raw: it => {
  set text(fill: base7, size: 8pt)
  box(it, fill: base0, inset: 1.5em, radius: 1em)
}
#show cite: it => {
  if it.form == "prose" {
    show "&": "and"
    it
  } else {
    it
  }
}

#align(center)[= Acknowledgement]

I would like to express my heartfelt gratitude to everyone who supported me throughout the development of #velyst and the #lumina game.
First, I am deeply thankful to my teammates, whose dedication, collaboration, and creativity were essential in bringing this project to completion.

I also wish to extend my sincerest thanks to my supervisors, Mr. Jacob Sow Tian You and Assoc. Prof. Ts. Dr. Tan Chin Ike, for their invaluable guidance, insights, and encouragement throughout this journey.

Finally, I would like to thank my family and friends for their unwavering support and belief in me, which provided the motivation I needed to persevere through challenges.
This project would not have been possible without each of you.

#pagebreak()

= Abstract
// Summary, Introduction, Methodology (purposive sampling, qualitative/quantitative), Expected result

Despite the widespread use of raster graphics in games, vector graphics remain underutilized and largely absent, with little integration and no established framework for their effective use in modern game development.
This project introduces #velyst, a streamlined framework for integrating interactive and dynamic vector graphics into real-time video games.
It leverages Typst for vector content creation and Vello for real-time rendering of dynamic vector graphics.
By simplifying the process, this framework enables developers to produce high-quality and engaging content without needing to delve deeply into technical complexities.
Our study employs purposive sampling to collect valuable insights from developers in the gaming and interactive application sectors.
We will conduct seven in-depth interviews with industry professionals to gain expert perspectives.
Additionally, online survey questionnaires will be distributed to a broader developer audience to capture a wider range of opinions.
This uncovers the challenges and opportunities of integrating vector graphics, with insights that contributes to the framework on reducing technical barriers, enhancing interactivity, and highlighting areas for further innovation in the field.
This research aims to demonstrate the untapped potential of vector graphics in modern gaming and provide a practical solution for their seamless integration.
Our approach contributes to advancing infrastructure and fostering innovation, aligning with the goals of _Sustainable Development Goal (SDG) 9_.

// Keywords - Max 6
_*Keywords*: Typesetting, Markdown, Workflow, Dynamic content, Compute-centric, Typst_

#place(bottom)[*SDG Goal 9: Build resilient infrastructure, promote inclusive and sustainable industrialization and foster innovation*]

#pagebreak()

#outline(indent: 1em)

#pagebreak()

#outline(title: "Figures", target: figure.where(kind: image))

#pagebreak()

#outline(title: "Tables", target: figure.where(kind: table))

#pagebreak()

#let heading_numbering(.., last) = [CHAPTER #last: ]
#set heading(numbering: "1.")
#show heading.where(level: 1): set heading(numbering: heading_numbering)
#show heading.where(level: 1): it => underline(it)
#set enum(numbering: "1.a.")

#include "introduction.typ"

#pagebreak()

#include "literature_review.typ"

#pagebreak()

#include "methodology.typ"

#show heading.where(level: 1): set heading(numbering: none)

#pagebreak()

= References
#bibliography("citation.bib", style: "apa", title: none)

#pagebreak()

= Appendices
