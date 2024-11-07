#import "monokai_pro.typ": *

#set text(font: "Times New Roman", size: 12pt, hyphenate: false)

#let radiance_cascades = [_Radiance Cascades_]
#let vello = [_Vello_]
#let typst = [_Typst_]
#let bevy = [_Bevy_]

#let bevy_rc = [*Bevy RC*]
#let velyst = [*Velyst*]
#let lumina = [*Lumina*]

// Cover page
#align(center)[
  #image("assets/apu-logo.png", height: 120pt)
  *INVESTIGATION REPORT*

  #linebreak()

  #stack(
    dir: ltr,
    spacing: 1em,
    image("assets/sdg9.svg"),
    align(horizon)[
      *Establishing a Workflow for Real-time Global Illumination and Vector Graphics in Enhancing Dynamic Game Environments*
    ],
  )

  *By*

  *Cheng Yi Heng*

  *TP058994*

  *APU3F2408CGD*

  #linebreak()

  A report submitted in partial fulfilment of the requirements for the degree of

  BSc (Hons) Computer Games Development

  at Asia Pacific University of Technology and Innovation.

  #linebreak()

  *Supervised by Mr. Jacob Sow Tian You*

  *2#super[nd] Marker: Dr. Tan Chin Ike*

  #linebreak()

  *27#super[th] November 2024*
]

#pagebreak()

#set par(justify: true, leading: 1em, spacing: 2em)
#set enum(indent: 1em)
#set table(inset: 6pt)

#show heading: set block(height: 1em)
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

#align(center)[= Acknowledgement]

#pagebreak()

= Abstract

// Summary, Introduction, Methodology (purposive sampling, qualitative/quantitative), NO result

Achieving visually rich and interactive content in real-time without compromising performance is a key aspect of immersive gameplay.
This project seeks to establish a streamlined workflow that incorporates real-time global illumination (GI) and compute-centric vector graphics (VG) into dynamic game environments in a way that is accessible and adaptable for game developers.
These integrations will help improve visual appeal and interactive feedback in gameplay.
Our method utilizes #radiance_cascades for enabling real-time GI, #vello for rendering dynamic VG in real-time, and #typst for VG content creation.
Using purposive sampling, this study targets developers in the game development industry through the use of questionnaires.
It is aimed to gather insights on the importance of GI and VG as well as the level of integrations in state-of-the-art game engines.
This paper provides an in-depth look at the challenges and potential methods for integrating these technologies into game development, with an emphasis on their impact on interactive and adaptable content creation.
Our approach contributes to advancing infrastructure and fostering innovation, aligning with the goals of Sustainable Development Goal (SDG) 9.

// Keywords - Max 6

*Keywords* --- radiance cascades, indirect lighting, typesetting, markdown, interactivity, dynamic content

#pagebreak()

#outline(indent: 1em)

#pagebreak()

#outline(title: "Figures", target: figure.where(kind: image))

// #pagebreak()

#outline(title: "Tables", target: figure.where(kind: table))

#pagebreak()

#let heading_numbering(.., last) = [CHAPTER #last: ]
#set heading(numbering: "1.")
#show heading.where(level: 1): set heading(numbering: heading_numbering)
#show heading.where(level: 1): it => underline(it)
#set enum(numbering: "1.a.")

= INTRODUCTION

// Chapter 1 of the report is an important chapter since it describes the overall project and its outcome.
// As this is the first chapter that the evaluators will read, it is essential to make a good first impression.
// It is important to write a chapter that clearly explains the project's flow.
// A thorough understanding of the ground work is necessary in order to write a well-written chapter.

== Problem Background

=== Limitations of scalability in current real-time global illumination techniques

Global illumination has been a notoriously hard problem to solve in computer graphics.
To put things into perspective, global illumination intends to solve the _many to many_ interactions between light, obstacles, and volumes.
Ray tracing is an algorithm that calculates these light interactions by tracing lights from the camera into the scene, following their paths as they bounce off surfaces and interact with materials.
Each bounce contributes to the final color and lighting of the scene, accounting for reflections, refractions, and scattering.

Unfortunately, ray tracing is just too slow for real-time applications.
In real-time game engines like Unity and Unreal Engine, light probes (a.k.a radiance probes) are placed around the scene to capture lighting information, which can then be applied to nearby objects.
To smoothen out the transition between probes, objects interpolate between nearest surrounding probes, weighted by distance to approximate the global radiance.
This technique leads to questions like "how many probes should a scene have?" or "how much probes is a good approximation?".
Ultimately, it becomes a trade-off between fidelity versus performance, with more probes resulting in better approximation, while fewer probes improve performance.
This paradoxical issue raises the challenge of finding the optimal balance.
This dilemma underscores the need for smarter, adaptive techniques, ensuring both visual fidelity and efficiency.

=== Advantages of vector graphics over bitmap graphics in terms of animation

#figure(caption: [Vector vs Bitmap graphics @arneratermanis2017])[#image("assets/vector-vs-raster.png")] <vector-vs-raster>

Traditional methods of rendering 2D graphics has always relied on bitmap-based texture mapping @ray2005vector.
While this approach is ubiquitous, it suffers a major drawback of the _pixelation_ effect when being scaled beyond the original resolution @nehab2008random.
Furthermore, creating animations using bitmap graphics can be extremely limited and complex because of the rigid grid-like data structure used to store the data.
Animating bitmap graphics are commonly done through the use of shaders which directly manipulates the individual pixels, or relying on image sequences (flipbooks) which produces an illusion of movement.

Unlike raster graphics, which rely on a fixed grid of pixels, vector graphics are resolution-independent.
This means that it can scale without losing quality (shown in @vector-vs-raster).
A vector illustration is composed of multiple _paths_ that define _shapes_ to be painted in a given order @ganacim2014massively.
Each of these individual paths can be traced, altered, or even morphed into a completely different shape which allows for a huge variety of animation techniques.

// TODO: use this in limitations?
Lastly, it is crucial to recognize that while vector graphics offer numerous benefits, it is only suitable for representing precise shapes --- such as fonts, logos, and icons.
In contrast, complex images with intricate details, like photographs of a cat are far better represented using bitmap formats.

=== Lack of support on UI/UX creation for complex interactivity

Most game engines in the market like Unity, Godot, Game Maker, and Unreal Engine uses a _What You See Is What You Get_ (WYSIWYG) editor for creating user interfaces.
WYSIWYG editors are visual centric tools that let users work directly within the presentation form of the content @madje2022programmable.
Users normally layout their contents using a drag and drop editor and then style them using a style-sheet.
To bind interactions or animations towards a content, users would need to label it with a unique tag and query them through code.

Complex content and logic wouldn't be possible through a typical WYSIWYG editor.
For instance, it is virtually impossible to author a custom polygon shape in the editor with custom math based animation which depends on a time value.
This can only be achieved through code, and is often limited by the application programming interface (API) layer provided by the WYSIWYG editor.
This creates a huge distinction between the game/UI logic and the visual representation that is needed to convey the messages.

While hot-reloading is applicable for the layout and styling (and simple logic to some extend) of a content.
A WYSIWYG editor would not be capable of hot-reloading complex logic as these can only be achieved using code, which in most cases, requires a re-compilation.
This could lead to frustration and lost of creativity due to the slow feedback loop.

== Project Aim

This project aims to empower creators to create rich and visually appealing content in games in an efficient and streamlined workflow, by allowing them to focus most of their time on the content instead of the technical details needed to achieve the look or feel that they envisioned.

== Objectives

// A minimum of three objectives and a maximum of four.
// Must be measurable

The objectives of this project are as follows:

+ To utilize #vello, a compute-centric vector graphics renderer for rendering animated and dynamic vector graphics content.
+ To create an intuitive and yet powerful (programmable) workflow for generating animated and dynamic content using #typst.
+ To allow creators to focus on the creative aspects of game development.
+ To implement #radiance_cascades, a technique that provides realistic lighting without sacrificing real-time performance.

== Scope

// Describes in detail tasks to be executed.
// Constraints regarding any part of the project development (e.g. size of system and technology).
// What will and will not be done as part of the project.

The scope of this project invovles making a game that utilizes 2 custom libraries (1 for global illumination and 1 for interactive vector graphics content).
The creation of the game will ensure that 2 of our libraries are production ready by the end of this project.

#table(
  columns: (auto, 1fr),
  table.cell(colspan: 2)[#align(center)[*Libraries (Crates)*]],

  [*Bevy Radiance Cascades\ (#bevy_rc)*],
  [A 2D global illumination solution for the #bevy game engine.],

  [#velyst], [An interactive #typst content creator using #vello and #bevy.],

  table.cell(colspan: 2)[#align(center)[*Game*]],

  [#lumina], [A 2D top down fast paced objective based PvPvE game.],
)

=== Tasks to be executed:

+ Develop the #bevy_rc crate.
  + Develop the #radiance_cascades algorithm.
  + Implement #radiance_cascades into #bevy's 2D render graph.
  + Support emissive and translucent materials.
  + Support directional light beams / spot lights.
  + Support negative lighting effects (light consumption).
  + Support rim lighting for better visual effects.

+ Develop the #velyst crate.
  + Develop an integrated compiler for #typst content in #bevy.
  + Support hot-reloading of #typst content.
  + Support interactivity between #bevy and #typst.
  + Develop an easy-to-use workflow for UI creation using #typst.
  + Write up a getting started documentation to make on-boarding easier for new developers.

+ Develop the #lumina game.
  + Create a game design document (GDD) for the game.
  + Integrate both #bevy_rc and #velyst into the game.
  + Develop all the required game mechanics for the game.
  + Playtest the game and gather player feedbacks on the game.

=== Constraints

#table(
  columns: (auto, 1fr),
  table.header([Constraint], [Reason]),
  [*Compatibility*], [],
)

=== What will do in this project:

=== What will not be done in this project:

== Potential Benefit

=== Tangible Benefit

=== Intangible Benefit

=== Target User

// Tangible benefit.
// Intangible benefit
// Target user

== Overview of the IR

== Project Plan

= Literature Review

== Domain Research

== Similar Systems/Works

== Technical Research

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
