#import "@preview/tiaoma:0.3.0"

// ---------------------------------------------------------------------------
// Settings
// ---------------------------------------------------------------------------
// Target play time in minutes, or none to play all words.
// Can be overridden when compiling: typst compile Loanwords-Quiz.typ --input minutes=30
#let target-minutes = {
  let value = sys.inputs.at("minutes", default: "all")
  if value == "all" { none } else { int(value) }
}
// Estimated time per word (word, sentence, solution + discussion).
#let minutes-per-word = float(sys.inputs.at("minutes-per-word", default: "2"))
// Every level keeps at least this many words, no matter how short the quiz is.
#let min-words-per-level = 2

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

#let jump-label(target, display_text) = place(
  bottom + right,
  link(target, text(size: 18pt, weight: "regular", fill: gray, display_text)),
)

// ---------------------------------------------------------------------------
// Words
// ---------------------------------------------------------------------------
// inspiration
// https://en.wikipedia.org/wiki/Loanwords_in_Japanese
// https://en.wikipedia.org/wiki/List_of_gairaigo_and_wasei-eigo_terms
// https://en.wikipedia.org/wiki/List_of_Japanese_words_of_Dutch_origin
// https://de.wikipedia.org/wiki/Liste_deutscher_W%C3%B6rter_in_anderen_Sprachen#Japanisch
//
// format: w(score, language, katakana, romaji, solution, sentence before, sentence after, note: optional fun fact)
// score: 1-5, how interesting/funny the word is. When the quiz is shortened,
// the words with the lowest score in each level are dropped first.
#let w(score, language, katakana, romaji, solution, before, after, note: none) = (
  score: score,
  language: language,
  katakana: katakana,
  romaji: romaji,
  solution: solution,
  before: before,
  after: after,
  note: note,
)

#let levels = (
  (
    name: "Easy",
    words: (
      w(2, "FR", "レストラン", "Resutoran", "Restaurant", "We are going to a ", " for dinner."),
      w(2, "EN", "ワイン", "Wain", "Wine", "I like to drink red ", " with dinner."),
      w(3, "EN", "チョコレート", "Chokoreeto", "Chocolate", "I love eating ", " after dinner."),
      w(3, "EN", "アイスクリーム", "Aisukuriimu", "Ice Cream", "On hot days, I like to eat ", "."),
      w(1, "EN", "ホテル", "Hoteru", "Hotel", "We stayed at a nice ", " during our vacation."),
      w(2, "EN", "カメラ", "Kamera", "Camera", "I bought a new ", " to take pictures on my trip."),
      w(3, "EN", "コンピューター", "Konpyuutaa", "Computer", "My ", " is old, so I want a new one."),
      w(2, "FR", "カフェ", "Kafe", "Café (coffee shop)", "Let's meet at the ", " for coffee."),
      w(4, "NL", "ビール", "Biiru", "Bier (Beer)", "I like drinking a cold ", ".", note: "👉 Fun Fact: In 1889, Dutch loanwords outnumbered English ones in a Japanese dictionary—but today, around 80–90% of loanwords come from English!"),
      w(3, "EN", "トイレ", "Toire", "Toilet", "Teacher, I quickly need to go to the ", "."),
      w(4, "DE", "リュックサック", "Ryukkusakku", "Rucksack (backpack)", "I'll carry a ", " for my trip."),
      w(5, "DE", "アルバイト", "Arubaito", "Arbeit (part-time job)", "He has a ", " as a convenience store clerk."),
      w(2, "EN", "ハロー", "Haroo", "Hello", "I say ", " to my friends when I see them."),
      w(4, "EN", "スマート", "Sumaato", "Smart (slim, stylish, well-dressed)", "He is very ", " and always dresses well."),
    ),
  ),
  (
    name: "Medium",
    words: (
      w(3, "EN", "カラフル", "Karafuru", "Colorful", "The painting is very ", " with many bright colors."),
      w(2, "EN", "ワイヤレス", "Waiyaresu", "Wireless", "My headphones are ", " so I can move around freely."),
      w(4, "PRT", "パン", "Pan", "Pão (bread)", "I eat ", " for breakfast."),
      w(3, "EN", "テレビ", "Terebi", "Television (TV)", "I watch ", " every day."),
      w(4, "DE", "ゲレンデ", "Gerende", "Gelände (ski slope)", "We went skiing on the ", " last weekend."),
      w(1, "EN", "ケーブル", "Keeburu", "Cable", "I need a ", " to connect my computer to the monitor."),
      w(3, "EN", "サービス", "Saabisu", "Service", "The restaurant is known for its excellent ", "."),
      w(2, "EN", "デザイン", "Dezain", "Design", "The new product has a sleek ", "."),
      w(4, "DE", "アレルギー", "Arerugii", "Allergie (allergy)", "I have an ", " to peanuts.", note: "👉 Fun fact: Many medical terms in Japan are German, as German doctors had a major influence in Japan in the 19th century."),
      w(4, "DE", "ギプス", "Gipusu", "Gips (plaster cast)", "He broke his arm and now wears a ", "."),
      w(1, "EN", "ベル", "Beru", "Bell", "The ", " will ring when class begins."),
      w(4, "PRT", "ボタン", "Botan", "Botão (Button)", "Press the ", " to start the machine."),
    ),
  ),
  (
    name: "Hard",
    words: (
      w(2, "EN", "ナイフ", "Naifu", "Knife", "Be careful when using a ", "."),
      w(3, "EN", "ベジタリアン", "Bejitarian", "Vegetarian", "She is a ", " and doesn't eat meat."),
      w(4, "EN", "ワンマン", "WanMan", "One Man (one-person operation)", "This train is a ", " train, so the operator handles everything."),
      w(2, "EN", "パーセント", "Paasento", "Percent", "The discount is 20 ", "."),
      w(3, "NL", "コーヒー", "Koohii", "Koffie (coffee)", "I drink ", " every morning."),
      w(4, "EN", "スーパー", "Suupaa", "Supermarket", "I bought meat at the ", ".", note: "👉 Japan loves to shorten these words, because otherwise they're too long. e.g. スーパーマーケット suupaamaaketto"),
      w(3, "EN", "ラッシュ", "Rasshu", "Rush (Hour)", "I avoid traveling during ", "."),
      w(4, "EN", "レジ", "Reji", "(Cash) Register", "Please pay at the ", "."),
      w(3, "EN", "ボランティア", "Borantia", "Volunteer", "She joined a ", " group after the earthquake."),
      w(3, "EN", "ストーブ", "Sutoobu", "Stove (heater)", "It's cold in winter, so I use a ", "."),
      w(4, "EN", "ホーム", "Hoomu", "(Plat)form", "The train arrives at ", " 5."),
      w(5, "EN", "コンセント", "Konsento", "Concent(ric plug) (electrical outlet)", "I need to plug my laptop into a ", "."),
    ),
  ),
  (
    name: "Crazy",
    words: (
      //w(4, "EN", "カンニング", "Kanningu", "Cunning (cheating on a test)", "He got caught ", " during the exam."),
      w(2, "EN", "ルール", "Ruuru", "Rule", "You must follow the ", " of the game."),
      w(2, "EN", "ゾーン", "Zoon", "Zone", "This is a no-smoking ", "."),
      w(3, "EN", "ホイール", "Hoiiru", "Wheel", "The car has four ", "."),
      w(3, "EN", "キャリアウーマン", "KyariaUuman", "Career Woman", "My sister is a ", " working in a big company."),
      //w(4, "EN", "ラムネ", "Ramune", "Lemona(de)", "I like drinking ", " on hot days.", note: "👉 Fun Fact: Ramune is a old type of spelling the english word in japenese and now it's a popular carbonated soft drink in Japan, known for its unique bottle design with a marble inside. A modern way of spelling lemonade is レモネード (Remoneedo)"),
      w(5, "PRT", "イギリス", "Igirisu", "Inglês (English → Great Britain / UK)", "We speak English in ", "."),
      w(5, "EN", "プラスドライバー", "PurasuDoraibaa", "Plus Driver (Phillips screwdriver)", "You will need a ", " to assemble the new shelf."),
      w(3, "EN", "イラスト", "Irasuto", "Illustration", "There's a cute ", " in the magazine."),
      w(5, "FR", "サボる", "Sabo(ru)", "Sabo(tage) (to skip work or school)", "I don't feel like going to school, so I will ", " on Monday.", note: "👉 The る (ru) ending is for conjugating this verb."),
      w(5, "EN", "ミシン", "Mishin", "(Sewing) Machine", "My grandmother sews her own clothes with a ", ".", note: "👉 From \"sewing machine\": Japan kept only the second half, and \"machine\" became ミシン."),
      w(5, "DE", "ゲシュタルト", "Geshutaruto", "Gestalt", "After staring at kanji too long, I had ", "-collapse.", note: "👉 Example, risk of confusion:\n「女子トイレ」 vs. 「好トイレ」\n(Women's Toilet vs. Preferred Toilet)"),
      w(4, "EN", "ワープロソフト", "WaaPuroSofuto", "Word Processor Software", "I write my essays with a ", "."),
      w(4, "EN", "ポケモン", "PokeMon", "Pocke(t) Mon(sters)", "I love playing ", "."),
    ),
  ),
)

// ---------------------------------------------------------------------------
// Word selection: shorten the quiz to the target play time
// ---------------------------------------------------------------------------
// The available words are split proportionally between the levels (with a minimum
// per level). Within a level the most interesting words (highest score) are kept,
// but they are still played in their original order.
#let selected-levels = {
  let sizes = levels.map(level => level.words.len())
  let total = sizes.sum()
  let minimums = sizes.map(size => calc.min(size, min-words-per-level))
  let target = if target-minutes == none { total } else {
    calc.floor(target-minutes / minutes-per-word)
  }
  target = calc.max(minimums.sum(), calc.min(total, target))

  let exact = sizes.map(size => size * target / total)
  let quotas = exact.zip(minimums).map(((e, m)) => calc.max(m, calc.floor(e)))
  // Hand out remaining words (largest remainder first) or take back extra words
  // caused by the minimums (largest surplus first).
  while quotas.sum() != target {
    let candidates = range(levels.len())
    if quotas.sum() < target {
      candidates = candidates.filter(i => quotas.at(i) < sizes.at(i))
      let i = candidates.sorted(key: i => quotas.at(i) - exact.at(i)).first()
      quotas.at(i) += 1
    } else {
      candidates = candidates.filter(i => quotas.at(i) > minimums.at(i))
      let i = candidates.sorted(key: i => exact.at(i) - quotas.at(i)).first()
      quotas.at(i) -= 1
    }
  }

  levels.zip(quotas).map(((level, quota)) => {
    let kept = level.words.enumerate()
      .sorted(key: ((index, word)) => -word.score) // stable: ties keep original order
      .slice(0, quota)
      .sorted(key: ((index, word)) => index)
      .map(((index, word)) => word)
    (name: level.name, words: kept)
  })
}

#let word-count = selected-levels.map(level => level.words.len()).sum()

// ---------------------------------------------------------------------------
// Slides
// ---------------------------------------------------------------------------
#page(
  align(center + horizon, text(size: 3.7em)[
    = Japanese Loanwords Quiz
    外来語のクイズ

    #text(size: 0.4em, weight: "regular")[
      #word-count words · ≈ #calc.round(word-count * minutes-per-word) min
    ]
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

#let level-target(level-index) = if level-index + 1 < selected-levels.len() {
  label("level-" + str(level-index + 1))
} else {
  <end>
}

#let word-number = 0
#for (level-index, level) in selected-levels.enumerate() {
  page(
    align(center + horizon, text(size: 5em, weight: "bold")[
      #metadata(none)#label("level-" + str(level-index))
      Level #(level-index + 1): #level.name
    ]),
  )
  for word in level.words {
    word-number += 1
    page(
      align(center + horizon, text(size: 6em, weight: "bold")[
        #count-label(str(word-number))
        // #language-label(word.language)

        #word.katakana

        #word.romaji
      ]),
    )
    page(
      align(center + horizon, text(size: 5em)[
        #count-label(str(word-number))
        // #language-label(word.language)

        #word.before#word.romaji#word.after // Romaji version
        // #word.before#word.katakana#word.after // Katakana version
      ]),
    )
    page(
      align(center + horizon, text(size: 5em)[
        #count-label(str(word-number))
        #language-label(word.language)

        #word.katakana

        #word.romaji = #word.solution
        #if word.note != none [
          #note-label(word.note)
        ]
        #jump-label(
          level-target(level-index),
          if level-index + 1 < selected-levels.len() [⏭ Next level] else [⏭ Finish],
        )
      ]),
    )
  }
}

#let repo-url = "https://github.com/Moggla/Japanese-Loanwords-Quiz"
#page(
  align(center, text(size: 2em)[
    #metadata(none) <end>
    Now count your points and see who figured out the most!

    Thank you for playing!
    #link(repo-url)[
      #figure(
        tiaoma.qrcode(repo-url, height: 60%),
      )
      Download this quiz here!
    ]
  ]),
)
