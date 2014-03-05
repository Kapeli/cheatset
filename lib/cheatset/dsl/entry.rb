module Cheatset
  module DSL
    class Entry < Base
      define_list_attrs :command, :shortcut
      define_markdown_attrs :name, :notes
    end
  end
end
