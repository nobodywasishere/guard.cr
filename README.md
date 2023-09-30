# guard

Add Swift's [guard clause](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements/#Guard-Statement) as a macro to Crystal.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     guard:
       github: nobodywasishere/guard
   ```

2. Run `shards install`

## Usage

```crystal
require "guard"

def normalize(value : Int32?)
  guard value do
    return 0
  end

  value
end

normalize(1)   # => 1
normalize(nil) # => 0
```

## Contributing

1. Fork it (<https://github.com/nobodywasishere/guard/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Margret Riegert](https://github.com/nobodywasishere) - creator and maintainer
