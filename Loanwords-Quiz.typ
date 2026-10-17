#set page("presentation-16-9")
#set document(title: "Japanese Loanword Quiz")
#set text(font: ("Arimo", "Noto Sans JP"))

#let count-label(display_text) = place(
  top + left,
  text(size: 40pt, weight: "regular", display_text),
)

#let language-label(display_text) = place(
  top + right,
  text(size: 40pt, weight: "regular", display_text),
)

#let note-label(display_text) = place(
  bottom + left,
  text(size: 18pt, weight: "regular", display_text),
)

#page(
  align(center + horizon, text(size: 3.7em)[
    = Japanese Loanwords Quiz
    外来語のクイズ
  ]),
)

#page(
  align(left, text(size: 3em)[
    == Overview of Japanese writing systems
    #{
      show table.cell: set text(size: 0.8em)
      table(
        columns: (auto, auto, 1fr),
        stroke: none,
        [- Kanji], [漢字], [Most nouns and meanings],
        [- Hiragana], [ひらがな], [Grammar, particles and conjugations],
        [- Katakana], [カタカナ], [Loanwords (Gairaigo)],
        [- Romaji], [Romaji], [Latin letters],
        [- Emoji], [😊], [🤔],
      )
      note-label(
        "👉 Note: Stylistically, they are sometimes mixed, e.g. for design or emphasis.\n👉 In this quiz: We only use loanwords → i.e. katakana.",
      )
    }
  ]),
)

#page(
  align(left, text(size: 3em)[
    == Tips for the quiz (remember this!)
    #show list: set text(size: 0.6em)
    - Japanese is a syllabic language: consonants need a vowel, usually "U" (after "T"/"D" mostly "O", after "Ch"/"J" mostly "I").
    - No true "V" sound → replaced by "B."
    - No distinction between "R" and "L" → both are written as "R."
    - Sound for "Ha", "Hi", "He", "Ho" exists, but not "Hu". Instead they use "Fu."
    - "Wa" sound exists, but natively not "Wi", "We", "Wu", "Wo."
    #note-label(
      "👉 Fun Fact: They have a character for \"Wo\" (を & ヲ), but it's pronounced \"O\" like the \"O\" from (お & オ).",
    )
  ]),
)

#page(
  align(left, text(size: 3em)[
    == Instructions & Rules
    #show list: set text(size: 0.79em)
    - How to play
      - First, the word is shown on its own.
      - Then a sentence appears in which the word occurs.
      - Finally, the solution is revealed, the game then proceeds to the next word.
    - Scoring
      - Each player writes down their guesses on a separate sheet of paper.
      - You guessed the word alone correctly (+1 Point).
      - You guessed the word when combined with the sentence (+1 Point).
      - (Optionally) you guessed the meaning (+1 Point).
  ]),
)

// inspiration
// https://en.wikipedia.org/wiki/Loanwords_in_Japanese
// https://en.wikipedia.org/wiki/List_of_gairaigo_and_wasei-eigo_terms
// https://en.wikipedia.org/wiki/List_of_Japanese_words_of_Dutch_origin
// https://de.wikipedia.org/wiki/Liste_deutscher_W%C3%B6rter_in_anderen_Sprachen#Japanisch
#let words = (
  // format: (language, katakana, romaji, solution, sentence before, sentence after, optional fun fact)
  // easy words
  ("FR", "レストラン", "Resutoran", "Restaurant", "We are going to a ", " for dinner."),
  ("EN", "ワイン", "Wain", "Wine", "I like to drink red ", " with dinner."),
  ("EN", "チョコレート", "Chokoreeto", "Chocolate", "I love eating ", " after dinner."),
  ("EN", "アイスクリーム", "Aisukuriimu", "Ice Cream", "On hot days, I like to eat ", "."),
  ("EN", "ホテル", "Hoteru", "Hotel", "We stayed at a nice ", " during our vacation."),
  ("EN", "カメラ", "Kamera", "Camera", "I bought a new ", " to take pictures on my trip."),
  ("EN", "コンピューター", "Konpyuutaa", "Computer", "My ", " is old, so I want a new one."),
  ("FR", "カフェ", "Kafe", "Café (coffee shop)", "Let's meet at the ", " for coffee."),
  ("NL", "ビール", "Biiru", "Bier (Beer)", "I like drinking a cold ", ".", "👉 Fun Fact: In 1889, Dutch loanwords outnumbered English ones in a Japanese dictionary—but today, around 80–90% of loanwords come from English!"),
  ("EN", "トイレ", "Toire", "Toilet", "Teacher, I quickly need to go to the ", "."),
  ("DE", "リュックサック", "Ryukkusakku", "Rucksack (backpack)", "I'll carry a ", " for my trip."),
  ("DE", "アルバイト", "Arubaito", "Arbeit (part-time job)", "He has a ", " as a convenience store clerk."),
  ("EN", "ハロー", "Haroo", "Hello", "I say ", " to my friends when I see them."),
  ("EN", "スマート", "Sumaato", "Smart (slim, stylish, well-dressed)", "He is very ", " and always dresses well."),
  // medium words
  ("EN", "カラフル", "Karafuru", "Colorful", "The painting is very ", " with many bright colors."),
  ("EN", "ワイヤレス", "Waiyaresu", "Wireless", "My headphones are ", " so I can move around freely."),
  ("PRT", "パン", "Pan", "Pão (bread)", "I eat ", " for breakfast."),
  ("EN", "テレビ", "Terebi", "Television (TV)", "I watch ", " every day."),
  ("DE", "ゲレンデ", "Gerende", "Gelände (ski slope)", "We went skiing on the ", " last weekend."),
  ("EN", "ケーブル", "Keeburu", "Cable", "I need a ", " to connect my computer to the monitor."),
  ("EN", "サービス", "Saabisu", "Service", "The restaurant is known for its excellent ", "."),
  ("EN", "デザイン", "Dezain", "Design", "The new product has a sleek ", "."),
  ("DE", "アレルギー", "Arerugii", "Allergie (allergy)", "I have an ", " to peanuts.", "👉 Fun fact: Many medical terms in Japan are German, as German doctors had a major influence in Japan in the 19th century."),
  ("DE", "ギプス", "Gipusu", "Gips (plaster cast)", "He broke his arm and now wears a ", "."),
  ("EN", "ベル", "Beru", "Bell", "The ", " will ring when class begins."),
  ("PRT", "ボタン", "Botan", "Botão (Button)", "Press the ", " to start the machine."),
  // hard words
  ("EN", "ナイフ", "Naifu", "Knife", "Be careful when using a ", "."),
  ("EN", "ベジタリアン", "Bejitarian", "Vegetarian", "She is a ", " and doesn't eat meat."),
  ("EN", "ワンマン", "WanMan", "One Man (one-person operation)", "This train is a ", " train, so the operator handles everything."),
  ("EN", "パーセント", "Paasento", "Percent", "The discount is 20 ", "."),
  ("NL", "コーヒー", "Koohii", "Koffie (coffee)", "I drink ", " every morning."),
  ("EN", "スーパー", "Suupaa", "Supermarket", "I bought meat at the ", ".", "👉 Japan loves to shorten these words, because otherwise they're too long. e.g. スーパーマーケット suupaamaaketto"),
  ("EN", "ラッシュ", "Rasshu", "Rush (Hour)", "I avoid traveling during ", "."),
  ("EN", "レジ", "Reji", "(Cash) Register", "Please pay at the ", "."),
  ("EN", "ボランティア", "Borantia", "Volunteer", "She joined a ", " group after the earthquake."),
  ("EN", "ストーブ", "Sutoobu", "Stove (heater)", "It's cold in winter, so I use a ", "."),
  ("EN", "ホーム", "Hoomu", "(Plat)form", "The train arrives at ", " 5."),
  ("EN", "コンセント", "Konsento", "Concent(ric plug) (electrical outlet)", "I need to plug my laptop into a ", "."),
  // crazy words
  //("EN", "カンニング", "Kanningu", "Cunning (cheating on a test)", "He got caught ", " during the exam."),
  ("EN", "ルール", "Ruuru", "Rule", "You must follow the ", " of the game."),
  ("EN", "ゾーン", "Zoon", "Zone", "This is a no-smoking ", "."),
  ("EN", "ホイール", "Hoiiru", "Wheel", "The car has four ", "."),
  ("EN", "キャリアウーマン", "KyariaUuman", "Career Woman", "My sister is a ", " working in a big company."),
  //("EN", "ラムネ", "Ramune", "Lemona(de)", "I like drinking ", " on hot days.", "👉 Fun Fact: Ramune is a old type of spelling the english word in japenese and now it's a popular carbonated soft drink in Japan, known for its unique bottle design with a marble inside. A modern way of spelling lemonade is レモネード (Remoneedo)"),
  ("PRT", "イギリス", "Igirisu", "Inglês (English → Great Britain / UK)", "We speak English in ", "."),
  ("EN", "プラスドライバー", "PurasuDoraibaa", "Plus Driver (Phillips screwdriver)", "You will need a ", " to assemble the new shelf."),
  ("EN", "イラスト", "Irasuto", "Illustration", "There's a cute ", " in the magazine."),
  ("FR", "サボる", "Sabo(ru)", "Sabo(tage) (to skip work or school)", "I don't feel like going to school, so I will ", " on Monday.", "👉 The る (ru) ending is for conjugating this verb."),
  ("EN", "ミシン", "Mishin", "(Sewing) Machine", "My grandmother sews her own clothes with a ", ".", "👉 From \"sewing machine\": Japan kept only the second half, and \"machine\" became ミシン."),
  ("DE", "ゲシュタルト", "Geshutaruto", "Gestalt", "After staring at kanji too long, I had ", "-collapse.", "👉 Example, risk of confusion:\n「女子トイレ」 vs. 「好トイレ」\n(Women's Toilet vs. Preferred Toilet)"),
  ("EN", "ワープロソフト", "WaaPuroSofuto", "Word Processor Software", "I write my essays with a ", "."),
  ("EN", "ポケモン", "PokeMon", "Pocke(t) Mon(sters)", "I love playing ", ".")
)

#for (index, word) in words.enumerate() {
  page(
    align(center + horizon, text(size: 6em, weight: "bold")[
      #count-label(str(index + 1))
      // #language-label(word.at(0))

      #word.at(1)
      
      #word.at(2)
    ]),
  )
  page(
    align(center + horizon, text(size: 5em)[
      #count-label(str(index + 1))
      // #language-label(word.at(0))

      #word.at(4)#word.at(2)#word.at(5) // Romaji version
      // #word.at(4)#word.at(1)#word.at(5) // Katakana version
    ]),
  )
  page(
    align(center + horizon, text(size: 5em)[
      #count-label(str(index + 1))
      #language-label(word.at(0))

      #word.at(1)

      #word.at(2) = #word.at(3)
      #if word.len() == 7 [
        #note-label(word.at(6))
      ]
    ]),
  )
}

#page(
  align(center, text(size: 2em)[
    Now count your points and see who figured out the most!
    
    Thank you for playing!
    #link("https://github.com/Moggla/Japanese-Loanwords-Quiz")[
      #figure(
        image("qr.svg", height: 60%),
      )
      Download this quiz here!
    ]
  ]),
)
