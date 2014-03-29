module Cheatset
  module DSL
    class Context
      def initialize(filename)
        instance_eval(File.read(filename), File.expand_path(filename))
        @filename = filename
      end
      def generate
        Cheatset::Creator.new(@data, @filename).generate
      end
      private

      def cheatsheet(&block)
        @data = Cheatset::DSL::Cheatsheet.new(&block)
      end
    end
  end
end
