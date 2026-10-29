<markdown>
- Write each markdown paragraph as one line, at any width, in every markdown file you write or edit to disk. The reader's editor soft-wraps it
- This applies regardless of output style, and regardless of whether the write happens in this session or a subagent it spawns: an output style's `<output>` rules govern chat responses and are not guaranteed to reach either
- If a repo runs `dprint` with `markdown.textWrap: "never"`, that confirms this convention is enforced; it is not a reason to skip it yourself
</markdown>
