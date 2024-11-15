#import "keywords.typ": *

= Literature Review

== Domain Research

=== Introduction

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

=== Rasterization of vector graphics

Vector graphics are often used in situations where scalability and precision are essential.
This property comes with a cost.
As mentioned in the previous chapter, rendering vector graphics in today's era requires a rasterization phase.
Solving for this phase is non-trivial as it is often required to compute a partial differential equation (PDE) @tian2022survey.

One method for rasterizing vector graphics is scaline rendering.
Scanline rendering is the process of shooting rays from one side of the screen to the other while coloring pixels in between based on collision checkings with paths in between.
A GPU based scanline rasterization method is proposed by parallelizing over boundary fragments while bulk processing non-boundary fragments as horizontal spans @li2016efficient.
This method allows fully animated vector graphics to be rendered in interactive frame rates.

#figure(caption: [Tesselation with shader evaluated curves @loop2005resolution])[
  #image("assets/loop-blinn.png", width: 340pt)
] <loop-blinn>

Apart from scanline rasterization, tesselation method can also be used to convert vector graphics into triangles and then pushed to the GPU for hardware accelerated rasterization.
#cite(<loop2005resolution>, form: "prose") further improved this method by removing the need of approximating curve segments into lines.
Instead, each curve segments is evalulated in a fragment shader which can be calculated on the GPU, as shown in @loop-blinn.
This allows for extreme zoom levels without sacrificing qualities.

#figure(caption: [Triangle fans @kokojima2006resolution])[
  #image("assets/triangle-fan.png", height: 240pt)
] <triangle-fan>

Re-tesselation of vector graphics can be computationally expensive, especially when it is inherently a serial algorithm that often needs to be solved on the CPU.
#cite(<kokojima2006resolution>, form: "prose") combines the work of #cite(<loop2005resolution>, form: "prose") with the usage of GPU's stencil buffer by using triangle fans to skip the tesselation process as shown in @triangle-fan.
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

=== Immediate mode and retained mode

Beneath all graphical interfaces lies the underlying code that structures and renders the visual elements.
The two approaches towards creating user interface frameworks are immediate-mode graphical user interface (IMGUI) and retained-mode graphical user interface (RMGUI).
Some open sourced IMGUI frameworks includes Dear ImGui and Egui, while open sourced RMGUI frameworks includes Xilem and Qt.
Although powerful, these UI frameworks strongly relies on hardcoded programming.
In retained-mode, the application attempts to retain its previous state as much as possible and only perform changes when necessary.
In contrast, the immediate-mode application reconstruct its frame in every update with no states stored in between frames @rmguivsimgui2019.
This makes retained-mode useful for applications that does not require high dynamic changes or devices that require low power consumption and vice versa @rmvsim2021.
In the article by #cite(<rmguivsimgui2019>, form: "prose"), the authors also stated that while retained-mode APIs are generally easier to use, they often come with higher memory demands and offer less flexibility than their immediate-mode counterparts.

#figure(supplement: "Code", caption: "Egui code example (imperative)")[
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

#figure(supplement: "Code", caption: "Xilem code example (declarative)")[
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

In practice, IMGUI is imperative and RMGUI is declarative as shown in @egui-code and @xilem-code.
In imperative programming, developers define each step needed for a program to reach the desired state, specifying precisely how to display UI components.
Declarative programming, on the other hand, allows developers to describe what should be displayed without detailing how to achieve it.
Declarative frameworks often rely on underlying imperative code to translate high-level commands into step-by-step instructions for execution @impvdecl2022.
While imperative programming allows programmers to have complete control over system resources, it would eventually lead to higher complexity as projects scale, increasing the risk of bugs.
In contrast, declarative programming minimizes state mutability by favoring more sophisticated constructs like pipelines and work graphs, which leads to better scalability to larger projects.
However, it is important to understand the performance overhead and higher learning curve that comes with declarative programming @impvdecl2024.

#pagebreak()

=== Markup languages for graphical interface content creation

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
An example of this framework's application within a game engine is the Unity UI Toolkit, which employs it to power its UI editor @jacobsen2023 @unityuicomparison.

A major limitation of simple markup languages like HTML is that structural changes can only be achieved through code @mdvsmu2023.
These features are often delegated to the programmer which can lead to unintended miscommunications.
For example, if you want a form to disappear after button press, you would need to alter the HTML via code.
Typst offers an alternative towards this problem by introducing programming capabilities into markup @madje2022programmable.

#figure(supplement: "Code", caption: "LaTeX example")[
  ```latex
  \documentclass{article}
  \begin{document}
  First document. This is a simple example, with no
  extra parameters or packages included.
  \end{document}
  ```
] <latex-code>

Typst is a competitor of LaTeX (@latex-code), designed to simplify the typesetting process with a modern and intuitive approach.
Unlike its predecessors, Typst can directly embed logic (@typst-code).
Using the previous example, developers would only need to pass in a boolean value and Typst will automatically exclude the form from being in the layout at all.
In the Typst ecosystem, developers gain enhanced flexibility by sharing their work as packages.
Unlike templates, Typst packages support complex scripting, offering greater adaptability and expanded functionality.

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
As these technologies progress, game engines can offer more sophisticated and seamless graphical experiences, enabling developers to balance aesthetic quality with technical efficiency and bringing richer visual and interactive elements into games.

#pagebreak()

== Similar Systems/Works

=== Unity UI Toolkit

#figure(caption: "Unity UI Toolkit Screenshot")[
  #grid(
    columns: (auto, auto),
    align: horizon + center,
    gutter: 10pt,
    image("assets/unity-game-engine-icon.svg", width: 40pt),
    image("assets/unity-ui-tookit.png"),
  )
] <unity-ui-toolkit>

The Unity UI Toolkit shown in @unity-ui-toolkit is a retained mode WYSIWYG editor, developed for the Unity3D Engine for editor GUI and runtime UI creation @kok2021custom.
It uses a markup language called Unity Extensible Markup Language (UXML) to define the UI structure @uxml.
UXML is highly inspired by languages like HTML, Extensible Application Markup Language (XAML), and Extensible Markup Language (XML).
The UXML is tailored in such a way that is efficient to work with the Unity game engine.

#align(center)[
  #grid(
    columns: (auto, auto),
    align: bottom,
    gutter: 10pt,
  )[
    #figure(supplement: "Code", caption: "UXML example")[
      ```html
      <?xml version="1.0" encoding="utf-8"?>
      <ui:UXML ...>
        <Style src="<path-to-file>/styles.uss" />
        <ui:VisualElement name="root" />
      </ui:UXML>
      ```
    ] <uxml-code>
  ][
    #figure(supplement: "Code", caption: "USS example")[
      ```css
      /* styles.uss */
      #root {
        width: 200px;
        height: 200px;
        background-color: red;
      }
      ```
    ] <uss-code>
  ]
]

The Unity3D team also developed a modified CSS language called Unity Style Sheet (USS) and Theme Style Sheet (TSS) to style UIs that are structured via UXML @uss, @tss.
TSS is just a slight variant of USS in that it is solely responsible for the overall theme that the application falls back to when there is no USS or inline styling.
An example of UXML and USS is shown in @uxml-code and @uss-code.
Users can create custom visual elements in C\# and use it in UXML.
The USS can be reused across multiple UXML and can even be imported into other USS files.
This prevents duplicate work and helps keep the user interface consistent across the application.

The Unity UI Toolkit also improves collaboration between artists and developers.
With UI Toolkit, artists focus on UXML and USS files, handling design elements like colors and materials, while developers add behaviors and interactions exclusively through code, without modifying the design files.
This separation of logic and style streamlines merging and makes style adjustments more efficient.
For example, changing project-wide fonts only requires editing Panel Settings instead of individual assets.
UI Builder further assists by providing a visual interface that allows artists and designers to create and edit UI without coding, enhancing teamwork and organization for larger projects.

#pagebreak()

=== Egui

#figure(caption: [Egui Demo @eguiframework2023])[
  #image("assets/egui-demo.png")
] <egui-demo>

Egui is an easy-to-use immediate mode GUI in Rust that runs on both web and native.
It is extremely lightweight and offers numerous graphics tools for the creation of GUI with minimal effort as shown in @egui-demo.
Some examples include graph plotting, text input, sliders, scroll view, painting, etc.
Egui is a cross-platform UI library @startegui2023.
#cite(<startegui2023>, form: "prose") noted in the article that Egui is built on top of WebGPU technology.
This enables it to run on both native platforms like Windows, Linux, and Mac, as well as in the browser, in the form of Web Assembly (WASM).
Users can also integrate it into custom or existing game engines, custom native applications, web applications, etc.
It is also highly inspired by Dear ImGui from the C++ world @tryingegui2024.

Moreover, Egui supports extensibility by allowing users to create and integrate custom components, providing additional flexibility and customization options.
When it comes to drawing capabilities, Egui offers built-in support for rendering vector graphics, including complex elements like Bézier curves, basic shapes, and geometric primitives, as noted by #cite(<startegui2023>, form: "prose").
This feature set enables developers to design visually engaging and highly interactive interfaces, suitable for both simple and complex applications, while maintaining Egui's lightweight footprint and ease of use.

#pagebreak()

=== Strengths and Weaknesses

The Unity UI Toolkit and Egui are two distinctive GUI frameworks with specific strengths and weaknesses, tailored to different development environments.
The Unity UI Toolkit is a retained mode, WYSIWYG editor designed for Unity3D, whereas Egui is an immediate mode GUI built in Rust, emphasizing simplicity and flexibility across platforms.

_*Unity UI Toolkit*_

One of the primary strengths of the Unity UI Toolkit lies in its structured, markup-based approach, which leverages the UXML and USS languages.
UXML’s structure-based syntax is inspired by web languages like HTML and XAML, making it relatively accessible for developers familiar with web-based frameworks.
This setup allows for clear separation between structure and styling, which is further enhanced by the USS and TSS.
Such separation enables efficient style reuse and consistent design application across multiple UI components, avoiding redundant work and maintaining visual coherence.
Moreover, _UI Toolkit_’s integration with Unity’s _UI Builder_ makes it a practical choice for artist-developer collaboration; it allows designers to construct interfaces visually, without needing to edit the underlying code.
This, along with its retained mode nature, means developers can focus more on event-driven logic and less on rendering details, which can simplify UI maintenance and readability.

However, the Unity UI Toolkit has notable limitations.
The framework’s retained mode design, though powerful, can be more memory-intensive than immediate mode approaches, impacting performance in highly dynamic or resource-constrained applications.
Additionally, since the UI Toolkit is specialized for Unity, it lacks portability outside the Unity ecosystem, restricting its utility for developers working across multiple engines or platforms.
Although it offers an accessible toolset for users within Unity, it may require more complex workflows to integrate into non-Unity environments.
Customization options are available through C\# for creating visual elements, yet the reliance on Unity-specific markup and styles can create a learning curve for developers unfamiliar with the Unity ecosystem.

_*Egui*_

Egui, in contrast, is an immediate mode GUI that stands out for its simplicity, light memory footprint, and versatility.
Written in Rust, Egui is designed to be cross-platform, operating seamlessly on both native environments (Windows, Linux, and macOS) and the web, thanks to its WebAssembly (WASM) compatibility.
The immediacy of Egui’s approach allows it to be incredibly lightweight; every frame is actively rendered, which can be ideal for applications requiring high responsiveness or frequent UI updates.
Its Rust-based design further enhances portability, enabling easy integration with various custom engines or standalone applications, making it suitable for projects not tied to a specific ecosystem.
Additionally, Egui supports vector graphic rendering, including shapes and Bézier curves, which, combined with customizable components, provides significant flexibility for developers creating interactive and visually dynamic UI.

However, Egui’s immediate mode nature can also present some challenges.
Immediate mode UIs often involve redrawing the entire UI each frame, which can become computationally intensive in complex interfaces, potentially leading to higher CPU usage.
While Egui is excellent for lightweight applications, it may not scale as efficiently for large-scale, interactive applications with many UI elements.
Furthermore, Egui lacks a visual editor, which can be a drawback for teams with designers who prefer WYSIWYG tools.
This absence means that UI creation and design adjustments must be handled directly in code, potentially complicating collaboration between designers and developers.

#pagebreak()

=== Conclusion

In summary, both frameworks offer valuable advantages within their respective domains.
Unity UI Toolkit excels within the Unity ecosystem, providing structured, easily manageable UI elements and a design-friendly interface that streamlines collaboration.
However, it is less portable and may consume more memory.
Meanwhile, Egui’s lightweight, immediate mode design and cross-platform flexibility make it highly suitable for Rust applications and custom engines, albeit with potential scalability and collaboration limitations for larger projects.
Both frameworks cater to different development needs, and choosing between them depends on the platform, performance requirements, and team workflow preferences.

#pagebreak()

== Technical Research

=== Bevy - Game Engine

#figure(caption: "Bevy Logo")[
  #image("assets/bevy_logo_light.svg")
]

According to the founder, #cite(<introbevy2020>, form: "prose"), Bevy is a refreshingly simple data-driven game engine and app framework built in Rust that is free and open-sourced.
It is designed to be modular with its robust plug-in system, simple to use with its Entity Component System (ECS), and fast with its multi-core utilization and parallel by default design.
In the article, the founder claim that Bevy's ECS is the most ergonomic ECS in existence @introbevy2020.
As shown in @bevy-code, users can create a fully working Bevy application with just a few lines of code:

#figure(supplement: "Code", caption: "Bevy example")[
  ```rs
  use bevy::prelude::*;

  #[derive(Component)]
  struct Position(f32);

  fn setup(mut commands: Commands) {
    commands.spawn(Position(0.0));
  }

  fn movement(mut q_positions: Query<&mut Position>, time: Res<Time>) {
    for mut pos in q_positions {
      pos.0 += 1.0 * time.delta_seconds();
    }
  }

  fn main() {
    App::build()
      .add_plugins(DefaultPlugins)
      .add_systems(Startup, setup)
      .add_system(Update, movement)
      .run();
  }
  ```
] <bevy-code>

Bevy is also cross platform.
It runs on Windows, MacOS, Linux, iOS, Android, and the web.
Although Bevy is relatively new compared to more established game engines like Unity or Unreal Engine --- having only been around for four years as of 2024 @bevybirthday2024 --- it has quickly gained attention for its modern, modular approach to game development.
As a result, there has already been many volunteer plug-ins being developed for the game engine.

Some notable plug-ins that will be used of this project are:

#figure(caption: "Notable Bevy plug-ins in this project")[
  #set par(justify: false)
  #table(
    columns: (auto, 1fr),
    align: left,
    table.header([*Plug-in*], [*Description*]),
    [Velyst], [The plug-in that we are going to develop in this project.],
    [Bevy Vello], [For renderingn vector graphics using Vello.],
    [Lightyear], [For multiplayer and networking.],
    [Bevy Enoki], [For particle effects.],
    [Leafwing Input Manager],
    [For managing different input devices (e.g. keyboards, mouse, controllers, etc.)],

    [Blenvy], [For level design.],
    [Avian2d], [For rigid-body physics and collision detections.],
  )
]


And many more!

#pagebreak()

=== Vello - Compute-centric Vector Graphics Renderer

#figure(caption: "Linebender Logo")[
  #image("assets/linebender.svg", height: 160pt)
]

Vello is a compute-centric vector graphics renderer developed by the Linebender organization.
The Linebender organization is a group of people who share an interest in 2D graphics and UI design @linebender.
Some other projects that they developed include Xilem, Masonry, Vello, Kurbo, Peniko, etc @linebender.

#figure(caption: "Vello demo")[
  #image("assets/vello-demo.png")
]

Unlike traditional vector graphics renderer, Vello strives to off-load all of the rendering steps to the GPU via compute shaders.
At the moment of writing this article, #cite(<vello2020>, form: "prose") stated that there are plans for Vello to support retained mode in the future, but for now, its mostly an immediate mode API.
This is actually only possible because of the performance gain that Vello obtain via parallel computing on the GPU.

#figure(caption: "Wgpu logo")[
  #image("assets/wgpu-logo.svg")
]

Part of what makes Vello so appealing is its cross platform capability.
Unlike many other research projects that uses CUDA as their GPU compute platform, Vello achieves portable GPU compute by utilizing the Wgpu library @velloroadmap @vello2020.
Wgpu runs natively on Vulkan, Metal, DirectX 12, and OpenGL ES; and browsers via WebAssembly (WASM) on WebGPU and WebGL2 @wgpu.

#pagebreak()

=== Typst

#figure(caption: "Typst logo")[
  #image("assets/typst-logo.png", height: 160pt)
]

Typst has been mentioned multiple times in this paper.
It is used as the language for creating graphical content in #velyst.
Typst is a programmable markup language for sophisticated typesetting @madje2022programmable.
It supports programming concepts like conditionals, while and for loops, closures, functions, and many more.
These concepts are directly embedded into the Typst language without any third party scripting language @madje2022programmable.

By integrating Typst within a Rust environment through Velyst, this project combines Typst’s layouting and scripting capabilities with Bevy’s real-time rendering.
This enables games to leverage Typst’s typesetting strengths for on-the-fly generation of UI elements, text, and other graphical assets.
The result is an efficient workflow where content in Typst can be manipulated and rendered dynamically within the game engine, enhancing both the visual and interactive elements of the application.
This approach bridges the gap between content creation and real-time execution, offering a powerful tool for developers who seek sophisticated text and graphics rendering in games.
