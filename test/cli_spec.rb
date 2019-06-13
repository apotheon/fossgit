require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/rg'

require_relative '../lib/fossgit/cli.rb'

describe CLI do
  describe 'with -r option' do
    remote_list = ['gitlab', 'origin']
    args = ['-a', '-r', remote_list.join(','), '-c', '/path/to/heck']

    remotes = (CLI.get_option '-r', args).split ','

    it 'returns gitlab for -r option' do
      remotes.must_equal remote_list
    end
  end
end
