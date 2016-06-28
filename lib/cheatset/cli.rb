require 'thor'

module Rouge
    module Formatters
        class HTML < Formatter
            def stream_untableized(tokens, &b) # prevent Rouge from using <pre><code>, we just want <pre>
              yield "<pre#@css_class>" if @wrap
              tokens.each{ |tok, val| span(tok, val, &b) }
              yield "</pre>\n" if @wrap
            end
        end
        class HTMLPygments < Formatter
            def stream(tokens, &b) # prevent Rouge from using <pre><code>, we just want <pre>
              yield %<<pre class="#@css_class">>
              @inner.stream(tokens, &b)
              yield "</pre>"
            end
        end
    end
end

module Cheatset
  class CLI < Thor
    desc 'generate FILE', 'Generates cheatsheet out of a file'
    def generate(file)
      context = Cheatset::DSL::Context.new(file)
      context.generate
    end
  end
end
