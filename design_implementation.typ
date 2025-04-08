#import "keywords.typ": *

= Design and Implementation

== Introduction

This project will be separated into two major sections, one for #velyst and one for #lumina.

=== #velyst

#velyst will be developed as a separate library or plug-in and tested on the #lumina game project.
The goal is to create a robust and dynamic vector graphics system that seamlessly integrates with real-time game environments.
#velyst focuses on delivering interactive UI/UX elements with features like live reloading, customizability, and optimized performance, tailored specifically for the needs of modern game engines.

The #lumina project will utilize #velyst as the main UI content creator and renderer.
To enhance the visual of the game and to showcase the uniqueness of #velyst, #lumina will incorporate dynamic vector graphics content into the game to enrich the gaming experience.
Some examples of such usage would be the in-game UI like health bar, booster meter, speedometer, and many more!
#velyst will also be utilized to create custom vector graphic sprites, a feature rarely seen in commercial games.
This highlights the exceptional capabilities and distinctiveness of our library, setting it apart as a groundbreaking innovation in game development.

The heart of #velyst is the compiler.
The compiler is responsible for compiling Typst content into a usable data structure in Rust called `Content` @madje2022programmable.
This data structure is the heart of Typst, it can be used to represent any part of the Typst document, in our case the entire document.
This process will be done every frame, which makes it curcial for it to be optimized.
Once the compilation is done, the content will then be converted into a Vello scene which is sent to the GPU for accelerated vector graphics rendering.

Once the compiler has been developed, a Bevy engine tailored experience will be created.
This includes integrating the compiler as a resource in the game world.
Multiple utility functions will also be created to facilitate the creation of Typst content directly in Rust.
This is extremely useful for maximized customizability, especially when programming driven content is needed.
To utilize the Typst language, a custom system will also be implemented to convert Typst functions into renderable vector graphics content in Bevy effortlessly using macros and traits.
These system will enable users to define provide function arguments in Rust for functions created in Typst, where different input arguments will result in different output contents.

=== #lumina

#lumina is a fast paced, top down, 2D, player versus player versus environment (PvPvE) game.
In the game, players pilot a spaceships to complete objectives by depositing lumina into the tesseract to push the tesseract meter.
Players of different teams can also eliminate each other during the match in an attempt to obtain an upper hand.
To win the game, one team will need to push the tesseract meter completely towards the opposing side to obtain total dominance.

The game is heavily physics-driven, with each spaceship consisting of a physics body that interacts dynamically with the environment.
It employs client-side prediction to ensure seamless and responsive physics interactions, maintaining a smooth gameplay experience.
To uphold fair play, all predictions are validated against the server, enabling a fully server-authoritative system that prevents cheating.

The game will employ a custom implementation of global illumination solution using the Radiance Cascades method @osborne2024radiance.
Unlike most 2D games, this game does not use any point or spot lights to illuminate the scene.
Instead, it relies on emissive materials in the scene.
The algorithm will be developed using compute shaders and runs entirely on the GPU.

#lumina features three different levels:
- The local lobby when the player first enters the game.
- The multiplayer lobby when the player enters matchmaking mode.
- The in-game terrain which will be partially procedurally generated.

Inside the in-game terrain, enemy mobs will spawn in dedicated spawn points.
Once defeated, the mobs will drop lumina for the players to collect.
These mobs are the primary source of lumina in the game.
When a player dies with lumina in their inventory, their lumina will drop onto the ground for other players to collect (friend or foe).

#pagebreak()

== Design

=== Levels

=== Art Assets

=== Resources

=== NPCs

=== System Design Diagram

#pagebreak()

== Interface Design

=== Menus

=== In-game UI

=== Popups

==== Effectors

==== Emoji

#pagebreak()

== Execution

=== Software and Scripting

=== Hardware Used

=== APIs and External Libraries

=== Asset Creation and Design Techniques

=== Development Process

=== Conclusion

#pagebreak()

== Screenshot

#pagebreak()

== Summary
