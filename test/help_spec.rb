require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/rg'

require_relative '../lib/fossgit/cli.rb'

describe CLI do
  describe 'with default executable name' do
    name = 'fossgit'

    it 'returns help text with default name' do
      CLI.help_text.must_match /USAGE:  #{name} -h/
      CLI.help_text.must_match /-c CHECKOUT     Specify the location of/
      CLI.help_text.must_match /#{name} tries to push to an upstream Git/
      CLI.help_text.must_match /\s+EXAMPLES:/
    end
  end

  describe 'with non-default executable name' do
    name = 'not-fossgit'

    it 'returns help text with custom name' do
      CLI.help_text(name).must_match /USAGE:  #{name} -h/
    end
  end
end
