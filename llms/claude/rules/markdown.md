<markdown>
- Never hard-wrap prose at 80, 100, or any fixed column, in any markdown file you write or edit to disk — one line per paragraph. Let the reader's editor soft-wrap it.
- This applies regardless of output style, and regardless of whether the write happens in this session or a subagent it spawns — an output style's `<output>` rules govern chat responses and are not guaranteed to reach either.
- If a repo runs `dprint` with `markdown.textWrap: "never"`, treat that as confirmation this convention is enforced, not as a reason to skip it yourself.
</markdown>
