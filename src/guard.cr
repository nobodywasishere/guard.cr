#
# Simple macro for guarding against nil/false values. Concept taken from
# [Swift](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements/#Guard-Statement).
# If the `guard` block is omitted, it will call `return`. If a block is passed in,
# it will be called if the vaue is nil or false, and must include a `return`, `next`
# `break`, or `raise`.
#
# Example:
# ```
# def normalize(value : Int32?)
#   guard value do
#     return 0
#   end
#
#   value
# end
#
# normalize(1)   # => 1
# normalize(nil) # => 0
# ```
#
macro guard(value, &block)
  unless {{ value }}
    {% if block.is_a? Nop %}
      return
    {% elsif block.body.is_a? Call %}
      {% is_return = ["Return", "Next", "Break"].includes? block.body.class_name %}
      {% is_raise = block.body.is_a?(Call) && block.body.name == "raise" %}

      {% unless is_return || is_raise %}
        {% raise "guard body must include return, next, break, or raise" %}
      {% end %}
      {{ block.body.id }}
    {% elsif block.body.is_a? Expressions %}
      {% has_return = false %}
      {% has_raise = false %}

      {% for node in block.body.expressions %}
        {{ node }}

        {% if ["Return", "Next", "Break"].includes? node.class_name %}
          {% has_return = true %}
        {% elsif node.is_a?(Call) && node.name == "raise" %}
          {% has_raise = true %}
        {% end %}
      {% end %}

      {% unless has_return || has_raise %}
        {% raise "guard must include return, break, next, or raise" %}
      {% end %}
    {% else %}
      {{ block.body.id }}
    {% end %}
  end
end
