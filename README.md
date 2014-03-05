# cheatset

[![Gem Version](https://badge.fury.io/rb/cheatset.png)](http://badge.fury.io/rb/cheatset)

Generate your own cheat sheets as docsets for [Dash](http://kapeli.com/dash)!
Use this simple command line tool and write your cheat sheets in an easy
language (Ruby DSL).

## Installation

    $ gem install cheatset

## Contributions

If you make an useful cheat sheet, please [contribute it](https://github.com/Kapeli/cheatsheets#readme) to Dash.

## Usage

Write a file (here `sample.rb`) containing your cheat sheet data, e.g.:

```ruby
cheatsheet do
  title 'Sample'             # Will be displayed by Dash in the docset list
  docset_file_name 'Sample'  # Used for the filename of the docset
  keyword 'sample'           # Used as the initial search keyword (listed in Preferences > Docsets)
  
  introduction 'My *awesome* cheat sheet'  # Optional, can contain Markdown or HTML

  # A cheat sheet must consist of categories
  category do
    id 'Windows'  # Must be unique and is used as title of the category

    entry do
      command 'CMD-n'        # Optional
      command 'CMD-N'        # Multiple commands are supported
      name 'Create window'   # A short name, can contain Markdown or HTML
      notes 'Some notes'     # Optional longer explanation, can contain Markdown or HTML
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
        Or anything else **Markdown** or HTML.
      END
    end
  end

  notes 'Some notes at the end of the cheat sheet'
end
```

To convert this file to a docset, call

    $ cheatset generate sample.rb

The following values may contain Markdown or HTML:

* The `introduction` and the `notes` of the cheat sheet
* The `name` and the `notes` of the entries

For more complete examples look at some of
[the actual cheat sheets](https://github.com/Kapeli/cheatsheets/tree/master/cheatsheets).

## Thanks

[Nix-wie-weg](https://github.com/Nix-wie-weg/dasheets) for the initial code.
