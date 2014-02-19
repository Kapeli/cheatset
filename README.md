# cheatset

[![Gem Version](https://badge.fury.io/rb/cheatset.png)](http://badge.fury.io/rb/cheatset)

Generate your own cheatsheets as docsets for [Dash](http://kapeli.com/dash)!
Use this simple command line tool and write your cheatsheets in an easy
language (Ruby DSL).

## Installation

    $ gem install cheatset

## Usage

Write a file (here `tmux.cheatsheet`) containing your cheatsheet-data, e.g.:

```
cheatsheet do
  title 'tmux' # Will be displayed by Dash in the docset list
  short_name 'tmux' # Used for the filename of the docset
  introduction 'My *awesome* cheatsheet for tmux'

  # A cheatsheet must consist of categories
  category do
    id 'windows'  # must be unique and is used as title of the category

    entry do
      command 'PREFIX-c'
      name 'create window'            # A short name
      notes 'theses are some notes'   # longer explanation
    end
    entry do
      name 'rename window'
      command 'PREFIX-,'
    end
    entry do
      name 'go to next window'
      command 'PREFIX-n'
    end
  end

  category do
    id 'panes'
    entry do
      name 'split horizontally'
      command 'PREFIX-|'
      notes 'custom mapping'
    end
    entry do
      name 'split horizontally'
      command 'PREFIX-%'
    end
    entry do
      name 'split vertically'
      command 'PREFIX-"'
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

    $ cheatset generate tmux.cheatsheet


## Contributing

Yes, please! Open issues and pull requests on the
[GitHub page](https://github.com/Kapeli/cheatset).

## Thanks

[Nix-wie-weg](https://github.com/Nix-wie-weg/dasheets) for the initial code.
