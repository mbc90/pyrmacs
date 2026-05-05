// zosmac.typ — ox-typst theme
// Place at: ~/.config/typst/zosmac.typ
// Use in org files with:
//   #+INCLUDE: "~/.config/typst/zosmac.typ" export typst

// ── Colors ────────────────────────────────────────────────────────────────
#let accent    = rgb("#2E4057")
#let rulecolor = rgb("#C8D0DA")
#let codebg    = rgb("#F5F6F8")
#let added     = rgb("#2D6A2D")
#let removed   = rgb("#A03030")
#let todocolor = rgb("#C05000")
#let donecolor = rgb("#2D6A2D")
#let textgray  = rgb("#6B7280")

// ── Page ──────────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.8cm, left: 3cm, right: 3cm),
  header: context {
    let page-num = counter(page).get().first()
    if page-num > 1 {
      grid(
        columns: (1fr, auto),
        align(left)[
          #text(fill: accent, style: "italic", size: 9pt)[
            #smallcaps(document.title)
          ]
        ],
        align(right)[
          #text(fill: accent, size: 9pt)[#page-num]
        ]
      )
      line(length: 100%, stroke: 0.4pt + rulecolor)
    }
  },
)

// ── Typography ────────────────────────────────────────────────────────────
#set text(
  font: "Charter",
  size: 11pt,
)

#set par(
  justify: true,
  leading: 0.65em,
  spacing: 1.2em,
)

// ── Headings ──────────────────────────────────────────────────────────────
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  v(1.4em)
  text(fill: accent, size: 13pt, weight: "bold")[
    #if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    #it.body
  ]
  v(0.2em)
  line(length: 100%, stroke: 0.6pt + rulecolor)
  v(0.4em)
}

#show heading.where(level: 2): it => {
  v(1em)
  text(fill: accent, size: 11.5pt, weight: "bold")[
    #if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    #it.body
  ]
  v(0.3em)
}

#show heading.where(level: 3): it => {
  v(0.8em)
  text(fill: accent, size: 11pt, style: "italic")[
    #if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    #it.body
  ]
  v(0.2em)
}

// ── Code blocks ───────────────────────────────────────────────────────────
#show raw.where(block: true): it => {
  set text(font: "Fira Code", size: 9pt)
  block(
    width: 100%,
    fill: codebg,
    stroke: 0.6pt + rulecolor,
    radius: 3pt,
    inset: (x: 12pt, y: 10pt),
  )[#it]
}

#show raw.where(block: false): it => {
  set text(font: "Fira Code", size: 9.5pt)
  box(
    fill: codebg,
    stroke: 0.4pt + rulecolor,
    radius: 2pt,
    inset: (x: 4pt, y: 2pt),
  )[#it]
}

// ── Links ─────────────────────────────────────────────────────────────────
#show link: it => text(fill: accent)[#it]

// ── Tables ────────────────────────────────────────────────────────────────
#set table(
  stroke: (x, y) => if y == 0 {
    (bottom: 1pt + accent)
  } else {
    (bottom: 0.4pt + rulecolor)
  },
  inset: (x: 8pt, y: 6pt),
)
#show table.cell.where(y: 0): it => strong(text(fill: accent)[#it])

// ── Lists ─────────────────────────────────────────────────────────────────
#set list(indent: 1em, marker: text(fill: accent)[•])
#set enum(indent: 1em, numbering: "1.")
