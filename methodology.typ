#import "keywords.typ": *
#import "monokai_pro.typ": *
#import "utils.typ": *

= Methodology

== System Development Methodology

=== Introduction

Selecting a suitable development methodology is crucial for ensuring an efficient and adaptable workflow in any project.
Existing methodologies each come with unique strengths and limitations, often tailored to specific types of projects.
Among the most popular methodologies are Waterfall and Agile.

_Waterfall_

#figure(caption: [Waterfall methodology @agile2020])[
  #image("assets/waterfall.jpg")
]

Waterfall is a linear and sequential model ideal for projects with well-defined requirements and minimal expected changes.
Its strength lies in its clear structure and phase-based approach, making it predictable.
However, its rigidity can be a disadvantage in projects where requirements may evolve over time, as it lacks flexibility to accommodate ongoing changes.

#figure(caption: [Agile methodology @waterfall2023])[
  #image("assets/agile.png")
]

_Agile_

Agile, on the other hand, offers a highly flexible and iterative approach that allows for continuous feedback and adjustments throughout the development process.
This model excels in projects where requirements are expected to change, as it accommodates user input and evolving project goals.
However, Agile can sometimes struggle in projects requiring a fixed scope and budget, as its adaptability can lead to scope creep.

Below is a simple comparison of these methodologies:

#[
  #set par(justify: false)
  #table(
    columns: (auto, 1fr, 1fr),
    table.header("Methodology", "Advantages", "Disadvantages"),
    "Waterfall",
    [
      - Clear structure and phase-based, making project planning predictable.
      - Works well for projects with well-defined requirements and goals.
      - Clear documentation and deliverables at each stage.
    ],
    [
      - Inflexible to changing requirements, making it hard to adapt once development starts.
      - Lack of early testing and feedback can lead to large-scale reworks if requirements change.
      - Difficult to address issues mid-project as each phase is sequential.
    ],

    "Agile",
    [
      - Highly adaptable to change, allowing for user feedback at every stage.
      - Reduces risk through continuous testing and regular check-ins.
      - Ideal for fast-paced environments where requirements evolve frequently.
      - Promotes collaboration, enhancing team responsiveness and communication.
    ],
    [
      - Potential for scope creep, as continuous adaptation can lead to expanding project scope.
      - Requires active stakeholder engagement, which may be time-consuming.
      - Lacks predictability, which may make budgeting and timeline estimation challenging.
    ],
  )
]

#let implementation(body) = {
  box(fill: base8.mix((blue, 10%)), stroke: base0, radius: 5pt, inset: 10pt)[
    #underline[_Implementation:_]
    #body
  ]
}

=== Methodology Choice and Justification

For this project, Agile methodology is the preferred choice due to its iterative and user-centered design, which allows the team to remain adaptable in response to feedback and evolving project requirements.
Given the nature of the project, where user feedback and rapid iterations are essential, Agile supports a workflow that promotes ongoing testing, evaluation, and refinement at each stage.

The workflow in Agile will follow a sprint-based cycle, broken down into the following sections:

+ *Planning*\
  Each sprint begins with a planning phase where tasks are identified and assigned based on the project goals for that sprint.
  The team outlines the deliverables, prioritizes tasks, and ensures each team member is clear on their responsibilities.
  Planning ensures that each sprint has a focused objective, with clear milestones to meet.

  #implementation[
    Every two weeks, our team will hold a general meetup to discuss on our current progress and next steps.
    During the planning phase, we also actively brainstorm on new ideas, or better implementations of mechanics, art, and design.
  ]

+ *Design and Development*\
  During the design and development phase, the team works on implementing features and functionalities outlined in the sprint plan.
  Development occurs in small, manageable iterations, with regular check-ins and adjustments to ensure alignment with the sprint’s objectives.
  This phase enables quick adaptability and minimizes the risks of large-scale reworks.

  #implementation[
    After planning, each of our team member will head back to working and refining the project on their individual part.
    If a collaboration between two or more people is needed, they will be able to continue their discussion and work together either on Discord or physically.
  ]

+ *Testing and Feedback*\
  At the end of each sprint, the team conducts testing to ensure that newly developed features are functional and aligned with project requirements.
  Feedback is gathered from relevant stakeholders, and any issues or suggested changes are documented.
  This feedback loop is critical in Agile, as it ensures that adjustments can be made continuously.

  #implementation[
    Approximately every month, our team will roll out a test build to collect feedbacks from a selection portion of participants.
    These participants will likely be our friends, family, and initial fans, audience, or followers.
  ]

+ *Review and Retrospective*\
  After testing, the team performs a sprint review, evaluating both the successes and challenges encountered.
  The retrospective phase allows the team to reflect on the process, identify areas for improvement, and incorporate lessons learned into the next sprint’s planning phase.
  This continuous improvement approach aligns with Agile’s focus on flexibility and adaptability.

  #implementation[
    After the testing phase is over, we will review and evaluate all the constructive and valuable feedbacks and organize them from critical to subtle.
    Then, we will open up a discussion on these during the planning phase.
  ]

By following Agile, the project benefits from a dynamic and responsive workflow that can easily adapt to any changing needs, helping to ensure timely delivery and a user-centered approach.
The flexibility offered by Agile makes it the ideal choice, enabling iterative progress and a focus on evolving project goals and user expectations.

#pagebreak()

== Data Gathering Design

In the research design, data gathering will be conducted using two complementary methods: a questionnaire and an interview.
This dual-method approach aims to balance broad, generalized data from a larger group with in-depth insights from a select group of professionals.

The questionnaire will target a broad audience who are currently in the game, UI/UX, and vector graphics field, serving as the primary method to collect quantitative data on user opinions, experiences, and preferences related to the research topic.
By reaching a larger pool of respondents, the questionnaire enables the gathering of statistically relevant insights and general trends across a wide demographic.
Structured in a way that includes multiple-choice questions, Likert scales, and a few open-ended items, the questionnaire will facilitate an efficient analysis while also allowing for some qualitative feedback @dewi2021understanding.
This design helps to capture both objective data and individual nuances within responses, which can be further analyzed to identify general patterns and correlations.
Additionally, the anonymity provided in the questionnaire encourages honest and diverse opinions from a range of backgrounds, helping to avoid biases that might be present in more direct methods of data collection.

Complementing the questionnaire, the interview component will provide a more nuanced, qualitative perspective by engaging directly with subject-matter experts who possess specialized knowledge or expertise in the field of game, UI/UX, and vector graphics.
The interviews are designed to gather deeper insights that would not typically be captured in a standardized questionnaire.
Conducted in a semi-structured format, the interview will allow for flexibility, enabling the researcher to probe further into responses based on the interviewee’s expertise.
This format encourages participants to share their informed opinions, elaborate on complex ideas, and provide practical examples, thus enriching the data with professional and real-world insights @dewi2021understanding.
In addition, these expert insights will offer a valuable context for interpreting the trends identified in the questionnaire data, ensuring that the analysis incorporates both user-focused feedback and professional validation.

Together, these two methods will provide a balanced and holistic dataset, with the questionnaire delivering broad quantitative data and the interviews offering rich qualitative insights.
This mixed-method approach not only enhances the credibility and depth of the research findings but also supports a comprehensive understanding of the topic from both the end-user and expert perspectives.
Ultimately, combining these data sources will enable the research to deliver well-rounded conclusions and recommendations that are both broadly applicable and grounded in professional expertise.

#pagebreak()

=== Questionnaire Design

==== Section 1: Introduction and Basic Information

This section gathers general demographics information from the respondents such as name, age, and gender.

#figure(caption: "Screenshot of questionnaire description")[
  #image("assets/ques/intro.png")
]

#let ques_design(
  caption: content,
  quests: ((quest: content, ans: content, just: content),),
) = {
  let table_conts = ()
  for (i, q) in quests.enumerate() {
    i += 1
    table_conts.push([#i])
    table_conts.push(q.quest)
    table_conts.push(box(q.ans))
    table_conts.push(q.just)
  }

  set text(size: 0.9em)
  set par(justify: false)
  show figure: set block(breakable: true)
  figure(caption: caption)[
    #table(
      columns: (auto, 1fr, 1fr, 1fr),
      align: left,
      table.header(
        [],
        [*Question*],
        [*Answer*],
        [*Justification*],
      ),
      ..table_conts
    )
  ]
}

#ques_design(
  caption: "Data gathering section 1 questions, answers, and justifications",
  quests: (
    (
      quest: "Name",
      ans: "Short text answer",
      just: "Prevent duplicate data as well contact purposes in case if any clarifications are needed.",
    ),
    (
      quest: "Email",
      ans: "Short text answer",
      just: "For contact purposes in case if any clarifications are needed.",
    ),
    (
      quest: "Gender",
      ans: box()[
        Multiple Choice
        - Male
        - Female
        - Prefer not to say
        - Other:
      ],
      just: "Identify preference differences between different genders.",
    ),
    (
      quest: "Age",
      ans: [
        Multiple Choice
        - < 18
        - 18 - 24
        - 25 - 30
        - > 30
      ],
      just: "Identify preference differences across various age groups.",
    ),
  ),
)

#pagebreak()

==== Section 2: Vector graphics in games

This section provides an overview of the current state of vector graphics in game engines, focusing on feature preferences, implementations, and challenges.
The questions are designed with the assumption that the respondent has a basic understanding of vector graphics.
This is due to the fact that vector graphics implementations in today’s game engines are still relatively limited, which means that many respondents may only be familiar with the basic concepts or have limited experience with more advanced features.
Therefore, the questions aim to capture general insights rather than technical expertise, helping to gauge the broader perceptions and experiences of users with vector graphics in real-time game development.

#ques_design_obj(
  caption: "Data gathering section 2 questions, answers, and justifications",
  quests: (
    (
      quest: "How important is the use of vector graphics for creating crisp and scalable visuals in games?",
      ans: [
        Linear scale from 1-5\
        1 = Not important\
        5 = Very important
      ],
      just: "To assess the perceived significance of vector graphics for enhancing visual quality and scalability in games, which relates to their impact on player experience.",
      obj: "Research objective 1",
    ),
    (
      quest: "What assets would you prefer vector graphics over raster graphics.",
      ans: [
        Checkboxes
        - Icons
        - User Interface
        - Particle Effects
        - In Game Textures
        - Other:
      ],
      just: "Understanding which game assets are favored for vector graphics helps identify areas where vector graphics improve visual quality and performance.",
      obj: "Research objective 1 and 2",
    ),
    (
      quest: "Are you familiar with vector graphics concepts, such as scalability and the use of shapes like Bezier curves and polygons?",
      ans: [
        Multiple Choice
        - Yes
        - No
      ],
      just: "Gauges familiarity with vector graphics concepts, which informs on potential challenges in implementation.",
      obj: "Research Objective 3",
    ),
    (
      quest: "How are the performance of vector graphics in said game engines?",
      ans: [
        Multiple Choice Grid\
        Rows:
        - Unity
        - Unreal Engine
        Columns:
        - Very bad
        - Bad
        - Moderate
        - Well
        - Very well
      ],
      just: "Assess impact of vector graphics on game engine performance and identify performant implementations.",
      obj: "Research Objective 3",
    ),
    (
      quest: "How challenging do you find it to implement vector graphics in said game engines?",
      ans: [
        Multiple Choice Grid\
        Rows:
        - Unity
        - Unreal Engine
        Columns:
        - Very bad
        - Bad
        - Moderate
        - Well
        - Very well
      ],
      just: "To understand technical barriers and identifying user friendly design patterns.",
      obj: "Research Objective 2 and 3",
    ),
  ),
)

#pagebreak()

=== Interview Design

Interviews provide qualitative data that yields valuable insights into the research objectives of this project.
The selected interviewees for this section are experienced developers who have been working professionally in the industry sector related to games, UI/UX, and vector graphics, bringing real-world expertise to the discussion.
This targeted selection allows the interviews to be more in-depth, semi-structured, and technical, yielding concrete evidence and examples that can enhance the understanding of practical challenges and benefits associated with vector graphics in real-time game development.
These insights will help inform the design of an effective framework and guide future advancements in integrating vector graphics into game engines.

#let interview_design(
  caption: content,
  quests: ((quest: content, just: content, obj: content),),
) = {
  let table_conts = ()
  for (i, q) in quests.enumerate() {
    i += 1
    table_conts.push([#i])
    table_conts.push(box(q.quest))
    table_conts.push(q.just)
    table_conts.push(q.obj)
  }

  set par(justify: false)
  show figure: set block(breakable: true)
  figure(caption: caption)[
    #table(
      columns: (auto, 1fr, 1fr, 0.4fr),
      align: left,
      table.header(
        [No.],
        [Question],
        [Justification],
        [Relevant\ Research\ Objective],
      ),
      ..table_conts
    )
  ]
}

#interview_design(
  caption: "Interview questions",
  quests: (
    (
      quest: "Could you briefly introduce yourself and your background in UI/UX or game development?",
      just: "Establish context for their experience level and focus areas.",
      obj: "-",
    ),
    (
      quest: "How would you describe your general workflow when designing and implementing vector graphics in applications or games?",
      just: "Gather insights into workflows to identify typical processes in implementing vector graphics or similar elements.",
      obj: "Research Objective 2",
    ),
    (
      quest: "What are some challenges or frustrations you encounter with current graphics tools or technologies during development?",
      just: "Understand pain points that could reveal technical limitations or unmet needs in vector and motion graphics workflows.",
      obj: "Research Objective 3",
    ),
    (
      quest: "In terms of visual quality and performance, what impact do you think vector graphics have on the user experience?",
      just: "Gauge perceived benefits and challenges of vector graphics on the visual and performance aspects of applications.",
      obj: "Research Objective 1",
    ),
    (
      quest: "Do you currently use vector graphics for interactive or dynamic content in your projects? If so, how effective have they been, and what are the main limitations?",
      just: "Learn about specific use cases and barriers in vector graphics implementation within real-time environments.",
      obj: "Research Objective 2 and 3",
    ),
    (
      quest: "What tools or techniques do you typically use for integrating motion graphics, such as animations from platforms like Lottie, Rive, or After Effects?",
      just: "Explore how developers are bringing in external motion graphics and the role they play within interactive applications.",
      obj: "Research Objective 2",
    ),
    (
      quest: "What would you like to see improved in existing tools or new tools for integrating vector or motion graphics in real-time applications or games?",
      just: "Identify specific feature or functionality gaps in current technologies.",
      obj: "Research Objective 3",
    ),
    (
      quest: "Do you have any feedbacks or suggestions that could help streamline the workflow of incorporating dynamic vector or motion graphics in game engines or real-time applications?",
      just: "Solicit practical suggestions to improve workflows, targeting a user-centered design approach.",
      obj: "Research Objective 2 and 3",
    ),
  ),
)

#pagebreak()

== Analysis

This chapter is dedicated to the analysis of the data gathered from the questionnaire and interviews.
The questionnaire has acquired a total of 33 respondants while the interview has been held with seven participants.

=== Questionnaire Analysis

==== Section 2: Vector graphics in games

#q_analysis(
  contents: (
    (
      ques: [How important is the use of vector graphics for creating crisp and scalable visuals in games?],
      data: image("assets/analysis/Picture1.png"),
      analysis: [
        The survey results show that the majority of respondents (\~81%) consider vector graphics to be important or very important (ratings of 4 and 5) for creating crisp and scalable visuals in games, highlighting their perceived value in modern game design.
        A moderate 15.2% rated their importance as neutral (3), while only 3% gave a slightly important rating (2), and none rated them as not important (1).
        These findings emphasize the widespread recognition of vector graphics as a critical tool for achieving high-quality visuals across different resolutions and devices.
      ],
    ),
    (
      ques: [What assets would you prefer vector graphics over raster graphics.],
      data: image("assets/analysis/Picture2.png"),
      analysis: [
        The survey results indicate that vector graphics are most preferred for user interfaces, with 63.6% of respondents selecting this category.
        Icons follow closely at 48.5%, highlighting their importance for scalable and clean visuals.
        Particle effects (45.5%) and in-game textures (42.4%) are also notable areas where vector graphics are valued, although to a slightly lesser extent.
        These preferences suggest that vector graphics are particularly suited for assets requiring scalability and clarity, such as UI elements and icons, while their adoption for dynamic and texture-heavy assets like particle effects and in-game textures is comparatively lower.
      ],
    ),
    (
      ques: [Are you familiar with vector graphics concepts, such as scalability and the use of shapes like Bezier curves and polygons?],
      data: image("assets/analysis/Picture3.png"),
      analysis: [
        The survey reveals that familiarity with vector graphics concepts, such as scalability and the use of shapes like Bézier curves and polygons, is almost evenly split among respondents.
        Approximately 51.5% indicated familiarity with these concepts, while 48.5% were not familiar.
        This near-equal divide highlights the varying levels of knowledge about vector graphics within the respondent group and suggests a potential need for greater education or awareness about these technologies, particularly in areas where they can be effectively applied.
      ],
    ),
    (
      ques: [How well do you feel game engines like Unity and Unreal Engine handle vector graphics for both static and animated elements?],
      data: image("assets/analysis/Picture4.png"),
      analysis: [
        The survey reveals varying perceptions of how well Unity and Unreal Engine handle vector graphics for static and animated elements.
        In Unity, the majority of respondents rated its handling as _Moderate_, followed by a significant portion rating it as _Well_.
        A smaller number of respondents rated it _Very well_, while negative ratings (_Very bad_ and _Bad_) were minimal.
        For Unreal Engine, the ratings skew more positively, with _Moderate_ being the most common rating, followed closely by _Well_.
        A noticeable portion rated it as _Very well_, and only a few respondents chose negative ratings.
        These results indicate that while both engines perform adequately, they still does not provide a consistent great user experience as most respondants only recognize it as a moderate integration.
      ],
    ),
    (
      ques: [How are the performance of vector graphics in said game engines?],
      data: image("assets/analysis/Picture5.png"),
      analysis: [
        The survey reveals that the performance of vector graphics in Unity and Unreal Engine varies across different rating categories.
        In Unity, a majority of respondents rated the performance as _Good_, followed by _Moderate_.
        A smaller portion indicated _Very good_, while negative ratings (_Very bad_ and _Bad_) were minimal.
        In contrast, Unreal Engine received higher positive feedback, with the majority rating the performance as _Moderate_ and a noticeable number choosing _Good_ and _Very good_.
        However, negative ratings were slightly fewer compared to Unity.
        This distribution highlights that while both engines deliver adequate performance for vector graphics, Unreal Engine appears to have a stronger perception of positive performance among respondents.
      ],
    ),
    (
      ques: [How challenging do you find it to implement vector graphics in said game engines?],
      data: image("assets/analysis/Picture6.png"),
      analysis: [
        The survey reveals differing levels of difficulty in implementing vector graphics in Unity and Unreal Engine.
        For Unity, the majority of respondents found it _Moderate_, with a smaller number rating it as _Challenging_.
        Only a few considered it _Very challenging_ or _Easy_.
        In Unreal Engine, the response distribution is almost the same, with most respondents rating it as _Moderate_ or _Challenging_, while fewer found it _Easy_ or _Very easy_.
        These results indicate that both engines present challenges in implementing vector graphics, suggesting the need for better tools or workflows to ease the implementation process.
      ],
    ),
  ),
)

#pagebreak()

=== Interview Analysis

#let i_analysis(
  contents: (
    (
      ques: content,
      data: (
        spencer: content,
        david: content,
        raph: content,
        bruce: content,
        cheryl: content,
        elise: content,
        jon: content,
      ),
      analysis: content,
    ),
  ),
) = {
  for (i, cont) in contents.enumerate() {
    let idx = i + 1
    [
      _*Question \##idx:* #cont.ques _

      #table(
        columns: (auto, 1fr),
        [*Spencer*], box(cont.data.spencer),
        [*David*], box(cont.data.david),
        [*Raph*], box(cont.data.raph),
        [*Bruce*], box(cont.data.bruce),
        [*Cheryl*], box(cont.data.cheryl),
        [*Elise*], box(cont.data.elise),
        [*Jon*], box(cont.data.jon),
      )

      #block(
        width: 100%,
        fill: base8.mix((blue, 10%)),
        stroke: base0,
        inset: 10pt,
        radius: 5pt,
      )[
        #underline[*Analysis*]

        #cont.analysis
      ]

    ]
  }
}

#i_analysis(
  contents: (
    (
      ques: [Could you briefly introduce yourself and your background in UI/UX or game development?],
      data: (
        spencer: [
          My background is in traditional computer science but, like many, I wanted to build games.
          I wanted to do so in a big way.
          I have built 3 game engines for fun, but a first vector-native game engine captivated my interests and is what I am working towards.
        ],
        david: [
          I have a background in mathematics and hold a mathematics degree.
          I had done some work on visualizations of scientific models before using BASIC and some general web work in the past.
          I have also used LaTeX before.
          I moved out to rust around 2020/2021, and worked on some tile based UI.
          Later on, I also worked on Bevy UI and contributed quite a lot to it.
          And then I got recruited by Hedra to make a reactive UI using Bevy.
        ],
        raph: [
          My current role is being a research software engineer at Google on the Google Fonts team.
          The main thing that I worked on there is GPU rendering of 2D graphics and fonts.
          I was working on Ghostscript for almost 10 years.
          Before that I also worked on GIMP a litle bit while I was in high school.
          Around 2007, I went from Ghostscript to Google.
          I helped co-found and launch the Google Fonts team back in 2010, which is hugely successfully, powering a significant fraction of all of the websites in the internet now.
          And for almost five years, I was the tech lead on Android, working on the Android UI Toolkit.
          After that, I took a two and a half year break and intended to make a game, but got interested in GPU.
          Then Google reached back and I ended up going back as a researcher.
        ],
        bruce: [
          I have been programming for 30 years and have spent about 10 years in game development.
          After that I have also worked on back-end systems.
          I have written and maintained serveral UI toolkits previously with different level of qualities and usefulness.
          Now I work on a CAD related product about space planning.
          I am currently in a small RnD team of four people in a company of 300 to create the next generation of their technology.
          Because it is in CAD, a lot of it is in vector graphics.
        ],
        cheryl: [
          I am a product designer that is currently working in the client fintech industry.
          I mainly focus on designing for enterprise products and I have been in UI/UX for almost three years, doing freelancing and also some parti-time jobs.
          I have worked with many clients in various projects ranging from websites to software.
          In terms of development, I do have a limited practical knowledge as I come from a data science background.
        ],
        elise: [
          I am a full-time UI/UX designer for a social media app.
          I am also freelancing as a UI/UX designer, mostly focused on designing landing pages for different types of companies.
        ],
        jon: [
          I am a game developer currently in Metronomik and I am a senior game programmer in a lot of areas and I would like to think that I specialize in UI/UX.
          My thesis is also specifically in UI/UX and over the years in my development, I am known as the UI programmer.
        ],
      ),
      analysis: [
        Each participant talks about their background and current work.
        Our participants have a background on UI/UX development (Cheryl, Elise, and Jon), game development (Spencer, David, Bruce, and Jon), software research and development (Bruce), and 2D graphics research (Raph).
      ],
    ),
    (
      ques: [How would you describe your general workflow when designing and implementing vector graphics in applications or games?],
      data: (
        spencer: [
          I have looked into many approaches for artists as a technology lead and decided to adopt SVG and Lottie.
          The general flow is to produce still images in a vector program, which could be Illustrator or Figma.
          Then, animate it in either AfterEffects (with bodymovin).
          I have also looked into all-in-one tools such as LottieLab, Phase, and Rive, in addition to meeting with their respective CEOs.
          LottieLab is currently my recommendation to adopt.
        ],
        david: [
          I made an SDF renderer to render vector graphics for Hedra and use that to rasterize the UI.
          I also used fragment shaders to draw vector graphics such as gradients and lines, though they are quite low level.
          Most of them time when integrating SVGs in games, you might want to use an intermediate format that would be more performant.
        ],
        raph: [
          I do not really spend a lot of my time building applications or games.
          But I can describe how I make the interactive demo for research visualizations.
          The workflow of that is quite personal and idiosyncratic, and most of that is writing Rust code.
          Sometimes I would start with drawing it on paper, which is then converted into SVG using Inkscape.
        ],
        bruce: [
          Unfortunately, we are not artist driven at all as it is difficult especially in a company that does not currently have a large art team (mainly only programmers and industry designers).
          Right now we tend to look at what we need and code up with something that does it.
          But with vector, it is also more flexible.
        ],
        cheryl: [
          Before you start anything, it is important to understand the project requirements and goals, especially from your clients or from your managers.
          After everything is set, the design team should sit down and determine the art direction or maybe the UI direction.
          We rely on third party graphic packs such as unDraw and Figma.
        ],
        elise: [
          It really depends on the context.
          Normally, I include vector graphics as a supporting item instead of just relying on plain texts itself.
          I use Freepik to download SVGs and Adobe Illustrator files.
          It is customizable, for example, I could just change the color if I wanted to.
        ],
        jon: [
          In game development, developers mostly just try to make things look good, as players are not going to zoom in and look into every pixels.
          You just need to make sure it looks nice and concise.
          Implementing user interface is more or less a transferable skill from web development.
          Developers have to take into account of DPI, scalability in terms of screen sizes, making sure it is dynamic, and most importantly intuitive for the users.
          This is especially important in mobile games.
        ],
      ),
      analysis: [
        The responses reveal a broad spectrum of workflows for designing and implementing vector graphics, ranging from traditional design tools to deeply technical, programming-driven approaches.
        Spencer outlined a structured process involving Adobe Illustrator or Figma for static graphics and After Effects with the Bodymovin plug-in for creating Lottie-compatible animations.
        He also explored all-in-one tools like LottieLab, Phase, and Rive, recommending LottieLab for its streamlined workflow, though gaps in fully comprehensive solutions remain.
        Bruce and Raph, operating in resource-constrained environments, rely heavily on programming to create flexible, tailored solutions, with Bruce highlighting the challenges posed by the lack of a dedicated art team and Raph describing a code-driven workflow in Rust that supports his research visualizations.

        David emphasized technical approaches, using SDF renderers and fragment shaders for performance optimization when integrating vector graphics into games, often resorting to intermediate formats for improved efficiency.
        Smaller teams like Cheryl’s and Elise’s lean on third-party resources such as Freepik, unDraw, and Figma to simplify their workflows and meet project requirements.
        Meanwhile, Jon’s perspective highlights the importance of scalability and practicality in game development, where UI design requires adaptability to varying DPI and screen sizes, especially in mobile games.

        Despite the diversity of workflows and tools, a common challenge emerges: there is no single, all-in-one solution capable of handling the entire workload seamlessly.
        Artists, designers, and developers must often rely on a combination of tools and techniques, from manual coding to third-party resources, to meet their goals.
        This fragmentation highlights a significant gap in current workflows, underscoring the need for a comprehensive solution that can streamline the process and reduce the reliance on multiple disconnected tools.
      ],
    ),
    (
      ques: [What are some common challenges or frustrations you encounter with current graphics tools or technologies during development?],
      data: (
        spencer: [
          There is many challenges.
          I am using WebGPU which is not stable on browsers, Lottie is an ever-changing spec with poor documentation and no versioning standard until the last few months, SVG is an extremely large spec and difficult to reduce to the functions my renderer supports, and my renderer (vello) also has many limitations.
          However the largest challenge is likely tooling; there is no good workflow for producing 2D lottie assets complete with bones and sophisticated features.
        ],
        david: [
          Basically cross-platform, always.
          Had a problem with a bug that only occurs on a specific GPU.
          Documentation and resources of WGSL/WGPU is not good which poses a barrier.
        ],
        raph: [
          One of the fundamentals is just performance, you want to be able to express extreme rich content, which often limits what people can do as well as the general art direction into just static elements instead of animated ones.
          There is also shortcuts taken to solve visual artefacts instead of solving the root problem.
        ],
        bruce: [
          Integrating vector art in 2D space with games in a 3D space is really hard in a lot of systems.
          Often it is easy to render it into a texture and billboard into the scene but sometimes it is more expensive than rendering just a texture.
          For Vello, it is a purely 2D solution which does not know anything about the 3D space.
          It would be cool to have something like a color buffer, a normal buffer, and a depth buffer, because it allows you to do things like shadows, edge detection, screen space ambient occlusion, and many other interesting stuffs.
          Another frustration is that when you go into the field of vector, you are dealing with people who think only in 2D.
          Another thing is also about platform supports, where we have to consider whether if technologies will catch up to these new cutting edge technologies like Vello.
        ],
        cheryl: [
          I will take Photoshop as an example.
          It has a lot of features, but in the same time it has a super steep learning curve especially for beginners that have limited knowledge about graphics.
          Besides that, sometimes it is also quite difficult to communicate your graphical expectations with your developers because they might not know what you are actually thinking.
        ],
        elise: [
          There are no main challenges at the moment.
          However, I wish that the tools provided can allow for more customizability on the spot.
        ],
        jon: [
          In game UI development, the tooling is not as robust as web development where you can just drag and drop UI elements.
          It often involves a lot of coding.
          It is also much less convenient as there is a lack of tooling available.
        ],
      ),
      analysis: [
        The responses reflect a wide range of challenges encountered in graphics development, emphasizing both technical and workflow-related obstacles.
        A common theme among participants, such as Spencer and Jon, is the lack of robust tooling tailored to specific needs.
        Spencer highlighted the absence of a streamlined workflow for creating sophisticated 2D Lottie assets, while Jon pointed out the inefficiencies in game UI development compared to the drag-and-drop ease of web development tools.

        Performance and cross-platform compatibility are recurring issues as well.
        David discussed the challenges of addressing bugs that arise on specific GPUs, while Raph emphasized the limitations in rendering rich, dynamic content due to performance constraints, often necessitating compromises in art direction.
        Similarly, Bruce pointed out the difficulties in integrating 2D vector art into 3D spaces, noting the lack of features like color, depth, and normal buffers in current tools, which could unlock advanced techniques such as shadows, ambient occlusion, and edge detection.

        Additionally, the complexity of specifications and documentation poses significant barriers.
        Spencer noted the challenges of working with large, evolving specifications like SVG and Lottie, which are poorly documented and lack stable versioning.
        David also mentioned the inadequate resources for emerging technologies like WGSL/WGPU, further complicating development.

        The responses also shed light on learning curves and communication barriers in graphic design.
        Cheryl highlighted the steep learning curve of tools like Photoshop for beginners and the difficulty in bridging the gap between designers and developers.
        Lastly, Bruce expressed concerns about whether platforms and tools will evolve to support cutting-edge technologies like Vello, emphasizing the uncertainty of adopting innovative solutions in a rapidly changing field.
      ],
    ),
    (
      ques: [In terms of visual quality and performance, what impact do you think vector graphics have on the user experience?],
      data: (
        spencer: [
          Overall, vector graphics will impact UX through resolution-independent UI that is identical on all devices.
          In terms of enjoyment, I also believe there could be many gameplay innovations made by someone mathematically talented and willing to manipulate the image primitives at runtime.
          Some other obvious areas of impact would be accessibility with a toolset of rich styling and scaling at your disposal.
        ],
        david: [
          In terms of performance, it does not matter much, because game UI rarely displays a lot of UI elements.
          Most of the time, it is text that eats up the performance (though most of the time you are just drawing rectangles).
          Vector graphics can also be used in diegetic UI concepts which can make it more immersive.
          You can also perform animations using vector graphics, like animating text.
        ],
        raph: [
          The vocabulary of vector graphics is very rich.
          For text and documents, you need the font to be very high quality.
          It can also be used for animating text's weight and width dynamically.
        ],
        bruce: [
          One big place we see it is in text especially when dealing with stuff outside of Latin text.
          With vector graphics we do not need to worry about rasterizing bitmaps for different types of texts as it is just as easy to rasterize English texts as any other languages.
          We also appreciate the fact that everything flows pretty well when you are able to animate stuff around.
          Some constraints for art pipelines are also gone as you do not need to have massive bitmap graphics for everything.
          It also allows to be playful, for examples, we can use vector graphics to simulate rope physics when connecting two nodes in a node graph.
          This provides that extra interactivity and interest, as well as a sense of tangibility and realism.
          And because it is vector graphics, we also do not need to rely on artist to do everything while being able to provide interesting experience and not worried about the complexity.
        ],
        cheryl: [
          I think that vector graphics are really scalable because it can maintain great quality in any form of resolution.
          In UI/UX we really look into responsiveness as we often design for different screen sizes.
          It also has smaller file size which is a plus.
          It is also a great tool to help to guide users' vision and also increase their awareness in certain items.
        ],
        elise: [
          Animated vector graphics elements can help improve user attractions.
          It can also help ease users in understanding the contents.
          I can also use animated graphics to make users focus on certain areas.
        ],
        jon: [
          Vector graphics have a big impact on user experience, but it really depends on the context.
          For instance, they’re excellent for scalability and maintaining quality on different screen sizes, which is great for responsive designs.
          However, when it comes to more complex animations or detailed visuals, performance can become a challenge.
          It’s always about finding the right balance between technical goals, like resolution independence, and ensuring the user experience is smooth and efficient.
        ],
      ),
      analysis: [
        The responses emphasize the significant role of vector graphics in enhancing both visual quality and performance for user experiences across various applications.
        A key advantage highlighted by multiple respondents, including Spencer, Cheryl, and Jon, is the resolution independence of vector graphics, ensuring consistent visual quality across devices and screen sizes.
        Cheryl and Jon also underscore the importance of scalability and responsiveness, particularly in UI/UX design, where adaptable graphics are essential for maintaining usability on diverse platforms.

        Spencer and Bruce emphasize the potential for innovation with vector graphics, from runtime manipulation of primitives to creative uses like simulating rope physics in node-based systems.
        Bruce notes that vector graphics reduce dependency on bitmap assets, lightening the art pipeline and offering flexibility for playful and interactive designs without requiring extensive artist input.

        From a technical standpoint, David and Raph highlight the impact of vector graphics on performance and animation.
        David points out that vector graphics are well-suited for diegetic UI concepts and text animations, while Raph elaborates on their rich vocabulary, particularly for text rendering and dynamic adjustments to font weight and width.
        Bruce and David both touch on how vector graphics simplify handling diverse text styles and languages, enhancing accessibility and global usability.

        In terms of user interaction, Cheryl and Elise explore how vector graphics can guide user attention and improve content comprehension.
        Elise highlights the use of animations to focus user attention, while Cheryl mentions their potential to guide users' vision and enhance awareness of key elements.
        Jon, however, tempers these benefits with a cautionary note, explaining that complex animations and detailed visuals can introduce performance challenges, necessitating a balance between resolution independence and system efficiency.

        Overall, the analysis reveals that vector graphics bring a wide range of benefits to visual quality, scalability, interactivity, and accessibility.
        However, there is no one-size-fits-all solution; the impact of vector graphics heavily depends on the context of use and the balance between technical constraints and user experience goals.
      ],
    ),
    (
      ques: [Do you currently use vector graphics for interactive or dynamic content in your projects? If so, how effective have they been, and what are the main limitations?],
      data: (
        spencer: [
          I am employing vectors in some unique ways.
          For example, instead of a minimap, I allow the user to zoom out to see the entire map, which then shows map labels.
          The main barrier to more enticing visual features, such as generated vector fire, is a high ceiling for jazz-mathematics, which I am not currently focused on but interested in.
        ],
        david: [
          I have used vector graphics for rendering music visualization before using shaders.
          It is not really flexible because you always have to pass the data in.
          As for SDFs, they have complex transformations, and morphing between shapes is not very easy and is actually quite limited.
        ],
        raph: [_Skipped as Raph does not really create or use vector graphics but rather more on the research side of rendering it._],
        bruce: [
          Yes, they are effective, and their main and biggest limiataions are 2D - 3D integration.
          Little support for color scales like CubeHelix and Viridis which can maintain the luminance of the color in a grayscale gradient, which would also benefit a lot in terms of printing and accessibility, especially for people with color-blind.
        ],
        cheryl: [
          It is not really suitable for most serious scenarios.
          We need to be careful of the placement as it is a constant trade-off between catching attention and formalism.
          Sometimes, it is also a technical hurdle as it might not be trivial to implement.
        ],
        elise: [
          Yes, I use it as a supporting element.
          It is quite effective in a sense that I do not need to design from the scratch itself with vector graphics found online such as Freepik.
        ],
        jon: [
          They are not effective in games which is why games do not use it at all.
          We actually do see vector graphics in games, in the form of 3D models.
          This is achieved through something called the render pipeline.
          The render pipeline is much more efficient in rendering raster images than calculating mathematical equations for rendering vector graphics.
          However, there is still a market for it, but you will have to find the niche.
        ],
      ),
      analysis: [
        The responses reveal mixed experiences and perspectives on using vector graphics for interactive or dynamic content in projects.
        While vector graphics offer certain advantages, their effectiveness and applicability are often context-dependent, with limitations that can hinder broader adoption.

        Spencer and Bruce highlight creative use cases where vector graphics shine.
        Spencer describes an innovative approach, replacing a traditional minimap with a zoomable map featuring vector-based labels, showcasing their flexibility and scalability.
        Bruce, on the other hand, emphasizes their potential for accessibility, particularly in implementing advanced color scales like CubeHelix or Viridis, which could improve usability for colorblind users and support print media.

        Despite these benefits, limitations remain a significant concern.
        David points out the rigidity of using vector graphics in interactive applications, particularly in scenarios requiring morphing or complex transformations, as seen with signed distance fields (SDFs).
        Similarly, Jon notes that vector graphics are often overlooked in games due to the efficiency and suitability of raster-based render pipelines for performance-critical applications.
        While vector graphics have niche applications in game development, they face challenges in competing with established 3D workflows.

        Cheryl and Elise provide additional insights into practical applications and constraints.
        Cheryl highlights the trade-offs between visual appeal and formalism, noting that vector graphics can sometimes be unsuitable for serious or technical contexts due to implementation challenges.
        Elise, meanwhile, values vector graphics as supplementary elements, often relying on pre-designed assets from online resources to save time and effort.

        The overarching theme across the responses is the contextual nature of vector graphics' effectiveness.
        While they excel in scalability, accessibility, and niche use cases, significant barriers remain.
        These include technical hurdles like complex transformations, limited integration with 3D workflows, and a steep learning curve for certain advanced applications.
        As a result, vector graphics are most effective in specialized scenarios, but their adoption for broader interactive or dynamic content remains constrained by these challenges.
      ],
    ),
    (
      ques: [What tools or techniques do you typically use for integrating motion graphics, such as animations from platforms like Lottie, Rive, or After Effects?],
      data: (
        spencer: [
          I wrote a custom integration (Bevy Vello) which loads lottie and SVG files as assets into the bevy game framework to render them.
        ],
        david: [
          Obviously figma, that has been about it.
          Though Lottie and Rive are quite impressive as well.
        ],
        raph: [
          We have done some integration for Lottie (Velato) and Rive.
          I think that generally when people use these tools they tend to be simple animations, and I think that there is potential to scale up.
        ],
        bruce: [
          Right now none, as we are all programmers.
          But we are looking into creating tools like Interpoli that can help in that sense.
          There is also stuff like Manim that allows people to create animations via code.
        ],
        cheryl: [
          I only tried out Lottie.
          It is very user-friendly and is able to cater to Figma quite well as there is a plug-in for it.
          It is also kind of free to use.
          Another alternative is the Figma prototyping tool, but it is mostly for simpler interactions.
        ],
        elise: [
          I use Lottie which has an integration with Figma as a plug-in.
          The Figma plug-in also allow users to export it into a GIF file, allowing more flexibility.
          Sometimes I also use After Effects or Figma to create animations from scratch, though Figma is only better for simpler items.
          This often involves using keyframes to animate vectors from one shape or position to another.
        ],
        jon: [
          Almost no one uses those applications in game development.
          There are three ways motion graphics or animations are performed in games.
          The first way is to code it out in the engine if you want dynamism.
          The second way is to use something like GIF (flipbooks) where you rasterize the animations and just perform a playback in the game.
          The final way is using shaders.
        ],
      ),
      analysis: [
        The responses highlight a variety of tools and techniques for integrating motion graphics, reflecting the diverse approaches employed across different domains and workflows.
        While platforms like Lottie, Rive, and After Effects are widely acknowledged for their capabilities, their adoption and application depend heavily on context, team expertise, and project requirements.

        Spencer and Raph demonstrate a strong inclination towards custom and scalable solutions.
        Spencer has developed Bevy Vello for rendering Lottie and SVG files in the Bevy game engine, emphasizing adaptability for game development.
        Similarly, Raph's work on integrating tools like Lottie (via Velato) and Rive underscores the potential to expand their use beyond simple animations into more complex scenarios.

        Cheryl and Elise focus on accessibility and ease of use.
        Both highlight Lottie's user-friendly integration with Figma through plug-ins, making it a convenient option for designers.
        Cheryl praises Lottie for its free-to-use model and its ability to cater to Figma workflows, while Elise underscores its flexibility in exporting animations into formats like GIF.
        However, both note that while Figma is suitable for simpler animations, more advanced tasks often require tools like After Effects.

        Jon and Bruce represent the developer-centric perspective, emphasizing programming-driven approaches.
        Jon argues that in game development, motion graphics are rarely sourced from platforms like Lottie or Rive.
        Instead, developers rely on three primary methods: engine-level coding for dynamic animations, flipbook-style GIF playback for rasterized animations, and shader-based techniques for flexibility and performance.
        Bruce, on the other hand, points to the lack of tools in programmer-driven environments but sees potential in solutions like Manim, which allows animation creation via code.

        David acknowledges the appeal of tools like Lottie and Rive but indicates a reliance on Figma for animation-related tasks.
        His mention of these platforms' impressive capabilities aligns with their growing reputation for bridging the gap between design and development.

        Overall, the responses underline that while platforms like Lottie, Rive, and After Effects are powerful tools for integrating motion graphics, their use in game development and interactive applications is often supplemented—or even replaced—by custom or code-driven solutions.
        The challenges of scalability, flexibility, and real-time performance often necessitate custom solutions, especially in technical contexts like game engines.
        This indicates that there is no one-size-fits-all solution, and teams must balance ease of use with the technical demands of their projects.
      ],
    ),
    (
      ques: [What would you like to see improved in existing tools or new tools for integrating vector or motion graphics in real-time applications or games?],
      data: (
        spencer: [
          For 2d editors, bones and rigging.
          But I think I would benefit most from a good tool to transform 3d animations into 2d lottie files, which was done once before by a program called Swift3D back in the days of Shockwave Flash.
        ],
        david: [
          Improvement in documentations would be great.
          Also, current tools either have too high level interface with very less control or too low level which requires a lot of technical knowledge.
          I would also like to see better platform support, well as Rust and Bevy support.
          I also hope that tools can help reduce the friction, for example, like reducing the intermediate types needed.
          I also think that dynamic reload is also an important feature.
        ],
        raph: [
          I feel like Béziers are not that intuitive and is difficult for people to get really good results in Béziers.
          And I think that it is more true when you are making animations.
          I think there are curves that are better than Béziers that we should be using and one of them is Euler spirals (though it is only good for smooth curves).
          I feel that we can make a curve that has both the smoothness in spirals and the flexbility of Béziers.
          That is something I would want to see, a better primitives that is more intuitive for designers to use.
        ],
        bruce: [
          For the programmer side, better APIs especially in the Rust world.
          This is also an area where the whole industry are going through big shifts.
          For example, moving from raster tiles to vector tiles, e.g. Open Street Maps.
        ],
        cheryl: [
          I think existing tools can have pre-built components on common patterns and some vector manipulations for developers.
          Some sort of templating tools will also help in reducing time taken to integrate motion graphics or vectors.
        ],
        elise: [
          I would like to see tools that are customizable on the spot.
        ],
        jon: [
          I hope that there are more robust animation tools.
          An example would be to have an animation tool that is inside the game engine itself.
          There could also be a market for vector graphics tools if there are more basis of proof that current techniques are capable of rendering it with similar or better performance than existing techniques.
          This could enable a much more creative usage on vector graphics and therefore ignite a better tool set and a section of game development.
        ],
      ),
      analysis: [
        The responses reflect a variety of improvements desired in existing tools and highlight gaps in current workflows for integrating vector and motion graphics in real-time applications or games.
        Spencer emphasized the need for 2D editor features such as bones and rigging
        He also expresses interest in a tool that could transform 3D animations into 2D Lottie files.
        He referenced Swift3D as an example of such functionality.
        David pointed out the challenges of tools being either overly simplistic or too technically demanding.
        He stressed the need for better documentation, platform support (especially for Rust and Bevy), and features like dynamic reloading, which would streamline workflows and reduce friction in integration.

        Raph highlighted the difficulty in achieving intuitive results with Bézier curves, proposing alternative curve primitives, such as Euler spirals or new hybrids, to improve usability for designers.
        He envisioned smoother, more flexible curve tools that would be easier to manipulate in animation workflows.
        Bruce echoed the need for better APIs, particularly within the Rust ecosystem, while also noting broader industry trends like the shift from raster to vector tiles in mapping applications.
        This shift indicates the growing importance of vector-based technologies and the need for more efficient ways to integrate them into real-time environments.

        Cheryl suggested that pre-built components and templating tools would significantly reduce development time and improve the integration of motion graphics and vectors.
        Elise proposed tools with greater customizability on-the-spot, allowing developers and designers to adapt as needed during the creative process.
        Finally, Jon highlighted the potential for more robust animation tools directly integrated into game engines.
        He also proposed that if vector graphics could be proven to perform as efficiently as traditional methods, it could drive a creative revolution in their use within game development.

        Collectively, these insights suggest a demand for tools that are more intuitive, feature-rich, and accessible, bridging the gap between technical complexity and user-friendliness.
      ],
    ),
    (
      ques: [Do you have any feedbacks or suggestions that could help streamline the workflow of incorporating dynamic vector or motion graphics in game engines or real-time applications?],
      data: (
        spencer: [
          There needs to be as few roadblocks in the way as possible for an artist that wants to hand over an SVG or Lottie to a vector game developer.
          Rather than asking an artist to "get me 4 sizes of this texture, starting from 32x32 and working up to 1024x1024," or adjusting a single wrong color, we should be able to make changes to fit our technology without the aide of the original designer.
        ],
        david: [
          I hope there is much better API to work with GPUs.
          Reduce the overhead of rendering vector graphics or even custom shaders in general.
          I also think that performance should be increased as well as flexbility.
        ],
        raph: [
          I think we can utilize WASM so that the animation player can hot-reload the WASM so you do not need to restart the application everytime.
          It is a very hard problem: you need a way of scripting, you need a way of using tools to create and manage assets.
        ],
        bruce: [
          Better tooling, better API supports, and better hardware support.
        ],
        cheryl: [
          We could create tools to gather feedback on how the animations and actions impact user experience such as checking attention and interaction patterns.
          This can help designers understand the most effective designs for users.
          Impact assessment can also be implement in the form of heat maps.
          A cool example is Hot Jar.
        ],
        elise: [
          Mostly just about the customization of tools and the ability to do everything all in one place.
        ],
        jon: [
          Currently rendering vector graphics in games is almost always done using custom shaders.
          This takes a lot of time and effort to setup which is often time seen as too much of a cost.
          People will want to know if it is worth it compared to how it is normally done using existing tools.
        ],
      ),
      analysis: [
        The feedback regarding streamlining workflows for incorporating dynamic vector or motion graphics in game engines or real-time applications emphasizes several key areas for improvement.
        Spencer advocates for reducing roadblocks between artists and developers, suggesting that artists should be able to provide assets like SVGs or Lottie files without needing to accommodate multiple sizes or color adjustments.
        This would allow developers to make necessary adjustments independently, streamlining the process.

        David proposes that better APIs for GPU interactions could reduce overhead in rendering vector graphics and custom shaders, leading to both improved performance and flexibility.
        Raph suggests utilizing WebAssembly (WASM) to enable hot-reloading of animations, which would eliminate the need to restart applications when updating assets.
        However, he acknowledges that this is a complex challenge requiring better scripting, asset management, and tool integration.

        Bruce calls for better tooling, API support, and hardware compatibility to enhance workflows, while Cheryl suggests creating tools to assess the impact of animations on user experience.
        For example, using heat maps to measure attention and interaction patterns could provide valuable insights to designers.
        Elise emphasizes the importance of tool customization and the ability to manage everything in a unified platform, simplifying the workflow for developers and designers.
        Finally, Jon points out that the process of rendering vector graphics in games often requires custom shaders, which can be time-consuming and might be seen as an inefficient cost compared to using more traditional rendering methods.

        These feedbacks underscores the need for more efficient, integrated tools that balance technical complexity with user-friendly features.
      ],
    ),
  ),
)

=== Conclusion of Interview Analysis

The analysis of all eight questions highlights the diverse perspectives and experiences of participants, offering valuable insights into the current state and future potential of integrating vector and motion graphics into real-time applications and games.

Participants’ backgrounds demonstrate a blend of UI/UX design, game development, and technical research, which informs their varied workflows.
While some rely on traditional design tools like Figma and After Effects, others prefer programming-centric approaches tailored to specific project needs.
A recurring theme is the lack of a single, comprehensive solution, requiring teams to combine multiple tools to meet their objectives.

Challenges are multifaceted, ranging from limited tooling and poor documentation to performance constraints and integration hurdles.
Participants noted gaps in flexibility, scalability, and ease of use, particularly in cross-platform environments.
Vector graphics’ scalability and visual quality are universally acknowledged, but they remain underutilized in game development due to performance trade-offs and integration complexities.

Motion graphics tools like Lottie and Rive are valued for their user-friendly interfaces, yet their applicability in technical contexts often requires custom solutions.
The feedback emphasizes the need for better APIs, dynamic reloading capabilities, and intuitive interfaces for animation workflows.
Additionally, participants see a growing demand for advanced features like 2D rigging, robust curve manipulation, and pre-built components to simplify development.

Key suggestions for improvement include bridging the gap between designers and developers, enabling hot-reloading of assets, and providing better tools for evaluating user interaction with animations.
Enhanced APIs for GPU utilization and tools for streamlined asset integration are also critical for reducing workflow friction.

In conclusion, the findings underscore a clear demand for innovative tools that combine intuitive usability with technical flexibility.
Addressing these gaps could unlock new possibilities for vector and motion graphics, making them integral to real-time applications and game engines.
