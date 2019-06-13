require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/rg'

require_relative '../lib/fossgit/cli.rb'

describe CLI do
  describe 'self.get_option' do
    remote_list = ['gitlab', 'origin']
    args = ['-a', '-r', remote_list.join(','), '-c', '/path/to/heck']
    post_parse_args = ['-a', '-c', '/path/to/heck']

    remotes = (CLI.get_option '-r', args)

    it 'returns all provided remotes and args without parsed opts' do
      remotes.split(',').must_equal remote_list
      args.must_equal post_parse_args
    end
  end
end
