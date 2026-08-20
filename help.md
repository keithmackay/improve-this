improve-this — evaluate a project for potential improvements, strictly evaluate-and-report

WHAT IT DOES
  Reviews a project (or a scoped path/topic if given) and reports
  potential improvements without ever modifying files. Infers the
  project type, proposes a tailored list of evaluation categories
  (UI/UX, code efficiency, test coverage, security, token efficiency
  and progressive disclosure for skills/commands, etc.), evaluates each
  with Impact/Confidence ratings, then presents a priority-ranked,
  categorized list of findings. Can optionally save the report and
  generate a phased implementation plan — but never edits files itself.

WHAT IT NEEDS
  - Nothing beyond the project itself; run it from inside the project
    directory you want reviewed

USAGE
  /improve-this                Review the full project
  /improve-this <path|topic>   Scope the review to a path or topic
  /improve-this --help         Show this message and exit

FLAGS
  --help    Show this help message without making any changes
