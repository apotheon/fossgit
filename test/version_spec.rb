require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/rg'

require_relative '../lib/fossgit.rb'

describe FossGit do
  it 'returns a semantic version number' do
    FossGit.version.must_match /^\d+\.\d+\.\d+$/
  end
end
