#import "keywords.typ": *
#import "monokai_pro.typ": *

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
        \`#body\`
      ],
    ),
  )
}

#let struct = text(fill: red)[*`struct`*]

= Design and Implementation

== Introduction

This project is split into two parts: #velyst and the integration proof-of-concept --- #lumina.
Velyst is created as a separated Rust crate that is completely independent of Lumina.
Lumina utilizes the Velyst crate for all (or at least most) of its UI/UX creation.
This includes titles, buttons, labels, icons, in-game overlay, and many more!

Velyst is an interactive Typst content creator using Vello as the renderer and Bevy as the game engine for driving logic and user interactions.
At it's core, Velyst aims to simplify the integration of Typst into the Bevy game engine.
The goal is to allow developers to create dynamic vector graphics content using Velyst.
Velyst can also be used in combination with other technologies such as SVG and Lottie files.
Developers and artists will be able to leverage the full capability of Typst for authoring logic and animation directly inside the language.
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
    Velyst expects developers to create functions in the Typst source file (`.typ`) and call them within Rust.
    This is particularly repetitive as users will need to constantly define the function name and arguments.
    Velyst makes this simple by introducing a procedural macro for handling all these on a normal Rust #struct.
  ],

  [Auto Compilation],
  [
    This ties hand-in-hand with the function macros, all #struct that derive the function macro will automatically be eligible for the auto compilation process.
  ],

  [Auto Layout],
  [
    Once the compilation is complete Velyst will automatically layout the compiled content.
    The layouted content will result in a Typst frame which can then be converted into a Vello scene.
  ],

  [Rendering],
  [
    The converted Vello scene is automatically rendered onto the screen with the help of the Bevy Vello crate.
  ],
)


Concurrent with the development of Velyst, the Lumina game is being built to investigate Velyst’s potential use cases in a real world production scenario.
Lumina is continuously used as a testbed for refining the architecture and features of Velyst.
In other words, Lumina pushes the boundaries of what Velyst can do, driving innovation and informing its development direction.

The following sections will dive into the design architecture of Velyst and how it is being integrated into the Lumina game.
We will also briefly dive into how Lumina works to provide a better overall understanding of the underlying systems.

#pagebreak()

== Design
