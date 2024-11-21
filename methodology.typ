#import "keywords.typ": *

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

=== Methodology Choice and Justification

For this project, Agile methodology is the preferred choice due to its iterative and user-centered design, which allows the team to remain adaptable in response to feedback and evolving project requirements.
Given the nature of the project, where user feedback and rapid iterations are essential, Agile supports a workflow that promotes ongoing testing, evaluation, and refinement at each stage.

The workflow in Agile will follow a sprint-based cycle, broken down into the following sections:

+ *Planning*\
  Each sprint begins with a planning phase where tasks are identified and assigned based on the project goals for that sprint.
  The team outlines the deliverables, prioritizes tasks, and ensures each team member is clear on their responsibilities.
  Planning ensures that each sprint has a focused objective, with clear milestones to meet.

+ *Design and Development*\
  During the design and development phase, the team works on implementing features and functionalities outlined in the sprint plan.
  Development occurs in small, manageable iterations, with regular check-ins and adjustments to ensure alignment with the sprint’s objectives.
  This phase enables quick adaptability and minimizes the risks of large-scale reworks.

+ *Testing and Feedback*\
  At the end of each sprint, the team conducts testing to ensure that newly developed features are functional and aligned with project requirements.
  Feedback is gathered from relevant stakeholders, and any issues or suggested changes are documented.
  This feedback loop is critical in Agile, as it ensures that adjustments can be made continuously.

+ *Review and Retrospective*\
  After testing, the team performs a sprint review, evaluating both the successes and challenges encountered.
  The retrospective phase allows the team to reflect on the process, identify areas for improvement, and incorporate lessons learned into the next sprint’s planning phase.
  This continuous improvement approach aligns with Agile’s focus on flexibility and adaptability.

By following Agile, the project benefits from a dynamic and responsive workflow that can easily adapt to any changing needs, helping to ensure timely delivery and a user-centered approach.
The flexibility offered by Agile makes it the ideal choice, enabling iterative progress and a focus on evolving project goals and user expectations.

#pagebreak()

== Data Gathering Design

In the research design, data gathering will be conducted using two complementary methods: a questionnaire and an interview.
This dual-method approach aims to balance broad, generalized data from a larger group with in-depth insights from a select group of professionals.

The questionnaire will target a broad audience, serving as the primary method to collect quantitative data on user opinions, experiences, and preferences related to the research topic.
By reaching a larger pool of respondents, the questionnaire enables the gathering of statistically relevant insights and general trends across a wide demographic.
Structured in a way that includes multiple-choice questions, Likert scales, and a few open-ended items, the questionnaire will facilitate an efficient analysis while also allowing for some qualitative feedback @dewi2021understanding.
This design helps to capture both objective data and individual nuances within responses, which can be further analyzed to identify general patterns and correlations.
Additionally, the anonymity provided in the questionnaire encourages honest and diverse opinions from a range of backgrounds, helping to avoid biases that might be present in more direct methods of data collection.

Complementing the questionnaire, the interview component will provide a more nuanced, qualitative perspective by engaging directly with subject matter experts who possess specialized knowledge or expertise in the area of study.
The interviews are designed to gather deeper insights that would not typically be captured in a standardized questionnaire.
Conducted in a semi-structured format, the interview will allow for flexibility, enabling the researcher to probe further into responses based on the interviewee’s expertise.
This format encourages participants to share their informed opinions, elaborate on complex ideas, and provide practical examples, thus enriching the data with professional and real-world insights @dewi2021understanding.
In addition, these expert insights will offer a valuable context for interpreting the trends identified in the questionnaire data, ensuring that the analysis incorporates both user-focused feedback and professional validation.

Together, these two methods will provide a balanced and holistic dataset, with the questionnaire delivering broad quantitative data and the interviews offering rich qualitative insights.
This mixed-method approach not only enhances the credibility and depth of the research findings but also supports a comprehensive understanding of the topic from both the end-user and expert perspectives.
Ultimately, combining these data sources will enable the research to deliver well-rounded conclusions and recommendations that are both broadly applicable and grounded in professional expertise.

#pagebreak()

=== Questionnaire Design

_Section 1: Introduction and Basic Information_

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

  set par(justify: false)
  show figure: set block(breakable: true)
  figure(caption: caption)[
    #table(
      columns: (auto, 1fr, 1fr, 1fr),
      align: left,
      table.header([No.], [Question], [Answer], [Justification]),
      ..table_conts
    )
  ]
}

#ques_design(
  caption: "Section 1 questions, answers, and justifications",
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

_Section 2: Vector graphics in games_

This section provides an overview of the current state of vector graphics in game engines, focusing on feature preferences, implementations, and challenges.
The questions are designed with the assumption that the respondent has a basic understanding of vector graphics.
This is due to the fact that vector graphics implementations in today’s game engines are still relatively limited, which means that many respondents may only be familiar with the basic concepts or have limited experience with more advanced features.
Therefore, the questions aim to capture general insights rather than technical expertise, helping to gauge the broader perceptions and experiences of users with vector graphics in real-time game development.

#let ques_design_obj(
  caption: content,
  quests: ((quest: content, ans: content, just: content, obj: content),),
) = {
  let table_conts = ()
  for (i, q) in quests.enumerate() {
    i += 1
    table_conts.push([#i])
    table_conts.push(q.quest)
    table_conts.push(box(q.ans))
    table_conts.push(q.just)
    table_conts.push(q.obj)
  }

  set par(justify: false)
  show figure: set block(breakable: true)
  figure(caption: caption)[
    #table(
      columns: (auto, 1fr, 1fr, 1fr, 0.6fr),
      align: left,
      table.header(
        [No.],
        [Question],
        [Answer],
        [Justification],
        [Relevant\ Research\ Objective],
      ),
      ..table_conts
    )
  ]
}

#ques_design_obj(
  caption: "Section 2 questions, answers, and justifications",
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
The selected interviewees for this section are experienced developers who have been working professionally in the industry, bringing real-world expertise to the discussion.
This targeted selection allows the interviews to be more in-depth and technical, yielding concrete evidence and examples that can enhance the understanding of practical challenges and benefits associated with vector graphics in real-time game development.
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
      quest: "In your experience, how does the integration of vector or motion graphics impact the user interface or player experience?",
      just: "Understand the perceived effect of these graphics on user engagement, immersion, or overall experience.",
      obj: "Research Objective 1",
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

=== Questionnaire Analysis

=== Interview Analysis
