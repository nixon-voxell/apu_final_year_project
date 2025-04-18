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
    #figure(caption: [Velyst logo])[
      #image(
        "assets/velyst.svg",
        width: 20%,
      )
    ] <velyst-logo>
  ][
    #figure(caption: [Lumina logo])[
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
Lumina utilizes the Velyst crate #footnote()[A crate is just a Rust library.] for all (or at least most) of its UI/UX creation.
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
    This is particularly repetitive as developers will need to constantly define the function name and arguments.
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

The following sections will dive into the design architecture of Velyst and how it is being integrated into the Lumina game.
We will also briefly dive into how Lumina works to provide a better overall understanding of the underlying systems.

#pagebreak()

== Design

=== Velyst Architecture

#figure(caption: [Velyst architecture])[
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
      blob((1, 3), [Scope], tint: blue),
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
+ *Files*: Responsible for loading and caching the \*.typ source files and other assets, for instance, images, vector graphics, tables, etc.
+ *Library*: The Typst standard library and user defined variables and functions.
+ *Fonts*: Keeps track of all the fonts available to the compiler.
+ *Datetime*: Provide the current date and time, down to the second!

#figure(kind: image, caption: [Typst world code snippet])[
  ```rs
  /// World for compiling Typst's [`Content`].
  pub struct TypstWorld {
      /// The root relative to which absolute paths are resolved.
      root: PathBuf,
      /// Typst's standard library.
      pub library: LazyHash<Library>,
      /// Metadata about discovered fonts.
      book: LazyHash<FontBook>,
      /// Locations of and storage for lazily loaded fonts.
      fonts: Vec<FontSlot>,
      /// Maps file ids to source files and buffers.
      slots: Mutex<HashMap<FileId, FileSlot>>,
      /// The current datetime if requested. This is stored here to ensure it is
      /// always the same within one compilation. Reset between compilations.
      now: OnceLock<DateTime<Local>>,
  }
  ```
]

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

#figure(
  kind: image,
  caption: [The Velyst render pipeline system sets code snippet],
)[
  ```rs
  pub enum VelystSet {
      /// Loading and reloading of [`TypstAsset`].
      AssetLoading,
      /// Compile [`TypstFunc`] into a [`TypstContent`].
      Compile,
      /// Layout [`Content`] into a [`TypstScene`].
      Layout,
      /// Render [`TypstScene`] into a [`VelloScene`].
      Render,
  }
  ```
]

#let scope = text(blue)[`Scope`]
#let func = text(red)[`Func`]
#let cont = text(yellow)[`Content`]
#let frame = text(purple)[`Frame`]
#let vello_scene = text(orange)[`VelloScene`]

The Velyst pipeline might vary slightly depending on the use case.
However, in most scenarios, it begins with creating a native Typst source file within the assets folder.
This source file will be loaded asynchronously into Bevy at runtime through the Bevy asset pipeline.
Once loaded, the Typst compiler _evaluates_ the source file into a #scope, which contains everything defined within the source file.

Velyst allow developers to run any functions defined in the Typst source file.
During this phase the chosen Typst function will be extracted from the #scope and then packed into a #cont data structure.
The #cont is later being used to _layout_ into a #frame.
Lastly, developers can apply any final post-process needed to the #frame which will then be converted into a #vello_scene.

#info_box(
  underline[*What is a #cont?*],
  [
    A #cont is a universal "type" in Typst that packs the information needed to create a renderable #frame view.
    It can be created completely from scratch in Rust or compiled from markdown.
    On rare occasions where developers need to create a #frame completely in the Rust language, they can do so by creating a #cont.
    In addition to that, developers can also modify a #cont using a utility crate that Velyst provides called *_Typst Element_* (see @utility-crate).
  ],
)

#info_box(
  underline[*What is a #frame?*],
  [
    A #frame is a vector graphics format created by _laying out_ a #cont.
    It primarily consists of the shapes, texts, fills, and strokes needed to draw the vector graphics content.
    This also means Velyst can use any rendering backend, with Vello being the one currently in use.
    Velyst also offers a simple post-processing step that developers can apply to a #frame for direct vector graphics manipulation using the *_Typst Vello_* utility crate (see @utility-crate).
  ],
)

#pagebreak()

=== Velyst Utility Crates <utility-crate>

Velyst provides two utility crates: #typst_elem and #typst_vello.

==== Typst Element

#figure(caption: [Typst Element utilities])[
  #set align(center)
  #diag_world[
    #cell_diag(
      cell-size: (4em, 2em),
      blob(
        (0, 0),
        [Evaluate],
        tint: blue.mix(green).desaturate(70%),
        shape: octagon,
      ),
      edge("r", "-|>"),
      blob((1, 0), [Scope], tint: blue),
      edge("u,r", "-|>"),
      node((2, -1), [```rs get_value(..)```]),
      edge("d", "-|>"),
      blob((2, 0), [Func], tint: red, shape: hexagon),
      edge("d", "-|>"),
      node((2, 1), [```rs context(..).pack()```]),
      edge("r,u", "-|>"),
      blob((3, 0), [Content], tint: yellow, shape: house),
    )
  ]
]

This crate provides utility tools for creating, modifying, and styling a #cont.
The most crucial function from Typst Element is the ```rs context(..)``` function (@context-func).
It allows developers to to run any function from the #scope and produces a context element which can be packed into a #cont.

#figure(kind: image, caption: [Context function code snippet])[
  ```rs
  pub fn context(
      func: foundations::Func,
      apply_args: impl Fn(&mut SpannedArgs),
  ) -> foundations::ContextElem {
      let mut spanned_args = SpannedArgs::new(func.span());
      apply_args(&mut spanned_args);
      foundations::ContextElem::new(func.with(&mut spanned_args.args))
  }
  ```
] <context-func>

The #func argument required for the ```rs context(func, ..)``` function can be obtained from the scope extension trait:

#figure(kind: image, caption: [Scope extension code snippet])[
  ```rs
  impl ScopeExt for Scope {
      fn get_value<T: FromValue>(&self, var: &str) -> Result<T, ScopeError> {
          self.get(var)
              .ok_or(ScopeError::VariableNotFound)
              .and_then(|value| {
                  value.read().clone().cast::<T>().map_err(ScopeError::ValueCastFailed)
              })
      }
  }
  // Example usage:
  let func = scope.get_value::<Func>("func_name").unwrap();
  ```
]

This crate also provides a huge number of other utility functions using the ```rs fn_elem!(..)``` macro as shown in @fn-elem.

#figure(
  kind: image,
  caption: [```rs fn_elem!(..)``` macro and example use cases],
)[
  ```rs
  macro_rules! fn_elem {
      ($fn_name:ident, $elem:ty, $($param:ident = $in_elem:ty),+) => {
          #[doc = concat!("[", stringify!($elem), "]")]
          pub fn $fn_name($($param: impl Into<$in_elem>),+) -> $elem {
              <$elem>::new($($param.into()),+)
          }
      };
  }
  // Example usage:
  fn_elem!(sequence, foundations::SequenceElem, Vec<Content>);
  // And many more...!
  ```
] <fn-elem>

==== Typst Vello

#figure(caption: [Typst Vello utilities])[
  #set align(center)
  #diag_world[
    #cell_diag(
      cell-size: (4em, 2em),
      blob(
        (0, 0),
        [Layout],
        tint: blue.mix(green).desaturate(70%),
        shape: octagon,
      ),
      edge("r", "-|>"),
      blob((1, 0), [Frame], tint: purple),
      edge("u,r", "-|>"),
      blob((2, -1), [Typst Scene]),
      edge("d", "-|>"),
      node((2, 0), [```rs post_process(..)```\*]),
      edge("d", "-|>"),
      node((2, 1), [```rs render(..)```]),
      edge("r,u", "-|>"),
      blob((3, 0), [Vello Scene], tint: orange),
    )
  ]

  #set align(left)
  #text(size: 0.8em)[_\* indicates optional steps._]
]

#typst_vello exposes functionalities that allows developers to apply vector graphics post-processing and convert a #frame into a #vello_scene.
The core data structure of Typst Vello is a `TypstScene` (@typst-scene).
It flattens a vector graphics scene into a vector of groups and allows post-processing to any labeled group content.

#figure(kind: image, caption: [Typst scene code snippet])[
  ```rs
  pub struct TypstScene {
      size: kurbo::Vec2,
      group_scenes: Vec<TypstGroupScene>,
      group_map: AHashMap<Label, SmallVec<[usize; 1]>>,
      pub post_process_map: AHashMap<Label, PostProcess>,
  }
  ```
] <typst-scene>

Below shows how you can label a piece of content in the Typst markdown structure:

#figure(kind: image, caption: [Labeled markdown content.])[
  ```typ
  #box(fill: blue, inset: 1em)[This is a piece of content.] <my-label>
  ```
]

Finally, #typst_vello exposes a ```rs render(..)``` function to render a `TypstScene` into a #vello_scene:

#figure(kind: image, caption: [Render function code snippet])[
  ```rs
  pub fn render(&mut self) -> vello::Scene {
      let mut scene = vello::Scene::new();
      // Setup scene stuff...
      for (i, group_scene) in self.group_scenes.iter_mut().enumerate() {
          // Render the group scenes...
      }
      scene
  }
  ```
]

#pagebreak()

=== Integration with Bevy's ECS World

The Bevy's ECS world is responsible for managing the entire game logic in #lumina.
It is crucial for the #velyst architecture to integrate seamlessly with Bevy's ECS world.
Velyst uses common Bevy ECS data structures, specifically the _assets_, _resources_, _entities_, and _components_ to communicate between the Typst world and the ECS world.

#figure(caption: [Velyst-ECS communication diagram])[
  #diag_world[
    #cell_diag(
      blob(
        (0, 0),
        [Assets],
        width: 5em,
        tint: blue.desaturate(50%),
        shape: chevron,
      ),
      blob(
        (0, 2),
        [Resources],
        width: 5em,
        tint: red.desaturate(50%),
        shape: chevron,
      ),
      blob(
        (0, 4),
        [Entities],
        width: 5em,
        tint: green.desaturate(50%),
        shape: chevron,
      ),

      blob((1, 0), [Source 1], tint: blue),
      edge("dd"),
      edge("d,r,d"),
      blob((3, 0), [Source 2], tint: blue),
      edge("dd"),
      edge("d,r,d"),
      edge("d,rr,d"),

      blob((1, 2), [Func 1], tint: red),
      edge("dd"),
      edge("d,r,d"),
      blob((2, 2), [Func 2], tint: red),
      blob((3, 2), [Func 3], tint: red),
      edge("dd"),
      blob((4, 2), [Func 4], tint: red),
      edge("dd"),
      edge("d,r,d"),
      edge("d,rr,d"),
      blob((5, 2), [Func 5], tint: red),

      blob((1, 4), [Node 1], tint: green),
      blob((2, 4), [Node 2], tint: green),
      blob((3, 4), [Node 3], tint: green),
      blob((4, 4), [Node 4], tint: green),
      blob((5, 4), [Node 5], tint: green),
      blob((6, 4), [Node 6], tint: green),
    )
  ]
] <velyst-ecs-comm>

When a native Typst source file (\*.typ) is loaded into Bevy, it will be stored in Bevy's asset server.
The asset server is responsible for loading, and hot-reloading changes from the source file.
Each source file may contain several Typst functions which can be used to create renderable #vello_scene in Bevy.
These functions are needed to be defined in the Rust source code too.
Fortunately, Velyst provides a simple `TypstFunc` procedural macro for the creation of these definitions (@typst-func-proc-macro).

#block(
  width: 100%,
  align(
    (center + bottom),
    stack(
      dir: ltr,
      spacing: 1em,
      figure(kind: image, caption: [Native Typst function])[
        ```typ
        #let main(data) = {..}
        ```
      ],
      [#figure(kind: image, caption: [`TypstFunc` procedural macro])[
          ```rs
          #[derive(TypstFunc, Resource, Default)]
          #[typst_func(name = "main")]
          struct MainFunc {
              data: Option<Dict>,
          }
          ```
        ] <typst-func-proc-macro>],
    ),
  ),
)

As shown in @velyst-ecs-comm, each function definition is also required to be a Bevy _resource_ so that the Velyst pipeline can pick up information from them.
Inside a Typst function, developers can label parts of their boxed content which will eventually be turned into an entity as an interactable Bevy UI `Node`.
Note that not all functions contain nodes, it should only be added if interaction is required between the content and the user.

#figure(kind: image, caption: [Labeled boxed content in Typst])[
  ```typ
  #let button(label) = [#box[#label] <my-button>]
  ```
]

Finally, Velyst also makes it extremely simple to register these bindings with a simple app extension trait:

#figure(kind: image, caption: [App extension trait])[
  ```rs
  pub trait VelystAppExt {
      /// Load [`TypstAsset`] and detect changes made towards the asset.
      fn register_typst_asset<P: TypstPath>(&mut self) -> &mut Self;
      /// Compile [`TypstFunc`] into [`TypstContent`].
      fn compile_typst_func<P: TypstPath, F: TypstFunc>(&mut self) -> &mut Self;
      /// Layout [`TypstContent`] into [`VelystScene`] and render it into a [`VelloScene`].
      fn render_typst_func<F: TypstFunc>(&mut self) -> &mut Self;
  }
  // Example usage:
  impl Plugin for MainUiPlugin {
      fn build(&self, app: &mut App) {
          app.init_resource::<MainFunc>()
              .register_typst_asset::<MainUi>()
              .compile_typst_func::<MainUi, MainFunc>()
              .render_typst_func::<MainFunc>();
      }
  }
  ```
]

#pagebreak()

=== Lumina

Under the hood, #lumina fully utilizes Bevy ECS to handle everything that happens in the game, from user interaction, to visual effects, and rendering.

==== Spaceships
There is a total of two spaceships available in Lumina --- *Assassin* and *Defender*.
Each spaceship has a common ability --- _Dash_, and a unique ability --- _Shadow_ for *Assassin* and _Heal_ for *Defender*.

#table(
  columns: (0.4fr, 1fr),
  [
    #box(
      radius: 60%,
      clip: true,
      image("assets/lumina-screenshots/assassin-focus.png"),
    )
    #image("assets/lumina-screenshots/assassin-skill.png")
  ],
  [
    *Assassin*

    A fast and agile spaceship, specialized in stealth and precision strikes.
    It has lower firing rate but higher damage points.
    It moves slightly faster than the defender spaceship.
    The bullets of the assassin also travels faster.
    The _Shadow_ ability allows it to travel unseen (@shadow-effect).
  ],

  [
    #box(
      radius: 60%,
      clip: true,
      image("assets/lumina-screenshots/defender-focus.png"),
    )
    #image("assets/lumina-screenshots/defender-skill.png")
  ],
  [
    *Defender*

    A highly durable spaceship, with strong shields for defense-focused gameplay.
    The defender spaceship has significantly more health than the assassin.
    The bullets of the defender travels slower, but it has higher firing rate.
    The _Heal_ ability allows the spaceship to regain health of all the spaceship in its team including itself (@heal-effect).
  ],
)

#figure(caption: [Assassin Shadow visual effect])[
  #image("assets/lumina-screenshots/assassin-shadow.png")
] <shadow-effect>

#figure(caption: [Defender Heal visual effect])[
  #image("assets/lumina-screenshots/defender-heal.png")
] <heal-effect>

#pagebreak()

==== Maps

#lumina also comes with a total of four maps:

#figure(caption: [Local lobby (Map 1)])[
  #image("assets/lumina-screenshots/blender-local.png")
  #image("assets/lumina-screenshots/firing-in-lobby.png")
]

The Local lobby map is where players start when they enter the game.

#figure(caption: [Sandbox (Map 2)])[
  #image("assets/lumina-screenshots/blender-sandbox.png")
  #image("assets/lumina-screenshots/in-sandbox.png")
]

New players can choose to enter the Sandbox map to test out controls and learn how to play the game.

#figure(caption: [Multiplayer lobby (Map 3)])[
  #image("assets/lumina-screenshots/blender-multiplayer.png")
  #image("assets/lumina-screenshots/in-multiplayer.png")
]

When players enter the matchmaking mode (1v1/2v2/3v3), they will be teleported into the Multiplayer lobby where they can meet their team mates and opponents in real-time as they join.
Once the lobby is full, they will enter the Abandoned Factory.

#figure(caption: [Abandoned factory (Map 4, in-game map)])[
  #image("assets/lumina-screenshots/blender-abandoned-factory.png")
  #image("assets/lumina-screenshots/in-abandoned-factory.png")
]

The Abandoned Factory is the map where opposite teams compete between each other.

#pagebreak()

==== Objective

The objective of the game is to destroy ores (@destroy-ores), collect luminas, and deposit it into the tesseract (@deposit-lumina)!

#figure(caption: [Destroy ores])[
  #image("assets/lumina-screenshots/destroy-ores.png")
] <destroy-ores>

#figure(caption: [Deposit Lumina into tesseract])[
  #image("assets/lumina-screenshots/deposit-lumina.png")
] <deposit-lumina>

An alternative to obtain Lumina apart from destroying ores is by destroying the opponent's spaceships.
When a spaceship is destroyed, all Lumina that it is holding will be dropped onto the map.
Each deposited Lumina will push the bar (shown in @tesseract-effect-bar) towards the other end (right in the player's view).
The team that pushes the bar towards the end will win the game!

#figure(caption: [Tesseract effect bar])[
  #image("assets/lumina-screenshots/tesseract-effect-bar.png")
] <tesseract-effect-bar>

==== Miscellaneous

#[
  #set par(justify: false)
  #table(
    columns: (1fr, 1fr, 1fr),
    [
      #figure(
        caption: [Lumina],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/lumina.png"),
        ),
      )
      The points that the player collects and deposit into the Tesseract.
    ],
    [
      #figure(
        caption: [Small ore],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/ore-small.png"),
        ),
      )
      When destroyed, 1-2 Luminas will drop into the map.
    ],
    [
      #figure(
        caption: [Medium ore],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/ore-medium.png"),
        ),
      )
      When destroyed, 3-5 Luminas will drop into the map.
    ],

    [
      #figure(
        caption: [Large ore],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/ore-large.png"),
        ),
      )
      When destroyed, 5-8 Luminas will drop into the map.
    ],
    [
      #figure(
        caption: [Spawn point],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/spawn-point.png"),
        ),
      )
      The location where players spawn.
    ],
    [
      #figure(
        caption: [Laser],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/laser.png"),
        ),
      )
      Will fire occasionally and damage any spaceship within its range.
    ],

    box[
      #figure(
        caption: [Teleporter],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/teleporter.png"),
        ),
      )
      Teleport spaceships to the other end of the teleporter.
    ],
    box[
      #figure(
        caption: [Teleporter base],
        box(
          width: 50%,
          rotate(
            90deg,
            box(
              radius: 1em,
              clip: true,
              image("assets/lumina-screenshots/teleporter-base.png"),
            ),
          ),
        ),
      )

      Teleport spaceships to the other end of the teleporter.
    ],
    [
      #figure(
        caption: [Bullet],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/bullet.png"),
        ),
      )
      A glowing bullet that applies damage on opponents and ores.
    ],

    [
      #figure(
        caption: [Door],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/door.png"),
        ),
      )

      Decorative door.
    ],
    [
      #figure(
        caption: [Moving door],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/door-moving.png"),
        ),
      )
      A door that moves from start to end in a loop.
      This door will obstruct spaceships and bullets from going through.
    ],
  )
]

#pagebreak()

== Interface Design

Custom SVG assets are utilized and created for the buttons, cards, and icons.

=== Menu Designs

#figure(
  caption: [Main menu],
  image("assets/lumina-screenshots/ui-main-menu.png"),
) <main-menu>

The start menu consists of a start button, a settings button, and an exit button.

#figure(
  caption: [Spaceship select menu],
  image("assets/lumina-screenshots/ui-spaceship-select.png"),
)

The spaceship select menu allows player to select between the different types of spaceships.

#figure(
  caption: [Matchmake select menu],
  image("assets/lumina-screenshots/ui-matchmake-select.png"),
)

The matchmake select menu allows player to choose either sandbox or a team versus match.

#pagebreak()

=== Spaceship Stats

#figure(
  caption: [Spaceship stats],
  image("assets/lumina-screenshots/ui-spaceship-stats.png"),
) <spaceship-stats>

The spaceship stats consists of the spaceship's health, fuel, weapon selection, and the ammo count (@spaceship-stats).
Below are the possible scenarios for the spaceship's health and fuel UI:

#[
  #set par(justify: false)
  #table(
    columns: (1fr, 1fr, 1fr),
    [
      #figure(
        caption: [Lumina],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/ui-health-full.png"),
        ),
      )
      Complete green indicates a full health.
    ],
    [
      #figure(
        caption: [Small ore],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/ui-health-damaged.png"),
        ),
      )
      Health color will interpolate from green to reddish as it goes down.
    ],
    [
      #figure(
        caption: [Medium ore],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/ui-health-critical.png"),
        ),
      )
      Health color goes towards red when nearing death.
    ],

    box[
      #figure(
        caption: [Full fuel],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/ui-fuel-full.png"),
        ),
      )
      Complete yellow indicates full fuel.
    ],
    [
      #figure(
        caption: [Half fuel],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/ui-fuel-half.png"),
        ),
      )
      Fuel meter slowly interpolate from yellow to reddish as it goes down.
    ],
    [
      #figure(
        caption: [Empty fuel],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/ui-fuel-empty.png"),
        ),
      )
      Fuel meter will turn completely red on empty.
    ],
  )
]

#figure(caption: [Spaceship abilities])[
  #image("assets/lumina-screenshots/assassin-skill.png")
]

The spaceship abilities UI indicates the current state of abilities (triggered, effective, cooldown).
#[
  #set par(justify: false)
  #table(
    columns: (1fr, 1fr, 1fr),
    [
      #figure(
        caption: [Ability active],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/ability-active.png"),
        ),
      )
      Blue background indicates that the ability is currently active.
    ],
    [
      #figure(
        caption: [Ability cooldown],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/ability-cooldown.png"),
        ),
      )
      A cooldown shade indicates the percentage of the cooldown.
    ],
    [
      #figure(
        caption: [Dash cooldown],
        box(
          radius: 1em,
          clip: true,
          image("assets/lumina-screenshots/dash-cooldown.png"),
        ),
      )
      Works similar to the ability cooldown.
      (No active for _Dash_ as the effect is immediate.)
    ],
  )
]

#pagebreak()

== Execution

=== Technology Stack

#lumina is made mainly using the Rust language. This means that most of the dependencies used will also be from the Rust ecosystem.

Here is the breakdown of the Lumina tech stack:

#table(
  columns: (1fr, 2fr),
  table.header(
    [*Component*],
    [*Tool/Library*],
  ),

  [Game Engine], underline(link("https://bevyengine.org/")[_Bevy_]),
  [UI/UX], underline(link("https://github.com/voxell-tech/velyst")[_Velyst_]),
  [Global Illumination],
  underline(
    link("https://github.com/nixon-voxell/bevy_radiance_cascades")[_Radiance Cascades, an improvement from here_],
  ),

  [Particle System],
  underline(link("https://github.com/Lommix/bevy_enoki")[_Bevy Enoki_]),

  [Physics], underline(link("https://github.com/Jondolf/avian")[_Avian_]),
  [Networking],
  underline(link("https://github.com/cBournhonesque/lightyear")[_Lightyear_]),

  [Asset Management],
  underline(link("https://github.com/kaosat-dev/Blenvy")[_Blenvy_]),

  [Input Manager],
  underline(
    link("https://github.com/Leafwing-Studios/leafwing-input-manager")[_Leafwing Input Manager_],
  ),

  [Coroutine],
  underline(link("https://github.com/Maaxed/bevy_coroutine")[_Bevy Coroutine_]),

  [Motion Graphics],
  underline(
    link("https://github.com/voxell-tech/bevy_motiongfx")[_Bevy MotionGfx_],
  ),
)

#pagebreak()

=== UI Creation Workflow

This section will discuss how a user interface is designed, created, and implemented into the game using the #velyst pipeline discussed earlier.
We will take the main menu (@main-menu) as an example:


==== Create Assets

Create the assets needed for the UI layout.
This normally includes creating the SVG files using softwares like Graphite.rs or Adobe Illustrator.
Some assets we created for the game includes:

#table(
  columns: (1fr, 1fr, 1fr),
  figure(
    caption: [Button 1],
    box(
      inset: 1em,
      fill: base0,
      radius: 0.5em,
      image("assets/ui-assets/button01.svg"),
    ),
  ),
  figure(
    caption: [Button 2],
    box(
      inset: 1em,
      fill: base0,
      radius: 0.5em,
      image("assets/ui-assets/button02.svg"),
    ),
  ),
  figure(
    caption: [Card],
    box(
      inset: 1em,
      fill: base0,
      radius: 0.5em,
      image("assets/ui-assets/card.svg"),
    ),
  ),
)

==== Layout Content

Create the native Typst source file to layout the contents of the user interface.

#figure(kind: image, caption: [Main menu Typst source file])[
  ```typ
  #import "../monokai_pro.typ": *
  #import "../utils.typ": *

  #let main_menu(connected, connection_msg, dummy_update) = {
    box(width: 100%, height: 100%, inset: 4em)[
      #if connected == false {
        connect_server(connection_msg, dummy_update)
        return
      }

      #place(center + horizon)[
        #text(fill: yellow, size: 7em, font: "IBrand")[= Lumina]

        #text(fill: green, size: 2em)[
          #button(lbl: <btn:play>, inters: interactions())[== Start Engine!]
        ]
      ]

      #place(right + bottom)[
        #box(height: 3em)[
          #button(lbl: <btn:settings>, inters: interactions())[== #emoji.gear Settings]
        ]

        #box(height: 3em)[
          #text(fill: red)[
            #button(lbl: <btn:exit-game>, inters: interactions())[== Abort]
          ]
        ]
      ]
    ]
  }
  ```
]

==== Definition of Source File and Function

The next step is to link the \*.typ source file in Rust (@link-source) and create a ```rs struct``` to match the definition of the Typst function (@define-func).

#figure(kind: image, caption: [Link \*.typ source file])[
  ```rs
  #[derive(TypstPath)]
  #[typst_path = "typst/client/main_menu.typ"]
  struct MainMenuUi;
  ```
] <link-source>

#figure(kind: image, caption: [Define ```rs struct``` "function"])[
  ```rs
  #[derive(TypstFunc, Resource, Default)]
  #[typst_func(name = "main_menu", layer = 1)]
  pub struct MainMenuFunc {
      connected: bool,
      connection_msg: String,
      dummy_update: u8,
  }
  ```
] <define-func>

==== Register Asset and Typst Function

The final and last step is to register the asset file and function using the `Plugin` system in Bevy:

#figure(kind: image, caption: [Register asset and Typst function])[
  ```rs
  impl Plugin for MainMenuUiPlugin {
      fn build(&self, app: &mut App) {
          app
              // Register source file as asset.
              .register_typst_asset::<MainMenuUi>()
              // Register the function for compilation.
              .compile_typst_func::<MainMenuUi, MainMenuFunc>()
              // Register the function for rendering.
              // This step is optional, as users may need the compiled Content only.
              .render_typst_func::<MainMenuFunc>()
              // Insert function as Resource.
              .insert_resource(MainMenuFunc {
                  connection_msg: "Connecting to server...".to_string(),
                  ..default()
              });
      }
  }
  ```
]

The function itself is also registered as a Bevy `Resource` so that it can be obtained from Bevy's systems to modify the arguments of the function when needed.
Here's an example on how to do it:

#figure(
  kind: image,
  caption: [Using Bevy's system to modify arguments of a Typst function],
)[
  ```rs
  impl Plugin for MainMenuUiPlugin {
      fn build(&self, app: &mut App) {
          // Registering of assets and functions goes here ...
          app.add_systems(OnEnter(Connection::Disconnected), disconnected_from_server);
      }
  }

  fn disconnected_from_server(
      mut func: ResMut<MainMenuFunc>,
  ) {
      func.connected = false;
      func.connection_msg = "Disconnected...".to_string();
  }
  ```
]

In this particular example, a system is created to detect network disconnection using the state transition system schedule (```rs OnEnter(Connection::Disconnected)```).
Once the state transition is triggered, the system will run, and the fields inside the `MainMenuFunc` will be altered.

_\*Note: A system in Bevy looks exactly just like a normal Rust function with the exception that the arguments are restricted to system parameters (e.g. queries, resources, commands, etc.)._

#pagebreak()

=== Blender Asset Workflow

#figure(caption: [Blenvy], image("assets/blenvy.png", height: 20em))

Blenvy is a tool for using Blender as the level editor for Bevy.
At the time of writing this report, Bevy has yet to developed a functional editor.
The first step of the Blenvy workflow is to create assets within Blender.
Next, using the Blenvy's Blender add-on, users can attach components to the objects in Blender:

#figure(caption: [Blenvy], image("assets/blenvy/component.png", height: 23em))

These components are required to be registered in the Rust soruce code as well.

#figure(kind: image, caption: [Register components])[
  ```rs
  impl Plugin for TypeRegistryPlugin {
      fn build(&self, app: &mut App) {
          app
              .register_type::<NoRadiance>()
              .register_type::<SpaceshipType>()
              // And many more..
      }
  }
  ```
]

Because Blenvy utilizes the Bevy's reflection system to insert these components on load, the registered component type must also derive the `Reflect` trait with the `Component` trait reflected.

#figure(kind: image, caption: [Deriving reflection])[
  ```rs
  #[derive(Component, Reflect, Clone, Copy)]
  #[reflect(Component)] // Reflection is required for components to be registable.
  pub struct NoRadiance;
  ```
]

When the assets are needed to be used in the game, we load them into the game through a unique ```rs enum``` type that we create in the source code.
The `strum` crate is used here to define the folder the asset is located in.

#figure(kind: image, caption: [Spawning assets])[
  ```rs
  #[derive(Component, Reflect, AsRefStr, Debug, Clone, Copy)]
  #[reflect(Component)]
  #[strum(prefix = "spaceship_blueprints/")] // The folder the asset is located in.
  pub enum SpaceshipType {
      Assassin, // Must match the asset file's name.
      Defender,
  }

  // Spawning using a normal Bevy system.
  fn spawn_assassin(mut commands: Commands) {
      commands.spawn((SpaceshipType::Assassin.info(), SpawnBlueprint));
  }
  ```
]

#pagebreak()

=== Networking Protocols

The Lightyear crate is used as the networking solution for the game.
All networking protocols are defined explicitly in the source code.

#figure(kind: image, caption: [Network protocols])[
  ```rs
  impl Plugin for ProtocolPlugin {
      fn build(&self, app: &mut App) {
          // Channels
          app.add_channel::<OrdReliableChannel>(ChannelSettings {
              mode: ChannelMode::OrderedReliable(ReliableSettings::default()),
              ..default()
          });

          // Messages
          // ==============================
          app.register_message::<EnterSandbox>(ChannelDirection::Bidirectional);
          app.register_message::<Matchmake>(ChannelDirection::ClientToServer);
          // And many more..

          // ==============================
          // Input
          app.add_plugins(LeafwingInputPlugin::<PlayerAction>::default());

          // Components
          // ==============================
          // Only sync once when it was first added.
          app.register_component::<Transform>(ChannelDirection::ServerToClient)
              .add_prediction(ComponentSyncMode::Once);
          // Simple update sync.
          app.register_component::<MaxHealth>(ChannelDirection::ServerToClient)
              .add_prediction(ComponentSyncMode::Simple);
          // Full sync with rollback.
          app.register_component::<Position>(ChannelDirection::ServerToClient)
              .add_prediction(ComponentSyncMode::Full)
              .add_correction_fn(position::lerp);
          // And many more..
      }
  }
  ```
]

The game uses channel to send important messages that needs to be ordered and reliable.
Lightyear also has a strong support for the Leafwing input plugin that Lumina uses.
Lastly, syncing of each entity's behaviour is done through the registration of components.
For each protocol, developers can define the direction of the message.
This allows for server authoritative operations where the message direction can only go from server to clients.

#pagebreak()

=== Running the game

To compile Lumina, you have to perform a recursive clone:

#figure(kind: image, caption: [Cloning the repository])[
  ```sh
  git clone --recursive https://github.com/nixon-voxell/lumina.git
  ```
]

Before running the game, the `assets` folder needs to be linked correctly to all the binary crates.
You can do so by running:

#figure(kind: image, caption: [Linking the assets])[
  ```sh
  create_asset_junctions.bat
  ```
]

To run the game, you need to start the server and the client.
You can do so manually using:

#figure(kind: image, caption: [Running the binaries individually])[
  ```sh
  cargo run --bin lumina_server
  cargo run --bin lumina_client
  ```
]

For development purposes, a shell script has been created to speed things up:

#figure(kind: image, caption: [Running the shell script])[
  ```sh
  # Windows
  run.bat x
  # Linux or MacOS
  run.sh x
  ```
]

With `x` being the number of clients you want to spawn.

#pagebreak()

== Summary

In summary, #velyst lets developers build interactive, vector-based interfaces using Typst, rendered with Vello and powered by Bevy.
It supports hot-reloading, function macros, auto-layout, and GPU rendering.

Velyst loads Typst files, compiles them into layouts, and turns them into #vello_scene.
UI elements become Bevy entities, making interaction easy through ECS.
Procedural macros help bind Rust code to Typst components.

#lumina is a 2D PvP game where players collect Lumina to power a Tesseract.
It features smooth online gameplay with custom physics and global illumination via Radiance Cascades.
Players choose between two ships: the stealthy Assassin or the tanky Defender.
The game includes four maps for different gameplay modes.

Together, Velyst and Lumina demonstrate a streamlined UI pipeline and its use in a live game setting.
