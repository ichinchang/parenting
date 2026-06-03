#!/usr/bin/env python3
"""
jsonl-to-markdown.py — convert Claude Code session jsonl → readable markdown

Used by hooks/stop-capture-log.sh to auto-save session logs.

Usage:
  python3 jsonl-to-markdown.py <input.jsonl> <output.md>

Format (output md):
  # Session {date} — {short topic}
  **Session ID**: {uuid}
  **Duration**: {N min}
  **Messages**: {N user / N assistant}

  ## User
  > {user prompt}

  ## Assistant
  {response text, stripped of tool calls}

  ## Tools used
  - {tool name} × N
"""
import json
import sys
from datetime import datetime
from pathlib import Path


def parse_jsonl(path: Path) -> list[dict]:
    """Parse jsonl, return list of message dicts."""
    msgs = []
    with path.open("r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                msgs.append(json.loads(line))
            except json.JSONDecodeError:
                continue
    return msgs


def extract_text(content) -> str:
    """Pull plain text from message content (could be str or list of blocks)."""
    if isinstance(content, str):
        return content
    if isinstance(content, list):
        parts = []
        for block in content:
            if isinstance(block, dict):
                if block.get("type") == "text":
                    parts.append(block.get("text", ""))
        return "\n".join(parts)
    return ""


def count_tools(msgs: list[dict]) -> dict[str, int]:
    """Count tool_use entries by name."""
    counts: dict[str, int] = {}
    for m in msgs:
        content = m.get("message", {}).get("content", [])
        if isinstance(content, list):
            for block in content:
                if isinstance(block, dict) and block.get("type") == "tool_use":
                    name = block.get("name", "unknown")
                    counts[name] = counts.get(name, 0) + 1
    return counts


def to_markdown(msgs: list[dict], session_id: str) -> str:
    """Convert messages to readable markdown."""
    if not msgs:
        return f"# Empty session\n\nSession ID: {session_id}\n"

    # Header
    first_ts = msgs[0].get("timestamp", "")
    last_ts = msgs[-1].get("timestamp", "")
    date_str = first_ts[:10] if first_ts else "unknown"

    n_user = sum(1 for m in msgs if m.get("type") == "user")
    n_assistant = sum(1 for m in msgs if m.get("type") == "assistant")

    # Extract first user message for topic
    first_user = next((m for m in msgs if m.get("type") == "user"), None)
    topic = "新對話"
    if first_user:
        text = extract_text(first_user.get("message", {}).get("content", ""))
        topic = (text[:40] + "...") if len(text) > 40 else text
        topic = topic.replace("\n", " ").strip() or "新對話"

    tool_counts = count_tools(msgs)
    tools_line = ", ".join(f"{name} × {count}" for name, count in tool_counts.items()) or "無"

    out = [
        f"# Session {date_str} — {topic}",
        "",
        f"- **Session ID**: `{session_id}`",
        f"- **Start**: {first_ts}",
        f"- **End**: {last_ts}",
        f"- **Messages**: {n_user} user / {n_assistant} assistant",
        f"- **Tools used**: {tools_line}",
        "",
        "---",
        "",
    ]

    # Conversation body
    for m in msgs:
        msg_type = m.get("type", "")
        content = m.get("message", {}).get("content", "")
        text = extract_text(content)
        if not text.strip():
            continue
        if msg_type == "user":
            out.append("## 👤 我問")
            out.append("")
            for line in text.split("\n"):
                out.append(f"> {line}" if line else ">")
            out.append("")
        elif msg_type == "assistant":
            out.append("## 🤖 Claude")
            out.append("")
            out.append(text.strip())
            out.append("")

    return "\n".join(out)


def main() -> int:
    if len(sys.argv) < 3:
        print("Usage: jsonl-to-markdown.py <input.jsonl> <output.md>", file=sys.stderr)
        return 1
    in_path = Path(sys.argv[1])
    out_path = Path(sys.argv[2])
    if not in_path.exists():
        print(f"Error: {in_path} does not exist", file=sys.stderr)
        return 1
    msgs = parse_jsonl(in_path)
    session_id = in_path.stem
    md = to_markdown(msgs, session_id)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(md, encoding="utf-8")
    print(f"✅ {out_path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
