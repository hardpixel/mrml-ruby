# MRML Ruby

Ruby wrapper for [MRML](https://github.com/jdrouet/mrml), the [MJML](https://mjml.io) parser implementation in Rust. Rust must be available on your system to install this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mrml'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mrml

## Usage

```ruby
require 'mrml'

template = <<-HTML
<mjml>
  <mj-head>
    <mj-title>Newsletter Title</mj-title>
  </mj-head>
  <mj-body>
    <mj-section>
      <mj-column>
        <mj-text font-size="20px" color="#F45E43" font-family="helvetica">Hello World</mj-text>
      </mj-column>
    </mj-section>
  </mj-body>
</mjml>
HTML

# Generate the title from mjml
MRML.to_title(template)

# Generate the preview from mjml
MRML.to_preview(template)

# Generate the html from mjml
MRML.to_html(template)
```

## To Do

Add support for options.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hardpixel/mrml-ruby.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
