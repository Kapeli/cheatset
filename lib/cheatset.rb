require 'cheatset/version'

%w(creator dsl/base dsl/cheatsheet dsl/category dsl/context
   dsl/entry).each do |file|
  require "cheatset/#{file}"
end
