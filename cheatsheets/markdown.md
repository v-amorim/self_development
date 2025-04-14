# Markdown Cheatsheet

This is my definitive Markdown cheatsheet. It includes all the Markdown syntax you need to know to create beautiful and professional-looking documents.

## Styling text [^formatting_github]

| Style                       | Syntax <kbd>char`\|text`char</kbd>                                                                                                                          | Keyboard shortcut                             | Example                                                                                                                                                                                    | Output                                                                                                                                                                                         |
| --------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Heading                     | <kbd>#`\|text`</kbd><br><kbd>##`\|text`</kbd><br><kbd>###`\|text`</kbd><br><kbd>####`\|text`</kbd><br><kbd>#####`\|text`</kbd><br><kbd>######`\|text`</kbd> | None                                          | <pre># A first-level heading<br>## A second-level heading<br>### A third-level heading<br>#### A fourth-level heading<br>##### A fifth-level heading<br>###### A sixth-level heading</pre> | <h1>A first-level heading</h1><h2>A second-level heading</h2><h3>A third-level heading</h3><h4>A fourth-level heading</h4><h5>A fifth-level heading</h5><h6>A sixth-level heading</h6>         |
| Horizontal Rule             | <kbd>---</kbd> or <kbd>\*\*\*</kbd>                                                                                                                         | None                                          | <pre>---<br>Text between Horizontal Rules<br>---</pre>                                                                                                                                     | <hr>Text between Horizontal Rules<hr>                                                                                                                                                          |
| Bold                        | <kbd>\*\*`\|text`\*\*</kbd> or <kbd>\_\_`\|text`\_\_</kbd>                                                                                                  | <kbd>Ctrl</kbd>+<kbd>B</kbd>                  | <pre>\*\*This is bold text\*\*</pre>                                                                                                                                                       | **This is bold text**                                                                                                                                                                          |
| Italic                      | <kbd>\*`\|text`\*</kbd> or <kbd>\_`\|text`\_</kbd>                                                                                                          | <kbd>Ctrl</kbd>+<kbd>I</kbd>                  | <pre>\_This text is italicized\_</pre>                                                                                                                                                     | _This text is italicized_                                                                                                                                                                      |
| Strikethrough               | <kbd>\~\~`\|text`\~\~</kbd>                                                                                                                                 | None                                          | <pre>\~\~This was mistaken text\~\~</pre>                                                                                                                                                  | ~~This was mistaken text~~                                                                                                                                                                     |
| Quote                       | <kbd>>`\|quote`</kbd>                                                                                                                                       | <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>.</kbd> | <pre>> Text that is a quote</pre>                                                                                                                                                          | <blockquote>Text that is a quote</blockquote>                                                                                                                                                  |
| Inline code quote           | <kbd>\``\|code`\`</kbd>                                                                                                                                     | <kbd>Ctrl</kbd>+<kbd>E</kbd>                  | <pre>This has an \`inline quote code\` text</pre>                                                                                                                                          | This has an `inline quote code` text                                                                                                                                                           |
| Inline math quote           | <kbd>\$ `equation` \$</kbd>                                                                                                                                 | None                                          | <pre>\$\sqrt{3x-1}+(1+x)^2$</pre>                                                                                                                                                          | <math><mrow><msqrt><mrow><mn>3</mn><mi>x</mi><mo>-</mo><mn>1</mn></mrow></msqrt><mo>+</mo><msup><mrow><mo>(</mo><mn>1</mn><mo>+</mo><mi>x</mi><mo>)</mo></mrow><mn>2</mn></msup></mrow></math> |
| Block code quote            | <kbd>\`\`\`<br>`\|multi-lined-code`<br>\`\`\`</kbd>                                                                                                         | <kbd>Ctrl</kbd>+<kbd>E</kbd>                  | <pre>This has a<br>\`\`\`<br>Block<br>quote<br>code<br>\`\`\`</pre>                                                                                                                        | This has a <pre>Block<br>quote<br>code</pre>                                                                                                                                                   |
| Block math quote            | <kbd>\$\$<br>`\|equation`<br>\$\$</kbd> or <kbd>\`\`\`math<br>`\|equation`<br>\`\`\`</kbd>                                                                  | None                                          | <pre>\$\$<br>f(x) = x^2<br>\$\$</pre>                                                                                                                                                      | <math><mrow><mi>f</mi><mo>(</mo><mi>x</mi><mo>)</mo><mo>=</mo><msup><mi>x</mi><mn>2</mn></msup></mrow></math>                                                                                  |
| Bold and nested italic      | <kbd>\*\*`\|bold`\_`\|italic`\_`\|bold`\*\*</kbd>                                                                                                           | None                                          | <pre>\*\*This text is \_extremely\_ important\*\*</pre>                                                                                                                                    | **This text is _extremely_ important**                                                                                                                                                         |
| All bold and italic         | <kbd>\*\*\_`\|bold-italic`\_\*\*</kbd>                                                                                                                      | None                                          | <pre>\*\*\_All this text is important\_\*\*</pre>                                                                                                                                          | **_All this text is important_**                                                                                                                                                               |
| Subscript                   | <kbd>\<sub>`\|text`\</sub></kbd>                                                                                                                            | None                                          | <pre>This is a \<sub>subscript\</sub> text</pre>                                                                                                                                           | This is a <sub>subscript</sub> text                                                                                                                                                            |
| Superscript                 | <kbd>\<sup>`\|text`\</sup></kbd>                                                                                                                            | None                                          | <pre>This is a \<sup>superscript\</sup> text</pre>                                                                                                                                         | This is a <sup>superscript</sup> text                                                                                                                                                          |
| Sub+Superscript             | <kbd>\<sup>\<sub>`\|text`\</sub>\</sup></kbd>                                                                                                               | None                                          | <pre>\<sup>\<sub>This is a very small text\</sub>\</sup></pre>                                                                                                                             | <sup><sub>This is a very small text</sub></sup>                                                                                                                                                |
| Hidden Comment              | <kbd>\<!--`\|hidden comment`--></kbd>                                                                                                                       | None                                          | <pre>\<!--This is a hidden comment--></pre>                                                                                                                                                |                                                                                                                                                                                                |
| Unordered List              | <kbd>- `\|item`</kbd><br><kbd>\* `\|item`</kbd><br><kbd>+ `\|item`</kbd>                                                                                    | <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>8</kbd> | <pre>- Unordered List Item<br>\* Unordered List Item<br>+ Unordered List Item</pre>                                                                                                        | <ul><li>Unordered List Item</li><li>Unordered List Item</li><li>Unordered List Item</li></ul>                                                                                                  |
| Ordered List                | <kbd>1. `\|item`</kbd>                                                                                                                                      | <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>7</kbd> | <pre>1. Ordered List Item<br>1. Ordered List Item<br>1. Ordered List Item</pre>                                                                                                            | <ol><li>Ordered List Item</li><li>Ordered List Item</li><li>Ordered List Item</li></ol>                                                                                                        |
| Task List                   | <kbd>- \[ \] `\|item`</kbd>                                                                                                                                 | None                                          | <pre>- [ ] Task List Item<br>- [x] Task List Item</pre>                                                                                                                                    | <input type="checkbox"> Task List Item<br><input type="checkbox" checked> Task List Item                                                                                                       |
| Nested List                 | Combine any List syntax                                                                                                                                     | None                                          | <pre>1. First list item<br>&nbsp;&nbsp; - First nested list item<br>&nbsp;&nbsp;&nbsp;&nbsp; - Second nested list item</pre>                                                               | <ol><li>First list item<ul><li>First nested list item<ul><li>Second nested list item</li></ul></li></ul></li></ol>                                                                             |
| Inline Link                 | <kbd>\[`\|text`\]\(`\|url` "`\|hover`"\)</kbd>                                                                                                              | None                                          | <pre>\[GitHub Pages](https://pages.github.com/ "hover info")</pre>                                                                                                                         | [GitHub Pages](https://pages.github.com/ "hover info")                                                                                                                                         |
| Inline Image Link           | <kbd>\!\[`alt-text`](`\|url` "`\|hover`")</kbd>                                                                                                             | None                                          | <pre>\!\[](https://picsum.photos/100/100)</pre>                                                                                                                                            | ![](https://picsum.photos/100/100 "hover info")                                                                                                                                                |
| Reference Link              | <kbd>\[`ref_tag`]: `\|url` "`\|hover`"</kbd>                                                                                                                | None                                          | <pre>\[git_page]: https://pages.github.com/ "hover info"</pre>                                                                                                                             |                                                                                                                                                                                                |
| Inline Link with Ref.       | <kbd>\[`\|text`]\[`ref_tag`]</kbd>                                                                                                                          | None                                          | <pre>\[GitHub Pages]\[git_page]</pre>                                                                                                                                                      | [GitHub Pages][git_page]                                                                                                                                                                       |
| Inline Image Link with Ref. | <kbd>\!\[`alt-text`]\[`ref_tag`]</kbd>                                                                                                                      | None                                          | <pre>\!\[]\[100x100]</pre>                                                                                                                                                                 | ![][100x100]                                                                                                                                                                                   |
| Table                       | <kbd>\| Header 1 \| Header 2 \|<br>\| --- \| --- \|<br>\| Cell A1 \| Cell A2 \|<br>\| Cell B1 \| Cell B2 \|</kbd>                                           | None                                          | <pre>\| Header 1 \| Header 2 \|<br>\| --- \| --- \|<br>\| Cell A1 \| Cell A2 \|<br>\| Cell B1 \| Cell B2 \|</pre>                                                                          | <table><thead><tr><th>Header 1</th><th>Header 2</th></tr></thead><tbody><tr><td>Cell A1</td><td>Cell A2</td></tr><tr><td>Cell B1</td><td>Cell B2</td></tr></tbody></table>                     |
| Footnote                    | <kbd>\[^footnote\]: `\|text-and-or-link`</kbd                                                                                                               | None                                          | <pre>\[^footnote\]This is a footnote</pre>                                                                                                                                                 | This has a footnote. [^footnote]                                                                                                                                                               |
| Collapsible Section         | <kbd>\<details><br>\<summary>`\|summary`\</summary><br><br>`\|text`<br>\</details></kbd>                                                                    | None                                          | <pre>\<details><br>\<summary>Click to expand\</summary><br>This is hidden<br>\</details></pre>                                                                                             | <details><summary>Click to expand</summary>This is hidden</details>                                                                                                                            |
| Text Box                    | <kbd>\<table><br>\<td\><br>`\|text`<br>\</td\>\</table></kbd>                                                                                               | None                                          | <pre>\<table><br>\<td\><br>This is text in the `box`<br>\</td\>\</table></pre>                                                                                                             | <table><td>This is text in the `box`</td></table>                                                                                                                                              |

## Alerts [^alerts]

```markdown
> [!NOTE]
> Highlights information that users should take into account, even when skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]
> Crucial information necessary for users to succeed.

> [!WARNING]
> Critical content demanding immediate user attention due to potential risks.

> [!CAUTION]
> Negative potential consequences of an action.
```

> [!NOTE]
> Highlights information that users should take into account, even when skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]
> Crucial information necessary for users to succeed.

> [!WARNING]
> Critical content demanding immediate user attention due to potential risks.

> [!CAUTION]
> Negative potential consequences of an action.

## Color Preview [^git_colors]

Only in issues, pull requests and discussions, you can call out colors within a sentence by using backticks. A supported color model within backticks will display a visualization of the color.

| Color | Syntax     | Example                       | Output                                                                                                                               |
| ----- | ---------- | ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| HEX   | #RRGGBB    | <pre>#0969DA</pre>            | <img src="https://docs.github.com/assets/cb-1558/mw-1440/images/help/writing/supported-color-models-hex-rendered.webp" height="30">  |
| RGB   | rgb(R,G,B) | <pre>rgb(9, 105, 218)</pre>   | <img src="https://docs.github.com/assets/cb-1962/mw-1440/images/help/writing/supported-color-models-rgb-rendered.webp"  height="30"> |
| HSL   | hsl(H,S,L) | <pre>hsl(212, 92%, 45%)</pre> | <img src="https://docs.github.com/assets/cb-2066/mw-1440/images/help/writing/supported-color-models-hsl-rendered.webp"  height="30"> |

## Relative Links

Relative links and image paths help readers navigate your repository. A relative link points to another file relative to the current file's location. For example, a link in your root README to a file in `docs/CONTRIBUTING.md` would look like:

`[Contribution guidelines for this project](docs/CONTRIBUTING.md)`

GitHub automatically adjusts relative links and paths based on the current branch, ensuring they always work. Links starting with `/` are relative to the repository root. You can use relative link operands like `./` and `../`.

Examples of relative links:

- In a .md file on the same branch `/assets/images/electrocat.png`
- In a .md file on another branch `/../main/assets/images/electrocat.png`
- In issues, pull requests and comments of the repository `../blob/main/assets/images/electrocat.png?raw=true`
- In a .md file in another repository `/../../../../github/docs/blob/main/assets/images/electrocat.png`
- In issues, pull requests and comments of another repository `../../../github/docs/blob/main/assets/images/electrocat.png?raw=true`

## Link a Label [^labels]

You can reference labels in markdown using the following syntax:

```markdown
https://github.com/account/repo/labels/label-name
```

## Light/Dark mode images

Swap out images based on theme settings. [^dark_light_markdown]

Add: `#gh-dark-mode-only` or `#gh-light-mode-only` to the end of the image path to specify which theme the image should be displayed in.

```markdown
![Logo](./dark.png#gh-dark-mode-only)
![Logo](./light.png#gh-light-mode-only)
```

You can now specify whether to display images for light or dark themes in Markdown, using the HTML `<picture>` element in combination with the `prefers-color-scheme` media feature. [^dark_light_html]

```markdown
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/25423296/163456776-7f95b81a-f1ed-45f7-b7ab-8fa810d529fa.png">
  <img alt="Shows an illustrated sun in light color mode and a moon with stars in dark color mode." src="https://user-images.githubusercontent.com/25423296/163456779-a8556205-d0a5-45e2-ac17-42d089e3c3f8.png">
</picture>
```

## Footnotes [^footnotes]

You can add footnotes to your content by using this bracket syntax:

<pre>
[^one_line]Here is a simple footnote.

A footnote can also have multiple[^multi_line] lines.

Can also reference to a link. [^link]

[^one_line]: My reference.
[^multi_line]:
    To add line breaks within a footnote, prefix new lines with 2 spaces.<br>
    This is a second line.

[^link]: Example with URL: https://github.com
</pre>

[^one_line]Here is a simple footnote.

A footnote can also have multiple[^multi_line] lines.

Can also reference to a link. [^link]

## Collapsible Sections

Collapsing large blocks of text can make your markdown much easier to digest

```markdown
<details>
<summary>To make sure markdown is rendered correctly in the collapsed section...</summary>

1.  Put an **empty line** after the `<summary>` block.
2.  _Insert your markdown syntax_
3.  Put an **empty line** before the `</details>` tag

</details>
```

<details>
<summary>To make sure markdown is rendered correctly in the collapsed section...</summary>

1.  Put an **empty line** after the `<summary>` block.
2.  _Insert your markdown syntax_
3.  Put an **empty line** before the `</details>` tag

</details>

## Badges

```markdown
[python_badge]: https://img.shields.io/badge/Python-informational?logo=python&style=flat&logoColor=79dafa&labelColor=282a36&color=ff6e96
[autohotkey_badge]: https://img.shields.io/badge/Auto_Hotkey-informational?logo=autohotkey&style=flat&logoColor=79dafa&labelColor=282a36&color=ff6e96
[ruby_badge]: https://img.shields.io/badge/Ruby-informational?logo=ruby&style=flat&logoColor=79dafa&labelColor=282a36&color=5e4053
```

![][python_badge] ![][autohotkey_badge] ![][ruby_badge]

## Highlighting diff changes

<pre>```diff<br>def calculator_sum(a, b):<br>-  return a - b<br>+  return a + b<br>```</pre>

```diff
def calculator_sum(a, b):
-  return a - b
+  return a + b
```

## Nice looking file tree [^file_tree]

Using the `graphql` syntax in block quotes will nicely highlight file trees like below:

```graphql
./root/*
  ├─ assets/*   # Fonts, icons, images, etc.
  ├─ code/*     # Where the code lives
  │  ├─ main.py # The main file
  │  └─ Other files…
  └─ utils/*    # Utility functions
```

## Text box

Add a box with contents to markdown

```markdown
<table><td>

This is text in the `box`</td></table>
```

<table><td>

This is text in the `box`</td></table>

```markdown
<table><td align="center" width="1000">

This is text in the centered `box`</td></table>
```

<table><td align="center" width="1000">

This is text in the centered `box`</td></table>

## Advanced Table Tips [^advanced_tables]

### Creating a Table

Use pipes `|` and hyphens `-` to create tables. Hyphens define headers, and pipes separate columns. Ensure there's a blank line before the table for correct rendering.

```markdown
| Header 1 | Header 2 |
| -------- | -------- |
| Cell A1  | Cell A2  |
| Cell B1  | Cell B2  |
```

| Header 1 | Header 2 |
| -------- | -------- |
| Cell A1  | Cell A2  |
| Cell B1  | Cell B2  |

### Formatting Table Content

```markdown
| Tool   | Purpose                          |
| ------ | -------------------------------- |
| `ls`   | Display _directory_ contents     |
| `grep` | Search for **specific** patterns |
```

| Tool   | Purpose                          |
| ------ | -------------------------------- |
| `ls`   | Display _directory_ contents     |
| `grep` | Search for **specific** patterns |

### Aligning Text

Align text left, center, or right using colons `:` in the header row.

```markdown
| Left Align | Center Align | Right Align |
| :--------- | :----------: | ----------: |
| Item A     |    Item B    |      Item C |
| Item D     |    Item E    |      Item F |
```

| Left Align | Center Align | Right Align |
| :--------- | :----------: | ----------: |
| Item A     |    Item B    |      Item C |
| Item D     |    Item E    |      Item F |

### Images on tables

```markdown
|                  First Image                   |                  Second Image                   |
| :--------------------------------------------: | :---------------------------------------------: |
| ![First Image](https://picsum.photos/1260/750) | ![Second Image](https://picsum.photos/1260/750) |
```

|                  First Image                   |                  Second Image                   |
| :--------------------------------------------: | :---------------------------------------------: |
| ![First Image](https://picsum.photos/1260/750) | ![Second Image](https://picsum.photos/1260/750) |

### Table within a Table [^git_achievements]

```markdown
|                         Image                          |                                                                                                                                                                                                                    Table Inside Table                                                                                                                                                                                                                     |
| :----------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| ![Heart On Your Sleeve](https://picsum.photos/150/150) | <table> <thead> <tr> <th>Header</th> <th>Example</th> <th>Example</th> </tr> </thead> <tbody> <tr> <td align="center"><img src="https://picsum.photos/150/150" width="150px"></td> <td><img src="https://picsum.photos/100/150" width="100px" align="center"></td> <td><img src="https://picsum.photos/75/75" width="75px"></td> </tr> <tr> <td align="center">Info</td> <td align="center">(?)</td> <td align="center">Info</td> </tr> </tbody> </table> |
```

|                         Image                          |                                                                                                                                                                                                                    Table Inside Table                                                                                                                                                                                                                     |
| :----------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| ![Heart On Your Sleeve](https://picsum.photos/150/150) | <table> <thead> <tr> <th>Header</th> <th>Example</th> <th>Example</th> </tr> </thead> <tbody> <tr> <td align="center"><img src="https://picsum.photos/150/150" width="150px"></td> <td><img src="https://picsum.photos/100/150" width="100px" align="center"></td> <td><img src="https://picsum.photos/75/75" width="75px"></td> </tr> <tr> <td align="center">Info</td> <td align="center">(?)</td> <td align="center">Info</td> </tr> </tbody> </table> |

## Advanced Formatting Tips [^advanced_md]

### `left` alignment

<img align="left" width="100" height="100" src="https://picsum.photos/100/100">

This is the code you need to align images to the left:

```markdown
<img align="left" width="100" height="100" src="https://picsum.photos/100/100">
```

---

### `right` alignment

<img align="right" width="100" height="100" src="https://picsum.photos/100/100">

This is the code you need to align images to the right:

```markdown
<img align="right" width="100" height="100" src="https://picsum.photos/100/100">
```

---

### `center` alignment example

<p align="center">
  <img width="460" height="300" src="https://picsum.photos/460/300">
</p>

```markdown
<p align="center">
  <img width="460" height="300" src="https://picsum.photos/460/300" />
</p>
```

---

### Horizontal images no gap

via [comment](https://gist.github.com/DavidWells/7d2e0e1bc78f4ac59a123ddf8b74932d?permalink_comment_id=4536101#gistcomment-4536101)

```markdown
<p>
  <img src="https://picsum.photos/100/100" />
  <img src="https://picsum.photos/100/100" />
</p>
```

<p>
    <img src="https://picsum.photos/100/100" >
    <img src="https://picsum.photos/100/100" >
</p>

---

### Horizontal images with gap

With `hspace` property you can set horizontal (left and right) padding for an image

```markdown
<p>
  <img src="https://picsum.photos/100/100" hspace="10" />
  <img src="https://picsum.photos/100/100" hspace="10" />
</p>
```

<p>
    <img src="https://picsum.photos/100/100" hspace="10" >
    <img src="https://picsum.photos/100/100" hspace="10" >
</p>

---

### Vertical images with gap

We also have a property "vspace", which does what it sounds like, add vertical spacing. But it doesn't seem to work on GitHub, unlike VSCode's buit in markdown viewer. So probably just add a `<p>` tag in between.

```markdown
<p>
  <img src="https://picsum.photos/500/100" />
</p>

<p>
  <img src="https://picsum.photos/500/100" />
</p>

<p>
  <img src="https://picsum.photos/500/100" />
</p>
```

<p>
    <img src="https://picsum.photos/500/100"  >
    <p>
    <img src="https://picsum.photos/500/100" >
    <p>
    <img src="https://picsum.photos/500/100" >
</p>

## Diagrams [^diagrams]

GitHub now supports the following diagram types:

| content type | supported extensions |
| ------------ | -------------------- |
| mermaid      | `.mermaid`, `.mmd`   |
| geoJSON      | `.geojson`, `.json`  |
| topoJSON     | `.topojson`, `.json` |
| STL          | `.stl`               |

<details>
 <summary>Mermaid</summary><br>

<details>
 <summary>Examples</summary>

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

---

```mermaid
sequenceDiagram
    Alice->>+John: Hello John, how are you?
    Alice->>+John: John, can you hear me?
    John-->>-Alice: Hi Alice, I can hear you!
    John-->>-Alice: I feel great!
```

</details>

<details>
 <summary>Basics</summary>

```mermaid
flowchart LR
    id
```

---

```mermaid
flowchart LR
    id1[This is the text in the box]
```

---

```mermaid
flowchart LR
    id["This ❤ Unicode"]
```

---

```mermaid
%%{init: {"flowchart": {"htmlLabels": false}} }%%
flowchart LR
    markdown["`This **is** _Markdown_`"]
    newLines["`Line 1
               Line 2
               Line 3`"]
    markdown --> newLines

```

---

```mermaid
flowchart LR
    id1[This is the text in the box]
```

</details>

<details>
 <summary>Direction</summary>

Possible FlowChart orientations are:

TB - Top to bottom<br>
TD - Top-down/ same as top to bottom<br>
BT - Bottom to top<br>
RL - Right to left<br>
LR - Left to right

```mermaid
flowchart TB
    Start --> Stop
```

---

```mermaid
flowchart TD
    Start --> Stop
```

---

```mermaid
flowchart BT
    Start --> Stop
```

---

```mermaid
flowchart RL
    Start --> Stop
```

---

```mermaid
flowchart LR
    Start --> Stop
```

</details>

<details>
 <summary>Node shapes</summary>

A node with round edges

```mermaid
flowchart LR
    id1(This is the text in the box)
```

---

A stadium-shaped node

```mermaid
flowchart LR
    id1([This is the text in the box])
```

---

A node in a subroutine shape

```mermaid
flowchart LR
id1[[This is the text in the box]]
```

---

A node in a cylindrical shape

```mermaid
flowchart LR
id1[(Database)]
```

---

A node in the form of a circle

```mermaid
flowchart LR
id1((This is the text in the circle))
```

---

A node in an asymmetric shape

```mermaid
flowchart LR
id1>This is the text in the box]
```

---

A node (rhombus)

```mermaid
flowchart LR
id1{This is the text in the box}
```

---

A hexagon node

```mermaid
flowchart LR
id1{{This is the text in the box}}
```

---

Parallelogram

```mermaid
flowchart TD
id1[/This is the text in the box/]
```

---

Parallelogram alt

```mermaid
flowchart TD
id1[\This is the text in the box\]
```

---

Trapezoid

```mermaid
flowchart TD
A[/Christmas\]
```

---

Trapezoid alt

```mermaid
flowchart TD
B[\Go shopping/]
```

---

Double circle

```mermaid
flowchart TD
id1(((This is the text in the circle)))
```

</details>

<details>
 <summary>Links between nodes</summary>

A link with arrow head

```mermaid
flowchart LR
    A-->B
```

---

An open link

```mermaid
flowchart LR
    A --- B
```

---

Text on links

```mermaid
flowchart LR
    A-- This is the text! ---B
```

or

```mermaid
flowchart LR
    A---|This is the text|B
```

---

A link with arrow head and text

```mermaid
flowchart LR
    A-->|text|B
```

or

```mermaid
flowchart LR
    A-- text -->B
```

---

Dotted link

```mermaid
flowchart LR
   A-.->B;
```

---

Dotted link with text

```mermaid
flowchart LR
   A-. text .-> B
```

---

Thick link

```mermaid
flowchart LR
   A ==> B
```

---

Thick link with text

```mermaid
flowchart LR
   A == text ==> B
```

---

An invisible link
This can be a useful tool in some instances where you want to alter the default positioning of a node.

```mermaid
flowchart LR
    A ~~~ B
```

---

Chaining of links

```mermaid
flowchart LR
   A -- text --> B -- text2 --> C
```

It is also possible to declare multiple nodes links in the same line as per below:

```mermaid
flowchart LR
   a --> b & c--> d
```

You can then describe dependencies in a very expressive way. Like the one-liner below:

```mermaid
flowchart TB
    A & B--> C & D
```

If you describe the same diagram using the basic syntax, it will take four lines. A word of warning, one could go overboard with this making the flowchart harder to read in markdown form. The Swedish word lagom comes to mind. It means, not too much and not too little. This goes for expressive syntaxes as well.

```mermaid
flowchart TB
    A --> C
    A --> D
    B --> C
    B --> D
```

</details>

<details>
 <summary>Arrow Types</summary>

Triangle edge

```mermaid
flowchart LR
   A --> B
```

---

Circle edge

```mermaid
flowchart LR
    A --o B
```

---

Cross edge

```mermaid
flowchart LR
    A --x B
```

---

Multi Directional edges

```mermaid
flowchart LR
    A o--o B
    B <--> C
    C x--x D

```

</details>

<details>
 <summary>Link Lenght</summary>

Add more dashes to increase the length of the link

```mermaid
flowchart TD
    A[Start] --> B{Is it?}
    B -->|Yes| C[OK]
    C --> D[Rethink]
    D --> B
    B ---->|No| E[End]
```

Here are how you should add dashes to increase the length of the link:

| Length            | 1    | 2     | 3      |
| ----------------- | ---- | ----- | ------ |
| Normal            | ---  | ----  | -----  |
| Normal with arrow | -->  | --->  | ---->  |
| Thick             | ===  | ====  | =====  |
| Thick with arrow  | ==>  | ===>  | ====>  |
| Dotted            | -.-  | -..-  | -...-  |
| Dotted with arrow | -.-> | -..-> | -...-> |

</details>

<details>
 <summary>Subgraphs</summary>

```
subgraph title
graph definition
end
```

An example below:

```mermaid
flowchart TB
    c1-->a2
    subgraph one
    a1-->a2
    end
    subgraph two
    b1-->b2
    end
    subgraph three
    c1-->c2
    end
```

You can also set an explicit id for the subgraph.

```mermaid
flowchart TB
    c1-->a2
    subgraph ide1 [one]
    a1-->a2
    end
```

With the graphtype flowchart it is also possible to set edges to and from subgraphs as in the flowchart below.

```mermaid
flowchart TB
    c1-->a2
    subgraph one
    a1-->a2
    end
    subgraph two
    b1-->b2
    end
    subgraph three
    c1-->c2
    end
    one --> two
    three --> two
    two --> c2
```

With the graphtype flowcharts you can use the direction statement to set the direction which the subgraph will render like in this example.

- If any of a subgraph's nodes are linked to the outside, subgraph direction will be ignored. Instead the subgraph will inherit the direction of the parent graph

```mermaid
flowchart LR
  subgraph TOP
    direction TB
    subgraph B1
        direction RL
        i1 -->f1
    end
    subgraph B2
        direction BT
        i2 -->f2
    end
  end
  A --> TOP --> B
  B1 --> B2
```

</details>

<details>
 <summary>Formatting</summary>

Markdown Strings

The "Markdown Strings" feature enhances flowcharts and mind maps by offering a more versatile string type, which supports text formatting options such as bold and italics, and automatically wraps text within labels.

Formatting:

For bold text, use double asterisks (\*_) before and after the text.<br>
For italics, use single asterisks (_) before and after the text.<br>
With traditional strings, you needed to add <br> tags for text to wrap in nodes. However, markdown strings automatically wrap text when it becomes too long and allows you to start a new line by simply using a newline character instead of a <br> tag.<br>
This feature is applicable to node labels, edge labels, and subgraph labels.

```mermaid
%%{init: {"flowchart": {"htmlLabels": false}} }%%
flowchart LR
subgraph "One"
  a("`The **cat**
  in the hat`") -- "edge label" --> b{{"`The **dog** in the hog`"}}
end
subgraph "`**Two**`"
  c("`The **cat**
  in the hat`") -- "`Bold **edge label**`" --> d("The dog in the hog")
end
```

---

Interaction

It is possible to bind a click event to a node, the click can lead to either a javascript callback or to a link which will be opened in a new browser tab.

```mermaid
flowchart LR
    A-->B
    B-->C
    C-->D
    click A callback "Tooltip for a callback"
    click B "https://www.github.com" "This is a tooltip for a link"
    click D href "https://www.github.com" "This is a tooltip for a link"
```

</details>
</details>

<details>
 <summary>GeoJSON</summary>

```geojson
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "id": 1,
      "properties": {
        "ID": 0
      },
      "geometry": {
        "type": "Polygon",
        "coordinates": [
          [
            [
              -90,
              35
            ],
            [
              -90,
              30
            ],
            [
              -85,
              30
            ],
            [
              -85,
              35
            ],
            [
              -90,
              35
            ]
          ]
        ]
      }
    }
  ]
}
```

</details>

<details>
 <summary>TopoJSON</summary>

```topojson
{
  "type": "Topology",
  "transform": {
    "scale": [
      0.0005000500050005,
      0.00010001000100010001
    ],
    "translate": [
      100,
      0
    ]
  },
  "objects": {
    "example": {
      "type": "GeometryCollection",
      "geometries": [
        {
          "type": "Point",
          "properties": {
            "prop0": "value0"
          },
          "coordinates": [
            4000,
            5000
          ]
        },
        {
          "type": "LineString",
          "properties": {
            "prop0": "value0",
            "prop1": 0
          },
          "arcs": [
            0
          ]
        },
        {
          "type": "Polygon",
          "properties": {
            "prop0": "value0",
            "prop1": {
              "this": "that"
            }
          },
          "arcs": [
            [
              1
            ]
          ]
        }
      ]
    }
  },
  "arcs": [
    [
      [
        4000,
        0
      ],
      [
        1999,
        9999
      ],
      [
        2000,
        -9999
      ],
      [
        2000,
        9999
      ]
    ],
    [
      [
        0,
        0
      ],
      [
        0,
        9999
      ],
      [
        2000,
        0
      ],
      [
        0,
        -9999
      ],
      [
        -2000,
        0
      ]
    ]
  ]
}
```

</details>

<details>
 <summary>STL</summary>

```stl
solid cube_corner
  facet normal 0.0 -1.0 0.0
    outer loop
      vertex 0.0 0.0 0.0
      vertex 1.0 0.0 0.0
      vertex 0.0 0.0 1.0
    endloop
  endfacet
  facet normal 0.0 0.0 -1.0
    outer loop
      vertex 0.0 0.0 0.0
      vertex 0.0 1.0 0.0
      vertex 1.0 0.0 0.0
    endloop
  endfacet
  facet normal -1.0 0.0 0.0
    outer loop
      vertex 0.0 0.0 0.0
      vertex 0.0 0.0 1.0
      vertex 0.0 1.0 0.0
    endloop
  endfacet
  facet normal 0.577 0.577 0.577
    outer loop
      vertex 1.0 0.0 0.0
      vertex 0.0 1.0 0.0
      vertex 0.0 0.0 1.0
    endloop
  endfacet
endsolid
```

</details>

<!-- URLS -->

[^formatting_github]: https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/
[^footnote]: This is a footnote
[^alerts]: https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alertsbasic-writing-and-formatting-syntax
[^git_colors]: https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#supported-color-models
[^labels]: https://github.blog/changelog/2022-02-03-reference-labels-in-markdown/
[^dark_light_markdown]: https://github.blog/changelog/2021-11-24-specify-theme-context-for-images-in-markdown/
[^dark_light_html]: https://github.blog/changelog/2022-05-19-specify-theme-context-for-images-in-markdown-beta/
[^footnotes]: https://github.blog/changelog/2021-09-30-footnotes-now-supported-in-markdown-fields/
[^one_line]: My reference.
[^multi_line]:
    To add line breaks within a footnote, prefix new lines with 2 spaces.<br>
    This is a second line.

[^link]: Example with URL: https://github.com
[^file_tree]: https://twitter.com/alexdotjs/status/1421015442286596100
[^advanced_tables]: https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/organizing-information-with-tables
[^git_achievements]: https://github.com/drknzz/GitHub-Achievements
[^advanced_md]: https://github.com/DavidWells/advanced-markdown
[^diagrams]: https://github.blog/changelog/2022-03-17-mermaid-topojson-geojson-and-ascii-stl-diagrams-are-now-supported-in-markdown-and-as-files/

[git_page]: https://pages.github.com/ "hover info"
[100x100]: https://picsum.photos/100/100 "hover info"
[python_badge]: https://img.shields.io/badge/Python-informational?logo=python&style=flat&logoColor=79dafa&labelColor=282a36&color=ff6e96
[autohotkey_badge]: https://img.shields.io/badge/Auto_Hotkey-informational?logo=autohotkey&style=flat&logoColor=79dafa&labelColor=282a36&color=ff6e96
[ruby_badge]: https://img.shields.io/badge/Ruby-informational?logo=ruby&style=flat&logoColor=79dafa&labelColor=282a36&color=5e4053
