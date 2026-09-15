# Changelog

Notable changes to this project will be documented in this file.

## Unreleased

- Use a stable hypotenuse calculation for vector magnitude to avoid unnecessary
  intermediate overflow and underflow. Infinity paired with NaN now yields
  positive infinity; NaN without infinity still yields NaN.
- Respect frozen vector receivers during initialization and copying, including
  freezing inside a coordinate conversion callback; retain self-copy as a no-op.
- Restore Ruby's same-class copy validation while preserving inherited dup and clone.
- Convert vector coordinates in x-then-y order before assignment and clarify
  accepted coercions and propagated conversion errors.
- Require Ruby 3.3 or newer and adopt the versioned shared RuboCop policy.
- Modernize the supported Ruby versions, native binding, development tools,
  continuous integration, and gem packaging.
