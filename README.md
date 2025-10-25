# Japanese Loanwords Quiz
外来語のクイズ

A small, presentation-style quiz that shows how foreign words are adapted into Japanese.

This quiz started out as a fun side project I made for my coworkers, just something lighthearted to explore how foreign words show up in Japanese. It turned out to be a great way to spark curiosity, even for people with zero background in the language.

The default version shows both Katakana and Romaji, so you don’t need to read Japanese to play. If you’re using it in a classroom setting, you can easily switch off the Romaji in the Typst source and show only Katakana (see Display Options).

## Highlights
- Shows both Katakana and Romaji by default so no prior Japanese is required.
- Template pages let you toggle Romaji, Katakana, hints, and fun facts.
- Easy to extend: add new words in the Typst source.

## Add or Edit Words

Words live in the `#let words = (...)` block in [Loanwords Quiz.typ](Loanwords-Quiz.typ). Each entry follows this format:

```typ
#let words = (
  (language, katakana, romaji, solution, sentence before, sentence after, optional fun fact),
)
```

## Display Options

Each occurrence of the keyword `page` in the [Loanwords Quiz.typ](Loanwords-Quiz.typ) produces one PDF page. The three page templates at the bottom of that file control how each word page is rendered. There you can remove `//` to activate or add them to deactivate parts.

### Examples

Remove Romaji (show only Katakana):
```typ
#word.at(1)

// #word.at(2)
```

Use Katakana in sentence instead of Romaji:
```typ
// #word.at(4)#word.at(2)#word.at(5) // Romaji version
#word.at(4)#word.at(1)#word.at(5) // Katakana version
```

## Building the PDF

You can generate the PDF easily using Typst in one of two ways:

### Option 1: Typst Web Editor  
Open the `.typ` file at [typst.app](https://typst.app) and export as PDF.

### Option 2: VS Code with Tinymist Extension  
1. Install the [Tinymist Typst Extension](https://marketplace.visualstudio.com/items?itemName=Tinymist.typst-lsp)  
2. Open the `.typ` file in VS Code  
3. Use `Typst: Compile PDF` from the command palette
