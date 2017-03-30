require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/rg'

require_relative '../lib/fossgit.rb'

describe FossGit do
  describe 'with default executable name' do
    name = 'fossgit'

    it 'returns help text with default name' do
      FossGit.help_text.must_match /USAGE:  #{name} -h/
      FossGit.help_text.must_match /-c CHECKOUT     Specify the location of/
      FossGit.help_text.must_match /#{name} tries to push to an upstream Git/
      FossGit.help_text.must_match /\s+EXAMPLES:/
    end
  end

  describe 'with non-default executable name' do
    name = 'not-fossgit'

    it 'returns help text with custom name' do
      FossGit.help_text(name).must_match /USAGE:  #{name} -h/
    end
  end
end
