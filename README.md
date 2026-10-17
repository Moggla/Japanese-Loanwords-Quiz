# Japanese Loanwords Quiz
外来語のクイズ

A small, presentation-style quiz that shows how foreign words are adapted into Japanese.

This quiz started out as a fun side project I made for my coworkers, just something lighthearted to explore how foreign words show up in Japanese. It turned out to be a great way to spark curiosity, even for people with zero background in the language.

The default version shows both Katakana and Romaji, so you don’t need to read Japanese to play. If you’re using it in a classroom setting, you can easily switch off the Romaji in the Typst source and show only Katakana (see [Display Options](README.md#display-options)).

## Highlights
- Shows both Katakana and Romaji by default so no prior Japanese is required.
- Template pages let you toggle Romaji, Katakana, hints, and fun facts.
- Easy to extend: add new words in the Typst source.
- Adjustable length: the quiz is shortened to a target play time and keeps every difficulty level and the most interesting words.
- "⏭ Next level" link on each solution slide to skip ahead during the game.

## Add or Edit Words

Words live in the `#let levels = (...)` block in [Loanwords-Quiz.typ](Loanwords-Quiz.typ), grouped by level (Easy, Medium, Hard, Crazy). Each entry follows this format:

```typ
w(score, language, katakana, romaji, solution, sentence before, sentence after, note: optional fun fact),
```

`score` (1–5) says how interesting or funny a word is. When the quiz is shortened, the words with the lowest score in each level are dropped first.

## Quiz Length

By default all words are played. To shorten the quiz, set a target play time in minutes, either at the top of [Loanwords-Quiz.typ](Loanwords-Quiz.typ) or when compiling:

```sh
typst compile Loanwords-Quiz.typ --font-path ./fonts --input minutes=30
```

The quiz estimates 2 minutes per word (override with `--input minutes-per-word=3`). The words are split proportionally between the levels, and each level keeps at least 2 words. The title slide shows the resulting word count and estimated duration.

## Display Options

Each occurrence of the keyword `page` in the [Loanwords-Quiz.typ](Loanwords-Quiz.typ) produces one PDF page. The three `page` (without `#`) templates at the bottom of that file control how each word page is rendered. There you can remove `//` to activate or add them to deactivate parts.

### Examples

Remove Romaji (show only Katakana):
```typ
#word.katakana

// #word.romaji
```

Use Katakana in sentence instead of Romaji:
```typ
// #word.before#word.romaji#word.after // Romaji version
#word.before#word.katakana#word.after // Katakana version
```

## Building the PDF

A GitHub Actions workflow automatically builds and publishes the PDF on every commit. If you fork this repository, the workflow will run on your fork and produce the PDF automatically — no extra setup required.

**[Download PDF (all words)](https://github.com/Moggla/Japanese-Loanwords-Quiz/releases/download/latest/Loanwords-Quiz.pdf)** · [≈ 60 min](https://github.com/Moggla/Japanese-Loanwords-Quiz/releases/download/latest/Loanwords-Quiz-60min.pdf) · [≈ 30 min](https://github.com/Moggla/Japanese-Loanwords-Quiz/releases/download/latest/Loanwords-Quiz-30min.pdf)

You can still build the PDF without GitHub Actions in one of two easily ways:

### Option 1: Typst Web Editor  
Open the `.typ` file at [typst.app](https://typst.app) and export as PDF.

### Option 2: VS Code with Tinymist Extension  
1. Install the [Tinymist Typst Extension](https://marketplace.visualstudio.com/items?itemName=Tinymist.typst-lsp)  
2. Open the `.typ` file in VS Code  
3. Use `Typst: Compile PDF` from the command palette
