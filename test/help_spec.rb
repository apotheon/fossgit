require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/rg'

require_relative '../lib/fossgit.rb'

describe FossGit do
  FossGit.new.tap do |fg|
    name = 'fossgit'

    it 'returns help text with default name' do
      fg.help_text.must_match /USAGE:  #{name} -h/
      fg.help_text.must_match /-c CHECKOUT     Specify the location of/
      fg.help_text.must_match /#{name} tries to push to an upstream Git/
      fg.help_text.must_match /\s+EXAMPLES:/
    end

    it 'returns help text with custom name' do
      name = 'not-fossgit'
      fg.help_text(name).must_match /USAGE:  #{name} -h/
    end
  end
end
