// zosmac.typ — pandoc typst template
// Place at: ~/.pandoc/templates/zosmac.typ


// ── Show terms (pandoc default) ───────────────────────────────────────────
#show terms: it => {
  it.children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
    ])
    .join()
}

// ── Colors ────────────────────────────────────────────────────────────────
#let accent     = rgb("#2E4057")
#let rulecolor  = rgb("#C8D0DA")
#let codebg     = rgb("#F5F6F8")
#let added      = rgb("#2D6A2D")
#let removed    = rgb("#A03030")
#let todocolor  = rgb("#C05000")
#let donecolor  = rgb("#2D6A2D")
#let textgray   = rgb("#6B7280")

// ── Page setup ────────────────────────────────────────────────────────────
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
            $if(title)$$title$$endif$
          ]
        ],
        align(right)[
          #text(fill: accent, size: 9pt)[#page-num]
        ]
      )
      line(length: 100%, stroke: 0.4pt + rulecolor)
    }
  },
  footer: [],
)

// ── Base text ─────────────────────────────────────────────────────────────
#set text(
  font: "Latin Modern Roman",
  size: 11pt,
  lang: "$if(lang)$$lang$$else$en$endif$",
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
  text(fill: accent, size: 13pt, weight: "bold")[#counter(heading).display() #it.body]
  v(0.2em)
  line(length: 100%, stroke: 0.6pt + rulecolor)
  v(0.4em)
}

#show heading.where(level: 2): it => {
  v(1em)
  text(fill: accent, size: 11.5pt, weight: "bold")[#counter(heading).display() #it.body]
  line(length: 100%, stroke: 0.2pt + rulecolor)
  v(0.3em)
}

#show heading.where(level: 3): it => {
  v(0.8em)
  text(fill: accent, size: 11pt, style: "italic")[#counter(heading).display() #it.body]
  v(0.2em)
}

// ── Code blocks ───────────────────────────────────────────────────────────
#show raw.where(block: true): it => {
  set text(font: "Latin Modern Mono", size: 9pt)
  block(
    width: 100%,
    fill: codebg,
    stroke: 0.6pt + rulecolor,
    radius: 3pt,
    inset: (x: 12pt, y: 10pt),
  )[
    #it
  ]
}

#show raw.where(block: false): it => {
  set text(font: "Latin Modern Mono", size: 9.5pt)
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

// ── Title block ───────────────────────────────────────────────────────────
$if(title)$
#align(left)[
  #v(0.5cm)
  #text(fill: accent, size: 22pt, weight: "bold")[$title$]
  #v(0.2em)
  #line(length: 100%, stroke: 1.2pt + accent)
  #v(0.3em)
  #grid(
    columns: (auto, 1fr),
    gutter: 1em,
    $if(author)$
    text(fill: textgray, size: 9.5pt)[$for(author)$$author$$sep$, $endfor$],
    $else$
    [],
    $endif$
    align(right)[
      #text(fill: textgray, size: 9.5pt)[$if(date)$$date$$else$#datetime.today().display()$endif$]
    ]
  )
  #v(0.4cm)
]
$endif$

// ── Table of contents ─────────────────────────────────────────────────────
$if(toc)$
#show outline.entry.where(level: 1): it => {
  v(6pt, weak: true)
  strong(text(fill: accent)[#it])
}
#outline(
  title: text(fill: accent, size: 13pt, weight: "bold")[Contents],
  depth: $if(toc-depth)$$toc-depth$$else$3$endif$,
  indent: 1.5em,
)
#v(0.5cm)
#line(length: 100%, stroke: 0.6pt + rulecolor)
#v(0.5cm)
$endif$

// ── Body ──────────────────────────────────────────────────────────────────
$for(header-includes)$
$header-includes$
$endfor$

$for(include-before)$
$include-before$
$endfor$

$body$

$for(include-after)$
$include-after$
$endfor$
