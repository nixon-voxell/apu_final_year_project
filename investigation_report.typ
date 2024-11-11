#import "monokai_pro.typ": *

#set text(font: "Times New Roman", size: 12pt, hyphenate: false)

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
      *Establishing a Framework for Interactive and Dynamic Vector Graphics Content in Real-Time Video Games*
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

  *2#super[nd] Marker: Assoc. Prof. Ts. Dr. Tan Chin Ike*

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

// Achieving visually rich and interactive vector graphics content in real-time without compromising performance is a key aspect of developing engaging gaming experiences.
// Our method utilizes Typst for vector graphics content creation and Vello for rendering dynamic vector graphics in real-time.
// This paper provides an in-depth look at the challenges and potential methods for integrating these technologies into game development, with an emphasis on their impact on interactive and adaptable content creation.

// Keywords - Max 6

*Keywords* --- Typesetting, Markdown, Workflow, Dynamic content, Compute-centric, Typst

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

// Achieving visually rich and interactive content in real-time without compromising performance is a key aspect of enhancing player engagement.
// This project addresses two major challenges in modern game development: creating dynamic, interactive user experiences and implementing accurate, real-time lighting models.
// Tackling these challenges requires two key innovations: a compute-centric vector graphics renderer and a programmable approach for developing interactive content.

*Vector graphics* is a form of computer graphics where visual images are generated using mathematical formulae @rick2024vector.
This includes geometric shapes, such as points, lines, curves, and polygons that are defined on a Cartesian plane.
The use of vector graphics in games can be tracked way back to when computer games was first developed.
One of the earliest examples of video game, _Tennis for Two_ (shown in @tennis-for-two) uses vector graphics to render their game on a repurposed oscilloscope in 1958 @historyofgames2023.
It was not long before video games was first commercialized during the 1970s and 1980s, with the release of vector graphics rendered games like _Space Wars_ #cite(<spacewar1997>, form: "prose"), _Battlezone_ #cite(<battlezone1980>, form: "prose"), and _Tac/Scan_ #cite(<tagscan1982>, form: "prose").
These games showcases the potential of vector-based visuals to achieve fluid and interactive animations.

#figure(
  image("assets/Tennis for Two.png"),
  caption: [Tennis for Two @tennis1958],
) <tennis-for-two>

Around this time, graphical processing units (GPU) were also experiencing rapid development and growth.
In 1989, Silicon Graphics Inc. (SGI) created one of the earliest graphics application programming interfaces (API) OpenGL, which forms the foundation of today’s computer graphics software @evolutiongpu2004.
As GPU advanced, support for raster graphics improved significantly, leading to a decline in the use of vector-based rendering technology in gaming @vectoringaming.

Despite the rise of raster graphics, the unique benefits of vector graphics (scalability and precision) continue to offer significant potential in modern game environments.
Today, vector graphics are rendered using high resolution monitors through the process of rasterization @tian2022survey.
This necessity led to the rise of algorithms specifically designed to convert mathematically defined shapes into pixels, creating a new domain of computational challenges.
In addition, there is little to no tool available that effectively integrates vector graphics content into real-time, interactive game environments.
The absence of such tools has hindered the widespread adoption of vector graphics in modern game development, limiting their use to methods like triangulation @drawinglines2015 and sign distance field @alvin2020rendering due to technical constraints.

This project addresses the need for a simplified and efficient workflow to integrate vector graphics into video games.

Vector graphics are often used in situations where scalability and precision are essential.
Common applications include: logos, typography, diagrams, charts, motion graphics, etc.
Examples of softwares that generates or uses vector graphics content includes Adobe Illustrator, Adobe After Effects, Affinity Publisher, Graphite, and many more.
Vector graphics is also used in a wide range of file formats including Scalable Vector Graphics (SVG), Portable Document Format (PDF), TrueType Font (TTF), OpenType Font (OTF), etc.
However, these formats are rarely used in the game industry directly (they are often preprocessed into some other formats, i.e. triangulation or signed distance fields [SDF]), as game engines are often only tailored towards rendering triangles and bitmap textures instead of paths and curves that we see in the vector graphics formats.

Markup languages (i.e. Hypertext Markup Language [HTML], Extensible Markup Language [XML]) and style sheets (i.e. Cascading Style Sheets [CSS]) has dominated the way developers layout and style contents.
Over the years, technologies like Unity UI Toolkit has evolved in the game industry to adopt the same pattern but with a user friendly editor, allowing users to layout content using a drag and drop manner while styling their content using sliders, color pickers, and input fields @jacobsen2023.
While this improves the user experience of content creation, it lacks the capability of integrating logic and custom contents right inside the user interfaces.
These features are often delegated to the programmer which can lead to unintended miscommunications.

== Problem Statement

=== Scalability, precision, and animation

#figure(caption: [Vector vs Bitmap graphics @arneratermanis2017])[#image(
    "assets/vector-vs-raster.png",
    width: 90%,
  )] <vector-vs-raster>

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

Complex content and logic would not be possible through a typical WYSIWYG editor.
For instance, it is virtually impossible to author a custom polygon shape in the editor with custom math based animation which depends on a time value.
This can only be achieved through code, and is often limited by the application programming interface (API) layer provided by the WYSIWYG editor.
This creates a huge distinction between the game/UI logic and the visual representation that is needed to convey the messages.

While hot-reloading is applicable for the layout and styling (and simple logic to some extend) of a content.
A WYSIWYG editor would not be capable of hot-reloading complex logic as these can only be achieved using code, which in most cases, requires a re-compilation.
This could lead to frustration and lost of creativity due to the slow feedback loop.

== Project Aim

This project aims to empower creators to create rich and visually appealing content in games in an efficient and streamlined workflow, by allowing them to focus most of their time on the content instead of the technical details needed to achieve the look or feel that they envisioned.

== Research Objectives

// A minimum of three objectives and a maximum of four.
// Must be measurable

The objectives of this project are as follows:

+ To utilize Vello, a compute-centric vector graphics renderer for rendering animated and dynamic vector graphics content.
+ To create an intuitive and yet powerful (programmable) workflow for generating animated and dynamic content using Typst.
+ To allow creators to focus on the creative aspects of game development.
+ To implement radiance cascades, a technique that provides realistic lighting without sacrificing real-time performance.

== Scope

// Describes in detail tasks to be executed.
// Constraints regarding any part of the project development (e.g. size of system and technology).
// What will and will not be done as part of the project.

The scope of this project invovles making a game that utilizes 2 custom libraries (1 for global illumination and 1 for interactive vector graphics content).
The creation of the game will ensure that 2 of our libraries are production ready by the end of this project.

#box()[
  #table(
    columns: (auto, 1fr),
    table.cell(colspan: 2)[#align(center)[*Libraries (Crates)*]],

    [*Bevy Radiance Cascades\ (#bevy_rc)*],
    [A 2D global illumination solution for the Bevy game engine.],

    [#velyst], [An interactive Typst content creator using Vello and Bevy.],

    table.cell(colspan: 2)[#align(center)[*Game*]],

    [#lumina], [A 2D top down fast paced objective based PvPvE game.],
  )
]

=== Tasks to be executed:

+ Develop the #bevy_rc crate.
  + Develop the radiance cascades algorithm.
  + Implement radiance cascades into Bevy's 2D render graph.
  + Support emissive and translucent materials.
  + Support directional light beams / spot lights.
  + Support negative lighting effects (light consumption).
  + Support rim lighting for better visual effects.

+ Develop the #velyst crate.
  + Develop an integrated compiler for Typst content in Bevy.
  + Support hot-reloading of Typst content.
  + Support interactivity between Bevy and Typst.
  + Develop an easy-to-use workflow for UI creation using Typst.
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
  [*Compatibility*],
  [
    Our project uses multiple cutting-edge and innovative technologies.
    This means that some of the technologies we depend on might be experimental or have yet to stabilize.
    This makes it difficult to ensure cross platform / device compatibility for the systems we built.
    For example, Vello requires compute shaders to render vector graphics, which means it can only runs on newer versions of browsers that supports WebGPU.
  ],

  [*Limited\ Documentation*],
  [
    Because some of the technologies we use are experimental or less widely adopted, available documentation and community support may be limited.
    This slows down the development process as issues can be difficult to troubleshoot without established resources.
  ],

  [*Limited Resource*],
  [
    The project is subject to limitations in terms of budget, personnel, and time. Allocating sufficient resources to develop, test, and refine the workflow for real-time global illumination and vector graphics is crucial. Any constraints in these areas can impact the project's scope and delivery timeline.
  ],
)

=== What will be done in this project:

+ *Global illumination*:
  Our implementation of radiance cascades will support any kind of 2D shapes with emissive, translucent, and non-emissive color material.
  It is aimed to be a plug and play plugin.
  Users should be able to use it without the need to learn about complex configurations.

+ *Typst compiler*:
  A custom implementation of Typst compiler will be created to fit the purpose of real-time Typst content rendering.
  This compiler should be able to re-compile Typst content on demand, allowing developers to view reflect their saved changes immediately.

+ *Dynamic vector graphics*:
  The #velyst crate will allow users to generate dynamic vector graphics content which is then rendered through the Vello renderer.

+ *Game demo prototype*:
  #lumina will be developed to showcase all of the above in a compact game format.
  Players will experience realistic and beautiful 2D lighting, as well as interactive vector graphics UI elements.

=== What will not be done in this project:

+ *No reflections & refractions*:
  Radiance cascades by default does not support reflections and refractions.
  Implementing these 2 features requires a tremendous amount of additional research, experimentation, and effort.
  Not to mention that implementing radiance cascades itself can already be extremely challenging as an individual working in such time constrait.

+ *Not creating an animation library*:
  An animation library involves preparing a huge variety of common animation effects.
  This takes a huge amount of time which does not fit the goal and scope of this project.
  To understand more about animation libraries, we strongly encourage you to look into the _Bevy MotionGfx_ project.

+ *Not a commercial game*:
  Our goal with #lumina is to create a game that demonstrates our technologies --- #velyst and #bevy_rc.
  It is not meant to be on par with a full on commercial game.

== Potential Benefit

=== Tangible Benefit

=== Intangible Benefit

=== Target User

#velyst will particularly be targeted towards UI/UX developers, motion graphics creators, and vector graphics enthusiasts.
#bevy_rc will be targetted towards visual effects (VFX) artists, game programmers, and technical artists.
Because these technologies are built on top of Rust and Bevy, the general users will come from the Rust + Bevy community.

As for #lumina, the target audience are gamers who loves fast paced multipalyer games like _Apex Legends_ and _Astro Duel 2_.
It will particularly appeal to gamers who love the mix of competitive PvP and PvE like _Destiny 2_′s Gambit game mode and _World War Z_.

== Overview of the IR

== Project Plan

= Literature Review

== Domain Research

=== Vector Graphics

Scanline rendering is the process of shooting rays from one side of the screen to the other while coloring pixels in between based on collision checkings with paths in between.
A GPU based scanline rasterization method is proposed by parallelizing over _boundary fragments_ while bulk processing non-boundary fragments as horizontal spans @li2016efficient.
This method allows fully animated vector graphics to be rendered in interactive frame rates.

Apart from scanline rasterization, tesselation method can also be used to convert vector graphics into triangles and then pushed to the GPU for hardware accelerated rasterization.
#cite(<loop2005resolution>, form: "prose") further improved this method by removing the need of approximating curve segments into lines.
Instead, each curve segments is evalulated in a _fragment shader_ which can be calculated on the GPU.
This allows for extreme zoom levels without sacrificing qualities.

Re-tesselation of vector graphics can be computationally expensive, especially when it's inherently a serial algorithm that often needs to be solved on the CPU.
#cite(<kokojima2006resolution>, form: "prose") combines the work of #cite(<loop2005resolution>, form: "prose") with the usage of GPU's stencil buffer by using _triangle fans_ to skip the tesselation process.
This approch, however, does not extend to cubic Bézier segments as they might not be convex.
#cite(<rueda2008gpu>, form: "prose") addressed this issue by implementing a fragment shader that evaluates the implicit equation of the Bézier curve to discard the pixels that fall outside it.
The two-step "Stencil then Cover" (StC) method builds upon all of these work and unified path rendering with OpenGL's shading pipeline --- #text(font: "Consolas")[NV_path_rendering] @kilgard2012gpu.
This library was further improved upon by adding support for transparency groups, patterns, gradients, more color spaces, etc. @batra2015accelerating.
It was eventually integrated into Adobe Illustrator.

// TODO: Vector textures
// TODO: Other solutions as well (Skia, Pathfinder, etc.)

/*
Vector Graphics
- Scanline
- Triangulation
- Stencil then Cover (StC)
- Further improved and applied to real world application like Adobe Illustrator
- ^ Composition, Gradients
- Vector texture
- Massively parallel
*/

=== Interactive UI/UX

Beneath all graphical interfaces lies the underlying code that structure and renders the visual elements.
The two most notable approach towards creating user interface frameworks are immediate-mode graphical user interface (IMGUI) and retained-mode graphical user interface (RMGUI).
Some popular IMGUI frameworks includes Dear IMGUI and egui @imgui @egui, while some popular RMGUI frameworks includes Xilem @xilem.
Although powerful, these UI frameworks strongly relies on hardcoded programming.

Enter the web technologies.
Modern browsers typically render UI elements using markup languages like HTML and SVG for structuring the content and style-sheets like CSS for styling them.
The use of markup structures allows developers to fully separate their UI layout from the codebase, simplifying the identification and management of UI components.
With style sheets, developers can create, share, and reuse templates, enhancing consistency and streamlining the design process throughout the application.
// TODO: explore in more detail on each framework
Notable frameworks that utilizes this model includes Unity UI Toolkit, React, Vue, etc @jacobsen2023 @react @vue.

Markup languages also give rise to many WYSIWYG editors.
These editors let users perform drag and drop actions to layout UI for quick prototyping as each components can now be represented using only markup syntax (no code required).

A major limitation of simple markup languages like HTML is that structure changes can only be achieved through code.
For example, if you want a form to disappear after button press, you would need to alter the HTML via code.
Typst offers an alternative towards this problem by introducing programming capabilities into markdown.

Typst is a competitor of LaTeX, designed to simplify the typesetting process with a modern and intuitive approach.
Unlike its predecessors, Typst can directly embed logic.
Using the previous example, developers would only need to pass in a boolean value and Typst will automatically exclude the form from being in the layout at all.
This currently works only in theory, as Typst is primarily a document generator without a user-friendly interface for modifying defined variables.

/*
Interactive UI/UX
- From code to markup to css styling
- Research on WYSIWYG editors
- Explore competitors: LaTeX
*/

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
