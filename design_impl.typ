#import "keywords.typ": *
#import "monokai_pro.typ": *
#import "utils.typ": *

#show raw.where(block: false): body => {
  box(
    move(
      dy: -0.1em,
      box(
        fill: base1,
        outset: (y: 0.4em),
        inset: (x: 0.2em),
        radius: 0.3em,
      )[
        #let fill = if text.fill != black { text.fill } else { base8 }
        #set text(fill: fill, size: 0.9em, font: "Consolas")
        #strong[\`#body\`]
      ],
    ),
  )
}

= Design and Implementation

== Introduction

#[
  #set align(center)
  #stack(dir: ltr, spacing: 3em)[
    #figure(caption: [Velyst Logo])[
      #image(
        "assets/velyst.svg",
        width: 20%,
      )
    ] <velyst-logo>
  ][
    #figure(caption: [Lumina Logo])[
      #box(
        width: 20%,
        radius: 100%,
        clip: true,
        image("assets/lumina.png"),
      )
    ] <lumina-logo>
  ]
]

This project is split into two parts: #velyst and the integration proof-of-concept --- #lumina.
Velyst is created as a separated Rust crate that is completely independent of Lumina.
Lumina utilizes the Velyst crate for all (or at least most) of its UI/UX creation.
This includes titles, buttons, labels, icons, in-game overlay, and many more!

Velyst is an interactive Typst content creator using Vello as the renderer and Bevy as the game engine for driving logic and user interactions.
At it's core, Velyst aims to simplify the integration of Typst into the Bevy game engine.
The goal is to allow developers to create dynamic vector graphics content using Velyst.
Velyst can also be used in combination with other technologies such as SVG and Lottie files.
Developers and artists will be able to leverage the full capabilities of Typst for authoring logic and animation directly inside the language.
Below is a table of developer productivity tools developed inside Velyst to streamline the workflow:
#table(
  columns: (auto, auto),
  [Hot-reloading],
  [
    Whenever the Typst source file changes, it will automatically be re-evaluated on the fly.
    The evaluated source file will produce an accelerated data structure for compilation and layouting at a later phase.
  ],

  [Function Macros],
  [
    Velyst expects developers to create functions in the Typst source file and run them within Rust.
    This is particularly repetitive as users will need to constantly define the function name and arguments.
    Velyst makes this simple by introducing a procedural macro for handling all these on a normal Rust ```rs struct```.
  ],

  [Auto Compilation],
  [
    This ties hand-in-hand with the function macros, all ```rs struct``` that derive the function macro will automatically be eligible for the auto compilation process.
  ],

  [Auto Layout],
  [
    Once the compilation is complete Velyst will automatically layout the compiled content.
    The layouted content will result in a Typst frame which can then be converted into a Vello scene.
  ],

  [Rendering],
  [
    The converted Vello scene is automatically rendered onto the screen with the help of the Bevy Vello crate.
    It utilizes the GPU for accelerated vector graphics rendering.
  ],
)

Concurrent with the development of Velyst, the Lumina game is being built to investigate Velyst’s potential use cases in a real world production scenario.
Lumina is a fast paced, top down, 2D, objective based, player versus player (PvP) game.
In the game, players pilot spaceships to complete objectives by depositing lumina into the tesseract to push the tesseract meter.
Players of different teams can also eliminate each other during the match in an attempt to obtain an upper hand.
To win the game, one team will need to push the tesseract meter completely towards the opposing side to obtain total dominance.

The game is heavily physics-driven, with each spaceship consisting of a physics body that interacts dynamically with the environment.
It employs client-side prediction to ensure seamless and responsive physics interactions, maintaining a smooth gameplay experience.
To uphold fair play, all predictions are validated against the server, enabling a fully server-authoritative system that prevents cheating.

Lumina will also employ a custom implementation of global illumination solution using the Radiance Cascades method (Osborne & Sannikov, 2024).
Unlike most 2D games, this game does not use any point or spot lights to illuminate the scene.
Instead, it relies on emissive materials in the scene.
The algorithm will be developed using compute shaders and runs entirely on the GPU.

Lumina features four different levels:
#table(
  columns: (auto, auto),
  [Local Lobby], [Loaded when the player first enters the game.],
  [Multiplayer Lobby], [The waiting area when player enters matchmaking.],
  [Sandbox],
  [Playground and tutorial level where player can get to know the game better.],

  [Abandoned Factory],
  [The in-game map of the game where the deathmatch happens.],
)

Lumina is continuously used as a testbed for refining the architecture and features of Velyst.
In other words, Lumina pushes the boundaries of what Velyst can do, driving innovation and informing its development direction.

The following sections will dive into the design architecture of Velyst and how it is being integrated into the Lumina game.
We will also briefly dive into how Lumina works to provide a better overall understanding of the underlying systems.

#pagebreak()

== Design

=== Velyst Architecture

#figure(caption: [Velyst Architecture])[
  #set align(center)
  #diag_world[

    #cell_diag(
      blob(
        (0, 0),
        cell_diag(
          node((0, 0), [Typst World]),
          blob((0, 1), [Files #emoji.filebox], width: 7em),
          blob((1, 1), [Library #emoji.notebook], width: 7em),
          blob((0, 2), [Fonts #emoji.abc], width: 7em),
          blob((1, 2), [Datetime #emoji.clock], width: 7em),
        ),
        tint: green,
        shape: rect,
      ),

      dotted_blob(
        (2, 0),
        [ROUTINES],
        width: 8em,
        height: 6em,
        tint: base6,
      ),
      edge("ll", "[]-[]"),
      edge("d,l,d", "[]-[]"),
      edge("d,r,d", "[]-[]"),
      blob(
        (1, 2),
        [Evaluate],
        tint: blue.mix(green).desaturate(70%),
        shape: octagon,
      ),
      blob(
        (3, 2),
        [Layout],
        tint: blue.mix(green).desaturate(70%),
        shape: octagon,
      ),

      blob(
        (0, 2),
        [
          Source File #source_file_icon\
          e.g. "main.typ"
        ],
        tint: blue.mix(purple).desaturate(70%),
      ),
      edge("r", "-|>", label: align(center)[Async\ Load], label-side: center),
      blob((1, 3), [Module], tint: blue),
      edge("ddd", "-|>", label: [Extract], label-side: center),
      edge("u", "<|-"),
      blob((1, 6), [Func], tint: red, shape: hexagon),
      edge("r,uu", "-|>", label: [Pack], label-pos: 0.25, label-side: center),
      blob((2, 4), [Content], tint: yellow, shape: house),
      edge("uu,r", "-|>"),

      blob((3, 3), [Frame], tint: purple),
      edge(
        "ddd",
        "-|>",
        label: [Post-process\*\ + Convert],
        label-side: center,
      ),
      edge("u", "<|-"),
      blob((3, 6), [Vello Scene], tint: orange),
    )

    #set align(left)
    #text(size: 0.8em)[_\* indicates optional steps._]
  ]
] <velyst-architect>

@velyst-architect illustrates the architecture of #velyst, detailing the process of transforming a Typst source file into a Vello scene.

#diag_world[
  #cell_diag(blob((0, 0), [Typst World], tint: green))
]

Velyst depends strongly on the Typst world for providing the four foundation pillars:
+ *Files*: Responsible for loading and cache the \*.typ source files and other assets, for instance, images, vector graphics, tables, etc.
+ *Library*: The Typst standard library and user defined variables and functions.
+ *Fonts*: Keeps track of all the fonts available to the compiler.
+ *Datetime*: Provide the current date and time, down to the second!

#box[
  #diag_world[
    #cell_diag(dotted_blob((0, 0), [ROUTINES], tint: base6))
  ]

  The Typst compiler also stores a number of "routinely" used methods inside a static global variable --- `ROUNTINES`.
  Amongst them, the evaluate --- ```rs eval(..)``` and layout --- ```rs layout_frame(..)``` method is used extensively inside the Velyst pipeline.
]

#let pipeline_colors = (blue, purple, orange)
#diag_world[
  #cell_diag(gradient_blob((0, 0), [Pipeline], pipeline_colors))
]

#let mod = text(blue)[`Module`]
#let cont = text(yellow)[`Content`]
#let frame = text(purple)[`Frame`]
#let vello_scene = text(orange)[`VelloScene`]

The Velyst pipeline might vary slightly depending on the use case.
However, in most scenarios, it begins with creating a native Typst source file within the assets folder.
This source file will be loaded asynchronously into Bevy at runtime through the Bevy asset pipeline.
Once loaded, the Typst compiler _evaluates_ the source file into a #mod, containing everything defined within it.

Velyst allow developers to run any functions defined in the Typst source file.
During this phase the chosen Typst function will be extracted from the #mod and then packed into a #cont data structure.
The #cont is later being used to _layout_ into a #frame.
Lastly, the developers can apply any final post-process needed to the #frame which will then be converted into a #vello_scene.

#info_box(
  underline[*What is a #cont?*],
  [
    A #cont is a universal "type" in Typst that packs the information needed to create a renderable #frame view.
    It can be created completely from scratch in Rust or compiled from markdown.
    On rare occasions where developers need to create a #frame completely in the Rust language, they can do so by creating a #cont.
    In addition to that, developers can also modify the generated #cont from the Typst source file by appending more #cont\s, or adding custom styling rules.
    For this exact use case, Velyst also provides a utility crate called *_Typst Element_*.
  ],
)

#info_box(
  underline[*What is a #frame?*],
  [
    A #frame is a vector graphics format created by _laying out_ a #cont.
    It primarily consists of the shapes, texts, fills, and strokes needed to draw the vector graphics content.
    This also means Velyst can use any rendering backend, with Vello being the one currently in use.
    Velyst also offers a simple post-processing step that developers can apply to a #frame for direct vector graphics manipulation.
  ],
)

=== Integration with Bevy's ECS World

It is crucial for the #velyst architecture to integrate seamlessly with Bevy's ECS world which is responsible for managing the entire game logic.
