# Changelog

Notable changes to this project will be documented in this file.

## Unreleased

- Respect frozen vector receivers during initialization and copying, including
  freezing inside a coordinate conversion callback; retain self-copy as a no-op.
- Restore Ruby's same-class copy validation while preserving inherited dup and clone.
- Convert vector coordinates in x-then-y order before assignment and clarify
  accepted coercions and propagated conversion errors.
- Require Ruby 3.3 or newer and adopt the versioned shared RuboCop policy.
- Modernize the supported Ruby versions, native binding, development tools,
  continuous integration, and gem packaging.
