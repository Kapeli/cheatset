# cheatset

[![Gem Version](https://badge.fury.io/rb/cheatset.png)](http://badge.fury.io/rb/cheatset)

Generate your own cheatsheets as docsets for [Dash](http://kapeli.com/dash)!
Use this simple command line tool and write your cheatsheets in an easy
language (Ruby DSL).

## Installation

    $ gem install cheatset

## Contributing

If you make an useful cheatsheet, please [contribute it](https://github.com/Kapeli/cheatsheets#readme) to Dash.

## Usage

Write a file (here `sample.cheatsheet`) containing your cheatsheet data, e.g.:

```ruby
cheatsheet do
  title 'Sample'  # Will be displayed by Dash in the docset list
  short_name 'sample'  # Used for the filename of the docset
  introduction 'My *awesome* cheatsheet'  # Can contain markdown and multiple lines

  # A cheatsheet must consist of categories
  category do
    id 'Windows'  # Must be unique and is used as title of the category

    entry do
      command 'CMD-n'        # Optional
      command 'CMD-N'        # Multiple commands are supported
      name 'Create window'   # A short name, can contain markdown
      notes 'Some notes'     # Optional longer explanation, can contain markdown
    end
    entry do
      command 'CMD-w'
      name 'Close window'
    end
  end

  category do
    id 'Code'
    entry do
      name 'Code sample'
      notes <<-'END'
        ```ruby
        sample = "You can include code snippets as well"
        ```
        Or anything else **markdown**.
      END
    end
  end

  notes 'Some notes at the end of the cheatsheet'
end
```
The following values may contain markdown formatted text:

* The `introduction` and the `notes` of the cheatsheet
* The `name` and the `notes` of the entries

For more complete examples look at some of
[the actual cheatsheets](https://github.com/Kapeli/cheatsheets).

To convert this file to a docset, call

    $ cheatset generate sample.cheatsheet

## Thanks

[Nix-wie-weg](https://github.com/Nix-wie-weg/dasheets) for the initial code.
