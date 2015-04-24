# MarkdownToReveal

Converts a markdown file to a http://github.com/hakimel/reveal.js presentation.

Put three dashes between two slides.

## Example Markdown

```markdown
# Title

---

This it a slide

---

You can put code in here

\```haskell
add x y = x + y
\```

```

## Compilation

```sh
MarkdownToReveal -i path/to/markdown -o path/to/output
```

The output file should be in the same folde as the index.html of reveal.js,
so the top level directory and can be called however you like it.
You can put as many presentations in the same folder as you want.
