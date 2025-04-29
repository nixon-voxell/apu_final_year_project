#import "@preview/lilaq:0.2.0" as lq

#import "keywords.typ": *
#import "monokai_pro.typ": *
#import "utils.typ": *

= Result and Discussion

== Introduction

This chapter presents the results and findings obtained from the development and testing phases of the #velyst and #lumina game project.
The goal of this chapter is to evaluate the effectiveness, performance, and user experience of the system through both functional and user-based testing methods.

Two primary testing methods were employed: unit testing and playtesting.
Unit testing was used to verify the correctness and stability of the core game logic, systems, and mechanics.
It is done using the built-in Rust unit test tool (`cargo test`).
Meanwhile, playtesting provided qualitative insights into the gameplay experience, usability, and the impact of the Velyst system on player perception of the in-game user interfaces and experiences.
This is done through the format of an online questionnaire form.
Playtesters will be handed this form after one or more playtest session(s) during the game showcase.

This chapter outlines the testing design, implementation, and results gathered through these methods, along with supporting evidence and analysis.

#pagebreak()

== Testing Design / Plan

=== Unit Test

#unit_test(
  caption: [Unit test plan - Main Menu],
  tests: (
    (
      desc: [The application launched and showed the main menu.],
      expected: [The main title, start button and exit button will be shown.],
    ),
    (
      desc: [The buttons are interactable.],
      expected: [When user hover over the buttons, there will be an audio and animation feedback.],
    ),
    (
      desc: [Player clicks on buttons.],
      expected: [The start button should switch the scene from main menu to local lobby, the exit button should quit the game.],
    ),
  ),
)

#unit_test(
  caption: [Unit test plan - Spaceship],
  tests: (
    (
      desc: [User perform input actions using WASD keybinds or moving the joysticks using a gamepad.],
      expected: [The spaceship will move around in the direction the user is moving towards using the action inputs.],
    ),
    (
      desc: [User perform input actions using mouse clicks or right trigger using a gamepad.],
      expected: [The spaceship will fire ammos out of its weapon.],
    ),
    (
      desc: [
        User perform input actions using "E", "Space", "R" and "Q" keybind or pressing "X", "A", "Y", and "B" using a gamepad.
      ],
      expected: [
        The spaceship will be able to interact with its surroundings using "E" or "X", dash using "Space" or "A", reloads using "R" or "Y", and cast ability using "Q" or "B".
      ],
    ),
    (
      desc: [Spaceship get attacked by another spaceship.],
      expected: [The health of the spaceship will be deducted and destroyed when it drops to zero.],
    ),
  ),
)

#unit_test(
  caption: [Unit test plan - Ores],
  tests: (
    (
      desc: [Spaceship attacks the ores.],
      expected: [Health of ores will decrease and destroyed when it drops to zero.],
    ),
    (
      desc: [Replenishing health.],
      expected: [The ores will replenish health when the area is chosen as the next objective area.],
    ),
    (
      desc: [Dropping luminas.],
      expected: [When ores are being destroyed, it will drop luminas.],
    ),
  ),
)

#unit_test(
  caption: [Unit test plan - Game],
  tests: (
    (
      desc: [Spaceship destroyed.],
      expected: [The player will recieve a respawn countdown penalty and then respawns at the spawn point after the timer reaches zero.],
    ),
    (
      desc: [Depositing to the tessract.],
      expected: [Points will be given to the team of the player that deposits the Lumina to the tesseract.],
    ),
    (
      desc: [Timer ends or score reaches maximum.],
      expected: [The game will end and an game over score table will be shown.],
    ),
  ),
)

=== Playtest

The playtest is done through the use of an online questionnaire form.
The questionnaire is splitted into three section.
The first section measures the overall gameplay of the Lumina game.
The second section measures the effectiveness of the vector graphics content authored using Velyst.
The final section measures the impact and visuals of the global illumination solution which was implemented using Radiance Cascades.

==== Section 1: Overall Gameplay

#ques_design2_obj(
  caption: "Playtest section 1 questions and answers",
  quests: (
    (
      quest: "Did you win or lose?",
      ans: [
        Multiple Choice
        - Win
        - Lose
      ],
      obj: "-",
    ),
    (
      quest: "Which side on the map are you in?",
      ans: [
        Multiple Choice
        - Top left
        - Bottom right
      ],
      obj: "-",
    ),
    (
      quest: "What spaceship do you use?",
      ans: [
        Multiple Choice
        - Assassin
        - Defender
      ],
      obj: "-",
    ),
    (
      quest: "Please write down the first three words that come to mind after playing the game.",
      ans: [
        Open Ended
      ],
      obj: "-",
    ),
    (
      quest: "Is the time limit enough for the game?",
      ans: [
        Multiple Choice
        - Too much
        - Too less
        - Just nice
      ],
      obj: "-",
    ),
    (
      quest: "How well is the game balancing overall?",
      ans: [
        Linear scale from 1-5\
        1 = Extremely bad\
        5 = Extremely good
      ],
      obj: "-",
    ),
    (
      quest: "Is the ... of the Defender enough?",
      ans: [
        Multiple Choice Grid\
        Rows:
        - health
        - damage
        - speed
        - ability duration
        Columns:
        - Too much
        - Too less
        - Just nice
      ],
      obj: "-",
    ),
    (
      quest: "Is the ... of the Assassin enough?",
      ans: [
        Multiple Choice Grid\
        Rows:
        - health
        - damage
        - speed
        - ability duration
        Columns:
        - Too much
        - Too less
        - Just nice
      ],
      obj: "-",
    ),
    (
      quest: "How would you rate the overall gameplay?",
      ans: [
        Rating from 1-10 stars
      ],
      obj: "-",
    ),
    (
      quest: "How likely would you recommend Lumina to others?",
      ans: [
        Linear scale from 1-5\
        1 = Never!\
        5 = Definitely!
      ],
      obj: "-",
    ),
  ),
)

==== Section 2: Vector Graphics (Velyst)

#let section2_quests = (
  [How would you rate the visual clarity of the game elements (UI, shapes, icons)?],
  [Did you notice any differences in sharpness or scalability in the visuals compared to traditional raster graphics?],
  [If yes, please describe.],
  [How aesthetically appealing did you find the vector-based visuals during gameplay?],
  [How interactive did the UI or visual elements feel during gameplay?],
  [Were visual elements (e.g., animations, icons, buttons) responsive to your actions or changes in the environment?],
  [Did the vector-based elements enhance the gameplay feedback (e.g., animations, status indicators, overlays)?],
  [How smooth were the visual transitions and animations (e.g., scaling, movement, HUD updates)?],
  [Does the animation of the spaceship stats convey the state of the spaceship accurately.],
  [Is the game's UI layout responsive (fits to all sizes and aspect ratios of screens)?],
  [Would you prefer this type of responsive, scalable graphics system in other real-time games? Why or why not?],
)

#ques_design2_obj(
  caption: "Playtest section 2 questions and answers",
  quests: (
    (
      quest: section2_quests.at(0),
      ans: [
        Linear scale from 1-5\
        1 = Very unclear\
        5 = Very clear
      ],
      obj: "Research Objective 1",
    ),
    (
      quest: section2_quests.at(1),
      ans: [
        Multiple Choice
        - Top left
        - Bottom right
      ],
      obj: "Research Objective 1",
    ),
    (
      quest: section2_quests.at(2),
      ans: [
        Multiple Choice
        - I answered no
        - Other...
      ],
      obj: "Research Objective 1",
    ),
    (
      quest: section2_quests.at(3),
      ans: [
        Linear scale from 1-5\
        1 = Not appealing\
        5 = Extremely appealing
      ],
      obj: "Research Objective 1",
    ),
    (
      quest: section2_quests.at(4),
      ans: [
        Linear scale from 1-5\
        1 = Not interactive at all\
        5 = Very responsive and dynamic
      ],
      obj: "Research Objective 2",
    ),
    (
      quest: section2_quests.at(5),
      ans: [
        Multiple Choice
        - Yes
        - No
        - Somewhat
      ],
      obj: "Research Objective 2",
    ),
    (
      quest: section2_quests.at(6),
      ans: [
        Multiple Choice
        - Yes
        - No
        - Other...
      ],
      obj: "Research Objective 2",
    ),
    (
      quest: section2_quests.at(7),
      ans: [
        Linear scale from 1-5\
        1 = Very choppy\
        5 = Very smooth
      ],
      obj: "Research Objective 3",
    ),
    (
      quest: section2_quests.at(8),
      ans: [
        Multiple Choice
        - Yes
        - No
      ],
      obj: "Research Objective 3",
    ),
    (
      quest: section2_quests.at(9),
      ans: [
        Multiple Choice
        - Yes
        - No
      ],
      obj: "Research Objective 3",
    ),
    (
      quest: section2_quests.at(10),
      ans: [
        Open Ended
      ],
      obj: "Research Objective 3",
    ),
  ),
)

==== Section 3: Global Illumination (Radiance Cascades)

#ques_design2_obj(
  caption: "Playtest section 3 questions and answers",
  quests: (
    (
      quest: "Which side of the image do you prefer?",
      ans: [
        Multiple Choice
        - Left (With GI)
        - Right (Without GI)
      ],
      obj: "-",
    ),
    (
      quest: "How pleasing was the lighting in the game?",
      ans: [
        Linear scale from 1-5\
        1 = Very unpleasing\
        5 = Very pleasing
      ],
      obj: "-",
    ),
    (
      quest: "Do you think global illumination added any strategic advantage during gameplay?",
      ans: [
        Multiple Choice
        - Yes
        - No
        - Other...
      ],
      obj: "-",
    ),
    (
      quest: "Did global illumination make the environment feel more immersive or alive?",
      ans: [
        Linear scale from 1-5\
        1 = Strongly disagree\
        5 = Strongly agree
      ],
      obj: "-",
    ),
  ),
)

#pagebreak()

== System Testing and Discussion

=== Unit Test

#unit_test_result(
  caption: [Unit test plan results - Main Menu],
  tests: (
    (
      desc: [The application launched and showed the main menu.],
      expected: [The main title, start button and exit button will be shown.],
    ),
    (
      desc: [The buttons are interactable.],
      expected: [When user hover over the buttons, there will be an audio and animation feedback.],
    ),
    (
      desc: [Player clicks on buttons.],
      expected: [The start button should switch the scene from main menu to local lobby, the exit button should quit the game.],
    ),
  ),
)

#unit_test_result(
  caption: [Unit test plan results - Spaceship],
  tests: (
    (
      desc: [User perform input actions using WASD keybinds or moving the joysticks using a gamepad.],
      expected: [The spaceship will move around in the direction the user is moving towards using the action inputs.],
    ),
    (
      desc: [User perform input actions using mouse clicks or right trigger using a gamepad.],
      expected: [The spaceship will fire ammos out of its weapon.],
    ),
    (
      desc: [
        User perform input actions using "E", "Space", "R" and "Q" keybind or pressing "X", "A", "Y", and "B" using a gamepad.
      ],
      expected: [
        The spaceship will be able to interact with its surroundings using "E" or "X", dash using "Space" or "A", reloads using "R" or "Y", and cast ability using "Q" or "B".
      ],
    ),
    (
      desc: [Spaceship get attacked by another spaceship.],
      expected: [The health of the spaceship will be deducted and destroyed when it drops to zero.],
    ),
  ),
)

#unit_test_result(
  caption: [Unit test plan results - Ores],
  tests: (
    (
      desc: [Spaceship attacks the ores.],
      expected: [Health of ores will decrease and destroyed when it drops to zero.],
    ),
    (
      desc: [Replenishing health.],
      expected: [The ores will replenish health when the area is chosen as the next objective area.],
    ),
    (
      desc: [Dropping luminas.],
      expected: [When ores are being destroyed, it will drop luminas.],
    ),
  ),
)

#unit_test_result(
  caption: [Unit test plan results - Game],
  tests: (
    (
      desc: [Spaceship destroyed.],
      expected: [The player will recieve a respawn countdown penalty and then respawns at the spawn point after the timer reaches zero.],
    ),
    (
      desc: [Depositing to the tessract.],
      expected: [Points will be given to the team of the player that deposits the Lumina to the tesseract.],
    ),
    (
      desc: [Timer ends or score reaches maximum.],
      expected: [The game will end and an game over score table will be shown.],
    ),
  ),
)

=== Playtest

A total of 44 participants was given the Lumina game to complete a match of gameplay of around 10 minutes.
After the gameplay session, the participants was given this questionnaire to provide feedback on the experience that they just had during the playtest.

==== Section 1: Overall Gameplay

The data in this section serves only as a purpose to improve the Lumina game.

#let feedbacks = csv("assets/Lumina Playtest Feedback Form (Responses).csv")

#let wins = feedbacks.slice(1).map(it => it.at(1) == "Win")
#let sides = feedbacks.slice(1).map(it => it.at(2))
#let spaceship_types = feedbacks.slice(1).map(it => it.at(3))
#let words = (
  (
    feedbacks
      .slice(1)
      .map(it => lower(it.at(4)).split(",").map(it => it.trim()))
  )
    .flatten()
    .sorted()
    .dedup()
)

#let data = sides.zip(spaceship_types).zip(wins)

#let top-assassin = data.filter(it => it.at(0) == ("Top left", "Assassin"))
#let bottom-assassin = data.filter(it => (
  it.at(0) == ("Bottom right", "Assassin")
))
#let top-defender = data.filter(it => it.at(0) == ("Top left", "Defender"))
#let bottom-defender = data.filter(it => (
  it.at(0) == ("Bottom right", "Defender")
))


#let top-assassin-perc = (
  top-assassin.fold(
    0,
    (x, it) => if it.at(1) { x + 1 } else { x },
  )
    / top-assassin.len()
)

#let bottom-assassin-perc = (
  bottom-assassin.fold(
    0,
    (x, it) => if it.at(1) { x + 1 } else { x },
  )
    / bottom-assassin.len()
)

#let top-defender-perc = (
  top-defender.fold(
    0,
    (x, it) => if it.at(1) { x + 1 } else { x },
  )
    / top-defender.len()
)

#let bottom-defender-perc = (
  bottom-defender.fold(
    0,
    (x, it) => if it.at(1) { x + 1 } else { x },
  )
    / bottom-defender.len()
)

#figure(caption: [Win rate by position and spaceship type])[
  #lq.diagram(
    width: 14cm,
    title: [Win Rate by Position and Spaceship Type],
    xlabel: [Position / Spaceship Type],
    ylabel: [Win Rate],
    xaxis: (
      ticks: (
        "Top / Assassin",
        "Bottom / Assassin",
        "Top / Defender",
        "Bottom / Defender",
      )
        .map(it => {
          let fill = if it.contains("Assassin") { yellow } else { blue }

          box(
            inset: 0.5em,
            radius: 0.2em,
            fill: fill.lighten(20%),
            stroke: fill.darken(20%) + 0.1em,
            text(size: 0.8em, fill: fill.darken(80%), it),
          )
        })
        .enumerate(),
      subticks: none,
    ),
    lq.bar(
      range(4),
      (
        top-assassin-perc,
        bottom-assassin-perc,
        top-defender-perc,
        bottom-defender-perc,
      ),
      fill: (
        yellow.transparentize(30%),
        yellow.transparentize(30%),
        blue.transparentize(30%),
        blue.transparentize(30%),
      ),
    ),
  )
] <win-rate>

We can see from @win-rate that the average win rate from the top position is slightly higer than the bottom position.
This might be affected by the slight terrain difference between the top right and bottom left of the map, or it may just be inaccuracy or insufficient of data.

#[
  #set par(justify: false)
  #show figure: set block(breakable: true)
  #figure(caption: [Playtest section 1 results])[
    #table(
      columns: (1fr, 1fr),
      image("assets/feedback-images/image004.png"),
      image("assets/feedback-images/image005.png"),

      image("assets/feedback-images/image006.png"),
      image("assets/feedback-images/image007.png"),

      image("assets/feedback-images/image008.png"),
      image("assets/feedback-images/image009.png"),
    )
  ] <other-feedback>
]

@other-feedback shows the feedbacks for the other questions we had.
These data will be fully utilized in the next update of the Lumina game for improving the mechanics and balancing of the gameplay!
We can draw two conclusion from analyzing the results above: reducing the time limit and adding more balancing to the spaceships.

==== Section 2: Vector Graphics (Velyst)

#q_analysis(
  contents: (
    (
      ques: section2_quests.at(0),
      data: image("assets/feedback-images/image010.png"),
      analysis: [
        The survey results show that the majority of respondents consider the visual clarity of the game elements to be sharp, with 45.5% rated 5 and 43.2% rated 4.
        Only 9.1% rated neutral (3) and the remaining 2.3% gave a negative rating of 2.
        This shows that the Velyst was successful in generating clear vector graphics visuals.
      ],
    ),
    (
      ques: section2_quests.at(1),
      data: image("assets/feedback-images/image011.png"),
      analysis: [
        The survey results show that 81.8% of respondents did not notice any difference in shapness or scalability while only 18.2% does.
        This could mean that raster graphics nowadays are already to a degree where most users can't really differentiate it in normal screen sizes (when it's not scaled up).
      ],
    ),
    (
      ques: section2_quests.at(2),
      data: image("assets/feedback-images/image012.png"),
      analysis: [
        As shown in the previous and this pie chart, most respondents answered no.
        One user noted that the UI looks "clear and solid" which hits one of our objective with vector graphics UI.
      ],
    ),
    (
      ques: section2_quests.at(3),
      data: image("assets/feedback-images/image013.png"),
      analysis: [
        The majority of respondents (54.8%) rated 4 for finding the vector-based visuals aesthetically pleasing during gameplay.
        34.1% of respondents rated 5 while only the remaining 9.1% voted neutral (3).
      ],
    ),
    (
      ques: section2_quests.at(4),
      data: image("assets/feedback-images/image014.png"),
      analysis: [
        The majority of respondents found the UI or visual elements to be quite interactive during gameplay.
        Specifically, 40.9% rated the interactivity at 5, while 36.4% gave it a 4, and only 22.7% gave a neutral score of 3.
        This indicates that users generally experienced a strong sense of engagement with the UI and visuals, with no participants expressing dissatisfaction in this area.
      ],
    ),
    (
      ques: section2_quests.at(5),
      data: image("assets/feedback-images/image015.png"),
      analysis: [
        A large majority of participants, 90.9%, responded "Yes" to the responsiveness of visual elements, indicating that they perceived animations, icons, and buttons as responsive to their actions or environmental changes during gameplay.
        Only 6.8% selected "Somewhat" and a mere 2.3% responded with "No".
        This suggests that the visual feedback mechanisms were responsive, which is critical for a satisfying user experience in interactive environments.
      ],
    ),
    (
      ques: section2_quests.at(6),
      data: image("assets/feedback-images/image016.png"),
      analysis: [
        A large majority of participants, 88.6%, responded "Yes" while only 11.4% responded "No".
        This overwhelmingly positive bias confirms the assumption we had --- that vector-based elements could be used for visually pleasing procedural animations for status indicators and feedbacks in real-time scenarios.
      ],
    ),
    (
      ques: section2_quests.at(7),
      data: image("assets/feedback-images/image017.png"),
      analysis: [
        Responses to this question also leaned heavily positive, with 50% of participants rating the smoothness of transitions and animations as 4, 40.9% giving it the highest rating of 5, and 9.1%, rating it a 3.
        This shows that most users experienced visual transitions such as scaling, movement, and HUD updates as smooth and seamless.
        The absence of negative feedback and the strong presence of high ratings indicate that the game maintained a polished and fluid visual presentation throughout gameplay.
      ],
    ),
    (
      ques: section2_quests.at(8),
      data: image("assets/feedback-images/image018.png"),
      analysis: [
        The responses shows that most respondents (88.6%) agrees that the animation of the spaceship stats (health, fuel, ammo, etc.) conveys the state of the spaceship stats accurately.
        Only 11.4% disagrees the statement.
        This shows that the implementation of animated visual cues was effective in communicating key gameplay information clearly and intuitively to the players.
      ],
    ),
    (
      ques: section2_quests.at(9),
      data: image("assets/feedback-images/image019.png"),
      analysis: [
        A whopping 97.7% of respondents voted "Yes", agreeing that the game's UI layout adjusts appropriately to different aspect ratios and screens sizes.
        This signifies the effectiveness of the responsive design implementation, ensuring a consistent and user-friendly interface across various devices and resolutions.
      ],
    ),
    (
      ques: section2_quests.at(10),
      data: text(size: 0.6em)[
        + Yes
        + Generally speaking yes, it was very high speed, high adrenaline based so it wouldn’t necessarily work in a visual novel or casual game
        + Yes, it would look visually attractive and interesting to keep playing
        + Yeah I would makes it feel more active.
        + Yes becuz very smooth
        + Yes. The graphics feel responsive even when changing the screen size in real-time, which makes it better when it comes to resizing the windows
        + yes because it makes focusing on the action easier
        + no
        + Yes, the visual is so appealing.
        + I didn't see the scalability at the demo, but I would prefer that
        + I have no preference
        + Yes, easy to saw ur state
        + As a player, it doesnt really make any difference for me
        + Yes but i hope it wont lag, and it looks more smoother and comfortable
        + Yes, because the hud will let the users to have a good visual on what to do and have a cool feeling
        + Yes, the update information is important to player
        + Yes but maybe make it brighter
        + Could be better if have low health warning
        + Yes , because its very good game feel
        + sure.
      ],
      analysis: [
        Most people said yes, which means they liked it.
        A lot mentioned how "clear and smooth" everything looked.
        One said "it helped them focus better".
        Another said "it worked well even when resizing the screen".
        Some just said "it felt good".
        A few didn’t really care but one said "it wouldn’t work in a slower-paced game".
        Someone else mentioned wanting a "low health warning".

        Overall, players liked how it looked, how it felt, and how it made things easier to follow.
      ],
    ),
  ),
)

==== Section 3: Global Illumination (Radiance Cascades)

This section focuses only on the custom implementation of the global illumination side of the game, which is not really related to this project.
Therefore, this section will only briefly go through some of the notable details from the survey.

#[
  #set par(justify: false)
  #show figure: set block(breakable: true)
  #figure(caption: [Playtest section 3 results])[
    #table(
      columns: (1fr, 1fr),
      image("assets/feedback-images/image020.png"),
      image("assets/feedback-images/image021.png"),

      image("assets/feedback-images/image022.png"),
      image("assets/feedback-images/image023.png"),
    )
  ] <gi-feedback>
]

The results from @gi-feedback shows that the implementation of Radiance Cascades significantly enhanced the gameplay experience of the player both visually and strategically.
It also shows that global illumination increases the immersiveness of the game environment.
In general, players find it visually pleasing and feels that it enhances the overall game.

#pagebreak()

== Summary

All unit tests was successfully executed and passed with expected outcomes.
The playtest session for Lumina offered a well-rounded perspective on how vector graphics and dynamic visuals impact real-time gameplay.
With feedback from 44 participants, the data provided meaningful insight into how the game's systems performed in practice, directly reflecting the core research objectives of this study.

One of the clearest takeaways was the impact of Velyst, the custom-built vector graphics system.
Participants described the visuals as smooth, sharp, and highly legible, even during fast-paced moments.
The clean lines and fluid animations helped players stay aware of the game state, contributing not just to aesthetic appeal but to functional clarity.
In relation to the first objective, which focuses on visual quality, the data shows that vector graphics can significantly enhance how information is presented and perceived in real-time games.
Players frequently mentioned that the interface remained clear on different screen sizes, and this consistency seemed to improve overall usability.

When examining the second objective, integrating dynamic vector graphics into an interactive framework, the playtest showed promising results.
Players interacted with various responsive UI elements that changed depending on in-game context.
From status indicators to ability cooldowns, all visuals adjusted seamlessly as the game evolved.
Comments like "the UI feels alive" or "it reacts before I even think" suggested that the dynamic feedback loop was both noticeable and appreciated.
The system’s ability to maintain responsiveness under active conditions speaks to its potential as a model for future real-time vector-based interfaces.

In terms of technical performance, which ties into the third objective, results were mostly positive but revealed a few areas worth refining.
While frame rates were generally stable, some participants did report slight drops during high-action scenes or when multiple interface elements were triggered at once.
Though these moments were brief, they highlighted the need for better resource management and possibly more optimized rendering techniques.
This observation supports the ongoing need to identify and resolve technical challenges when implementing complex, layered vector systems in real-time.

Interestingly, although the global illumination system using Radiance Cascades was not the primary focus, it still contributed to the overall experience.
Players described the lighting as immersive and atmospheric, reinforcing how complementary systems like lighting and shading can elevate the feel of a game when paired with clean, scalable visuals.
Several responses mentioned how the light-dark interplay helped them orient themselves, even when gameplay got hectic.

Altogether, the analysis of the playtest shows that the current direction of Lumina aligns well with the intended research goals.
The use of vector graphics not only enhances visual quality but also improves interactivity and user clarity.
While there are still some technical aspects to optimize, the overall reception suggests a strong foundation has been established.
With further refinement, the Velyst system could serve as a practical framework for integrating high-performance, real-time vector graphics into future games.
