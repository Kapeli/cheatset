require 'thor'

module Cheatset
  class CLI < Thor
    desc 'generate FILE', 'Generates cheatsheet out of a file'
    def generate(file)
      context = Cheatset::DSL::Context.new(file)
      context.generate
    end
  end
end
