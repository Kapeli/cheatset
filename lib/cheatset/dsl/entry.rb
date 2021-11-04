module Cheatset
  module DSL
    class Entry < Base
      define_list_attrs :command, :td_command, :extra_index_name
      define_attrs :index_name, :not_in_main_index, :html_notes
      define_markdown_attrs :name, :notes
      define_markdown_list_attrs :td_notes
    end
  end
end
