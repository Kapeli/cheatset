# cheatset

[![Gem Version](https://badge.fury.io/rb/cheatset.png)](http://badge.fury.io/rb/cheatset)

Generate your own cheat sheets as docsets for [Dash](http://kapeli.com/dash)!
Use this simple command line tool and write your cheat sheets in an easy
language (Ruby DSL).

## Installation

    $ sudo gem install cheatset --no-ri --no-rdoc

Note: this requires the Xcode Command Line Tools to be installed. Install them using this:

    $ xcode-select --install
    
## Contributions

If you make a useful cheat sheet, please [contribute it](https://github.com/Kapeli/cheatsheets#readme) to Dash.

## Usage

Write a file (here `sample.rb`) containing your cheat sheet data, e.g.:

```ruby
cheatsheet do
  title 'Sample'               # Will be displayed by Dash in the docset list
  docset_file_name 'Sample'    # Used for the filename of the docset
  keyword 'sample'             # Used as the initial search keyword (listed in Preferences > Docsets)
  # resources 'resources_dir'  # An optional resources folder which can contain images or anything else
  
  introduction 'My *awesome* cheat sheet'  # Optional, can contain Markdown or HTML

  # A cheat sheet must consist of categories
  category do
    id 'Windows'  # Must be unique and is used as title of the category

    entry do
      command 'CMD+N'         # Optional
      command 'CMD+SHIFT+N'   # Multiple commands are supported
      name 'Create window'    # A short name, can contain Markdown or HTML
      notes 'Some notes'      # Optional longer explanation, can contain Markdown or HTML
    end
    entry do
      command 'CMD+W'
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

Syntax highlighting is supported (see Ruby code in the sample). For a list of supported languages, see the [rouge](http://rouge.jneen.net/) [lexer repository](https://github.com/jneen/rouge/tree/master/spec/lexers)

For more complete examples look at some of
[the actual cheat sheets](https://github.com/Kapeli/cheatsheets/tree/master/cheatsheets).

## Advanced Usage

Apart from the attributes listed in the sample cheat sheet above, you can also use these:

* `style` (under `cheatsheet`) - define any CSS style you want. See example [here](https://github.com/Kapeli/cheatsheets/blob/f9e40e30b6fde9063b7a0fb5de8fb203851b17df/cheatsheets/CSS_Named_Colors.rb#L7-L12)
* `html_class` (under `category`) - define a HTML class to be added to a category. This can be used to define custom styling for each category
* `td_command` (under `entry`) - just like `command`, but multiple ones are added in a separate column (as opposed to a separate row)
* `td_notes` (under `entry`) - just like `notes`, but multiple ones are added in a separate column (as opposed to a separate row)
* `index_name` (under `entry`) - this is not displayed in the cheat sheet at all. You can use it to define a separate index name (i.e what gets added to Dash's search index and is searchable in Dash). In other words, if this entry is not present, the value in `name` is used.

## Thanks

[Nix-wie-weg](https://github.com/Nix-wie-weg/dasheets) for the initial code.
