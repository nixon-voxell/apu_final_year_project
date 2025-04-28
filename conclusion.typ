#import "monokai_pro.typ": *
#import "keywords.typ": *
#import "utils.typ": *

= Conclusion

== Critical Evaluation

This research had explored the evolution of vector graphics, examining its historical roots and tracing its development through to the current modern techniques.
This investigation has provided a comprehensive understanding of how vector graphics, from their early applications to today’s dynamic and interactive uses, continue to influence the design and performance of modern digital content.
On the other hand, research on UI/UX implementations shows the different ways of UI frameworks implementations, namely, IMGUI and RMGUI, with strength and weaknesses evaluated form both sides.
These insights will help us in developing a more robust framework for #velyst.
Finally, this paper also took a deep dive into the tools used in authoring UI elements using markup languages like HTML and CSS.

From the surveys and interviews, there is a common theme on the lack of robust tooling in terms of integration and flexibility.
Many developers expressed a desire for improved tools that can streamline the integration of vector and motion graphics into real-time applications and game engines.
Several challenges were highlighted, such as the lack of seamless interoperability between different platforms, the complexity of dynamic vector graphics integration, and the need for more flexible, customizable toolsets.
For instance, many participants pointed out that existing tools often require too much technical knowledge or have limitations in terms of performance and flexibility.

From the playtest feedbacks, #lumina garnered a high rating of appoximately 8 stars.
It further signifies the polishness of the Lumina game itself and also that Velyst is capable of enhancing the interactivity and visual appearance of the game.
In the feedback, we noticed that even though players might not notice the difference between raster and vector graphics in common screen sizes (1920 x 1080), players do enjoy the procedurally generated animations and smooth real-time interactions.

== Limitation

The Velyst workflow at the moment is pretty restricted to just screen space element rendering.
Although world space element rendering has been achieved in Lumina using the current system, it is still largely limited by the `Resource` nature of each #func.
Developers are required to allocate a vector on runtime and pack all the world space data (including the world space coordinates) and feed it to the Typst function for it to be rendered correctly.
This poses an unnecessary overhead for the developers as these information are already accessible in each game Entity.

While Velyst supports hot-reloading for Typst source files, it still lacks the ability to hot-reload third-party files.
For example, these types of files might include imported Typst files or SVG files.
This means that changes to these files might not be reflected immediately in the game without also reloading the primary Typst source file itself.
This could lead to confusion for new users as it is most likely going to be the assumed behavior from the users.

Another limitation of Velyst is the slow compilation speed from the Typst compiler.
This is partially due to the fact that Velyst is recompiling the #cont every update frame into a #frame.

Velyst also does not come with a built-in animation library.
This makes the creation of custom animations extremely tedious as users would have to build up their own utility animation library from scratch both in Rust and in Typst.

Finally, Velyst does not integrate well with other scene formats like SVG.
Typst only allows manipulation of these file formats by replacing strings of characters in the file using regular expression (Regex).
Support for other scene formats are also extremely related, some scene formats are even straight up not supported, like the Drawing Exchange Format (DXF).

// Slow compilation times, caching?
// Better scene format for more fine grain manipulation.
// Svg integration is limited, ties to the prev. Generalize the scene format to other specs (dxf?) (Tabulon project).
// No good way for defining animation (animation library? state machine editor?) (Rive product).

== Recommendation

This section will address the limitations of Velyst.
Firstly, an entity-component based Velyst workflow would highly benefit the Velyst rendering pipeline.
This will also enable Velyst to support Z-ordering per entity to easily reorder items around the Bevy scene.
A entity-component based workflow will also easily allow developers to render large amount of repetitive elements in the scene easily either in world space or screen space.

Next, the Velyst asset pipeline will need to implement a hierarchy observer, allowing it to detect changes of the nested assets.
This will also increase the development efficiency.

Addressing the slow compilation issue is no easy task.
One good approach that the Velyst render pipeline could benefit from woud be a cache systems where instead of recompiling the entire frame, we can choose to retain those areas that doesn't change (like a retained mode).
This can also partially be positively impacted by implementing the entity-component based workflow mentioned earlier.

A highly custom-curated animation library will also greatly improve the developer experience of Velyst.
This ties in nicely with adding more scene format supports.
Alternatively, Velyst could also spin out a new project to try and introduce a universal scene data structure for different formats.
Ideas similar to this has also been proposed from the Vello community which had led to a potential project named "Tabulon".
Having a universal scene data structure will open up opportunities for animation developers to share and reuse animation libraries regardless of the input file or scene format!
