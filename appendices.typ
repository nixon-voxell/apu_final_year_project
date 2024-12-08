= Appendices

== PPF

#figure(caption: [Ethics Form 1])[
  #image("assets/ppf/ppf-01.png", width: 90%)
]

#for i in range(1, 15) {
  let idx = i + 1
  let str_idx = if idx < 10 {
    "0" + str(idx)
  } else {
    str(idx)
  }
  let file = "assets/ppf/ppf-" + str_idx + ".png"
  figure(caption: [PPF #idx])[
    #image(file)
  ]
}

#pagebreak()

== Ethics Form

#for i in range(0, 5) {
  let idx = i + 1
  let file = "assets/ethics/Fast-Track Form - Nixon Cheng-" + str(idx) + ".png"
  figure(caption: [Ethics Form #idx])[
    #image(file)
  ]
}

#figure(caption: [Disclaimer Form])[
  #image("assets/ethics/Disclaimer Form - Nixon Cheng-1.png")
]

== Log Sheets

#figure(caption: [Project log sheet 1])[
  #image("assets/logsheets/oct29.png")
]
#figure(caption: [Project log sheet 2])[
  #image("assets/logsheets/nov8-1.png")
]
#figure(caption: [Project log sheet 3])[
  #image("assets/logsheets/nov8-2.png")
]
#figure(caption: [Project log sheet 4])[
  #image("assets/logsheets/nov15.png")
]

#pagebreak()

== Gantt Chart

#figure(caption: "Gantt Chart")[
  #image("assets/gantt-chart.png")
]

== Respondence Demographic Profile

#let demo_table(resps, genders, ages) = {
  let conts = ()
  for i in range(0, resps.len()) {
    conts.push(resps.at(i))
    conts.push(genders.at(i))
    conts.push(ages.at(i))
  }
  show figure: set block(breakable: true)

  figure(caption: [Respondence Demographic Profile])[
    #set align(left)
    #table(columns: (1fr, 1fr, 1fr), table.header(
        [*Name*],
        [*Gender*],
        [*Age*],
      ), ..conts)
  ]
}

#demo_table(
  (
    "Batman",
    "Jediah",
    "leelien",
    "Mohab ",
    "Zi Qing",
    "vw",
    "Alireza",
    "Kah Boon",
    "Teh Cheng En",
    "Sze",
    "haojin",
    "Karma",
    "MJ",
    "Awacs",
    "e",
    "Rafaya",
    "Jia Hong",
    "Jeremiah ",
    "Tan Jia Hao ",
    "Marcus Cheng",
    "Goh Shao Hang",
    "Nick Jang",
    "GQKEK",
    "Loo",
    "Megat Syawaludin",
    "Jing Heng",
    "Jun Yong",
    "ShiJie",
    "Ming Yu",
    "Xiu Zhen",
    "Diviyan",
    "Brenden Tan",
    "roi ",
  ),
  (
    "Male",
    "Male",
    "Female",
    "Male",
    "Female",
    "Male",
    "Male",
    "Female",
    "Male",
    "Female",
    "Female",
    "Female",
    "Female",
    "Male",
    "Male",
    "Female",
    "Male",
    "Male",
    "Male",
    "Male",
    "Male",
    "Male",
    "Male",
    "Male",
    "Male",
    "Male",
    "Male",
    "Male",
    "Male",
    "Male",
    "Male",
    "Male",
    "Male",
  ),
  (
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "25 - 30",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "25 - 30",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
    "18 - 24",
  ),
)

_Note: the name of the participant can be pseudonyms and not the actual name in protecting the confidentiality_
