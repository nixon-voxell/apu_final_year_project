#import "keywords.typ": *

= Literature Review

== Introduction

Vector graphics are increasingly valuable in game development due to their scalability and precision, yet their integration into real-time game engines involves distinct technical challenges.
Unlike raster images, which degrade when resized, vector graphics are resolution-independent, making them ideal for various screen sizes and resolutions.
This advantage, however, comes at the cost of more complex rendering requirements, as vector graphics must undergo a rasterization phase to translate their shapes into pixels for display.
The demands of real-time rendering make this process particularly intricate, as maintaining both high visual quality and performance can be challenging.

To address the performance demands of rasterization in game engines, various rendering techniques have been developed to streamline this process.
Efficient rasterization methods help achieve the fast rendering speeds required for interactive applications, while ensuring that image quality remains high.
Techniques focused on converting vector shapes into compatible formats for real-time processing have allowed developers to create more responsive and visually detailed graphics without a loss in performance.
These approaches improve frame rates and visual fidelity, making vector graphics a practical choice in game settings where performance is essential.

In addition to advances in rasterization, the tools used for creating and managing graphical content have also evolved.
Modern UI frameworks play a foundational role in constructing interactive experiences, providing developers with ways to structure and style visual elements effectively.
The shift towards markup languages and programmable typesetting has made it easier for teams to collaborate and iterate on designs, fostering a more flexible workflow.
This evolution has supported the creation of more dynamic visual components that can be reused and customized, enhancing user engagement and experience.

This review provides a foundation for analyzing the technical aspects of vector graphic rasterization and content creation tools, highlighting how these technologies can drive efficiency, scalability, and visual impact in game design and interactive media.

#pagebreak()

== Domain Research

=== Rasterization of vector graphics

Vector graphics are often used in situations where scalability and precision are essential.
This property comes with a cost.
As mentioned in the previous chapter, rendering vector graphics in today's era requires a rasterization phase.
Solving for this phase is non-trivial as it is often required to compute a partial differential equation (PDE) @tian2022survey.
Scanline rendering is the process of shooting rays from one side of the screen to the other while coloring pixels in between based on collision checkings with paths in between.
A GPU based scanline rasterization method is proposed by parallelizing over boundary fragments while bulk processing non-boundary fragments as horizontal spans @li2016efficient.
This method allows fully animated vector graphics to be rendered in interactive frame rates.

Apart from scanline rasterization, tesselation method can also be used to convert vector graphics into triangles and then pushed to the GPU for hardware accelerated rasterization.
#cite(<loop2005resolution>, form: "prose") further improved this method by removing the need of approximating curve segments into lines.
Instead, each curve segments is evalulated in a fragment shader which can be calculated on the GPU.
This allows for extreme zoom levels without sacrificing qualities.

Re-tesselation of vector graphics can be computationally expensive, especially when it's inherently a serial algorithm that often needs to be solved on the CPU.
#cite(<kokojima2006resolution>, form: "prose") combines the work of #cite(<loop2005resolution>, form: "prose") with the usage of GPU's stencil buffer by using triangle fans to skip the tesselation process.
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

#pagebreak()

=== Graphical interface content creation

Beneath all graphical interfaces lies the underlying code that structures and renders the visual elements.
The two most notable approach towards creating user interface frameworks are immediate-mode graphical user interface (IMGUI) and retained-mode graphical user interface (RMGUI).
Some open sourced IMGUI frameworks includes _Dear IMGUI_ and _egui_, while open sourced RMGUI frameworks includes _Xilem_ and _Qt_.
Although powerful, these UI frameworks strongly relies on hardcoded programming as shown in @egui-code and @xilem-code.

#figure(supplement: "Code", caption: "Egui code example")[
  ```rs
  ui.heading("My egui Application");
  ui.horizontal(|ui| {
    ui.label("Your name: ");
    ui.text_edit_singleline(&mut name);
  });
  ui.add(egui::Slider::new(&mut age, 0..=120).text("age"));
  if ui.button("Increment").clicked() {
    age += 1;
  }
  ui.label(format!("Hello '{name}', age {age}"));
  ui.image(egui::include_image!("ferris.png"));
  ```
] <egui-code>

#figure(supplement: "Code", caption: "Xilem code example")[
  ```rs
  struct AppData {
    count: u32,
  }

  fn count_button(count: u32) -> impl View<u32, (), Element = impl Widget> {
    Button::new(format!("count: {}", count), |data| *data += 1)
  }

  fn app_logic(data: &mut AppData) -> impl View<AppData, (), Element = impl Widget> {
    Adapt::new(|data: &mut AppData, thunk| thunk.call(&mut data.count),
      count_button(data.count))
  }
  ```
] <xilem-code>

Enter the web technologies.
Modern browsers typically render UI elements using markup languages like Hyper Text Markup Language (HTML) and Scalable Vector Graphics (SVG) for structuring the content and style-sheets like Cascading Style Sheets (CSS) for styling them as shown in @html-code and @css-code.
The use of markup structures allows developers to fully separate their UI layout from the codebase, simplifying the identification and management of UI components.
With style sheets, developers can create, share, and reuse templates, enhancing consistency and streamlining the design process throughout the application.

#align(center)[
  #grid(
    columns: (auto, auto),
    gutter: 6pt,
    align: bottom,
    [
      #figure(supplement: "Code", caption: "HTML example")[
        ```html
        <!DOCTYPE html>
        <html>
        <head>
          <link rel="stylesheet" href="styles.css">
        </head>
        <body>

        <h1>This is a heading</h1>
        <p>This is a paragraph.</p>

        </body>
        </html>
        ```
      ] <html-code>
    ],
    [
      #figure(supplement: "Code", caption: "CSS example")[
        ```css
        /* styles.css */
        body {
          background-color: powderblue;
        }
        h1 {
          color: blue;
        }
        p {
          color: red;
        }
        ```
      ] <css-code>
    ],
  )
]


Markup languages also give rise to many WYSIWYG editors.
These editors let users perform drag and drop actions to layout UI for quick prototyping as each components can now be represented using only markup syntax (no code required).
An example of this framework's application within a game engine is the _Unity UI Toolkit_, which employs it to power its UI editor @jacobsen2023.

A major limitation of simple markup languages like HTML is that structural changes can only be achieved through code.
These features are often delegated to the programmer which can lead to unintended miscommunications.
For example, if you want a form to disappear after button press, you would need to alter the HTML via code.
Typst offers an alternative towards this problem by introducing programming capabilities into markdown @madje2022programmable.

#figure(supplement: "Code", caption: "Typst example")[
  ```typ
  #let values = (1, 2, 3, 4)
  #values.pop() \
  #values.len() \

  #("a, b, c"
      .split(", ")
      .join[ --- ])

  #"abc".len() is the same as
  #str.len("abc")
  ```
] <typst-code>

Typst is a competitor of LaTeX, designed to simplify the typesetting process with a modern and intuitive approach.
Unlike its predecessors, Typst can directly embed logic (@typst-code).
Using the previous example, developers would only need to pass in a boolean value and Typst will automatically exclude the form from being in the layout at all.
In the Typst ecosystem, developers gain enhanced flexibility by sharing their work as packages.
Unlike templates, Typst packages support complex scripting, offering greater adaptability and expanded functionality.

/*
Interactive UI/UX
- From code to markup to css styling
- Research on WYSIWYG editors
- Explore competitors: LaTeX
*/

#pagebreak()

=== Summary of key findings

The exploration of rasterization techniques for vector graphics underscores the complexity and potential of rendering mathematically defined shapes in real-time applications.
Vector graphics are valued for their scalability and precision, but rendering them on modern displays requires the conversion into pixel-based formats through processes like scanline rendering and tessellation.
These techniques, while effective in achieving interactive frame rates, often come with significant computational costs.
Innovations such as GPU-based scanline rasterization, which parallelizes boundary fragments, and advanced methods like Stencil then Cover (StC), have enabled more efficient rendering.
Additionally, the development of fragment shaders for evaluating curves at extreme zoom levels enhances the ability to handle vector graphics without sacrificing quality, illustrating the evolving landscape of vector graphics rendering in computational graphics.

In the domain of graphical interface content creation, the use of markup languages like HTML, SVG, and CSS has revolutionized the way user interfaces are structured and styled.
These technologies allow for the separation of content from design, simplifying the creation, management, and customization of user interfaces.
However, challenges remain in introducing dynamic interactivity and structural changes without relying on code, a limitation addressed by systems like Typst, which introduces programming capabilities directly into the markup.
Typst’s approach enables greater flexibility by supporting complex scripting and packages, offering a significant improvement over traditional methods.
This shift towards more programmable, reusable, and adaptable UI frameworks opens new possibilities for creating responsive and user-driven interfaces in modern applications.

Altogether, advancements in both rasterization and content creation tools continue to drive the development of modern game environments.
As these technologies progress, game engines can offer more sophisticated and seamless graphical experiences, enabling developers to balance aesthetic quality with technical efficiency and bringing richer visual and interactive elements into the gaming space.

#pagebreak()

== Similar Systems/Works

=== Unity UI Toolkit

=== LaTeX

=== React

== Technical Research

=== Bevy

=== Vello

=== Typst
