module Cheatset
  module DSL
    class Context
      def initialize(filename)
        instance_eval(File.read(filename))
      end
      def generate
        Cheatset::Creator.new(@data).generate
      end
      private

      def cheatsheet(&block)
        @data = Cheatset::DSL::Cheatsheet.new(&block)
      end
    end
  end
end
