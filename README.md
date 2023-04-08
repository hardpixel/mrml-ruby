# MRML Ruby

Ruby wrapper for [MRML](https://github.com/jdrouet/mrml), the [MJML](https://mjml.io) markup language implementation in Rust. Rust must be available on your system to install this gem.

[![Gem Version](https://badge.fury.io/rb/mrml.svg)](https://badge.fury.io/rb/mrml)
[![Build](https://github.com/hardpixel/mrml-ruby/actions/workflows/build.yml/badge.svg)](https://github.com/hardpixel/mrml-ruby/actions/workflows/build.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/7e307214d3c2e4d2056d/maintainability)](https://codeclimate.com/github/hardpixel/mrml-ruby/maintainability)

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

mjml = <<-HTML
<mjml>
  <mj-head>
    <mj-title>Newsletter Title</mj-title>
    <mj-preview>Newsletter Preview</mj-preview>
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

# Using module methods
MRML.to_html(mjml) # Generate html from mjml
MRML.to_json(mjml) # Generate json from mjml
MRML.to_hash(mjml) # Generate hash from mjml

# Using Template class
template = MRML::Template.new(mjml)

template.title   # Get template title
template.preview # Get template preview

template.to_html # Render as html
template.to_mjml # Render as mjml
template.to_json # Render as json
template.to_hash # Render as hash
```

```ruby
require 'mrml'

json = <<-JSON
{
  "type": "mjml",
  "children": [{
    "type": "mj-head",
    "children": [{
      "type": "mj-title",
      "children": "Newsletter Title"
    }, {
      "type": "mj-preview",
      "children": "Newsletter Preview"
    }]
  }, {
    "type": "mj-body",
    "children": [{
      "type": "mj-section",
      "children": [{
        "type": "mj-column",
        "children": [{
          "type": "mj-text",
          "attributes": {
            "font-size": "20px",
            "color": "#F45E43",
            "font-family": "helvetica"
          },
          "children": ["Hello World"]
        }]
      }]
    }]
  }]
}
JSON

# Create Template from JSON
template = MRML::Template.from_json(json)

template.to_html # Render as html
template.to_mjml # Render as mjml
template.to_json # Render as json
template.to_hash # Render as hash
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hardpixel/mrml-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
