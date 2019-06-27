require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/rg'

require_relative '../lib/fossgit/cli.rb'

describe CLI do
  describe 'get_option' do
    remote_list = ['gitlab', 'origin']
    post_parse_args = ['-a', '-c', '/path/to/heck']

    describe 'with -r option' do
      args = ['-a', '-r', remote_list.join(','), '-c', '/path/to/heck']

      remotes = CLI.new(args).get_option 'remotes'

      it 'returns all provided remotes and args without parsed opts' do
        remotes.split(',').must_equal remote_list
        args.must_equal post_parse_args
      end
    end

    describe 'with --remotes option' do
      args = ['-a', '--remotes', remote_list.join(','), '-c', '/path/to/heck']

      remotes = CLI.new(args).get_option 'remotes'

      it 'returns all provided remotes and args without parsed opts' do
        remotes.split(',').must_equal remote_list
        args.must_equal post_parse_args
      end
    end

    describe 'without -r option' do
      args = ['-a', '-c', '/path/to/heck']

      remotes = CLI.new(args).get_option 'remotes'

      it 'returns nil' do
        assert_nil remotes
      end
    end
  end

  describe 'help_text' do
    args = Array.new

    describe 'with default executable name' do
      name = 'fossgit'

      it 'returns help text with default name' do
        CLI.new(args).help_text.must_match /USAGE:  #{name} [-h | -v | -t]/
        CLI.new(args).help_text.must_match /-c <CHECKOUT> | --checkout <CHECKOUT>/
        CLI.new(args).help_text.must_match /By default, #{name} pushes to an/
        CLI.new(args).help_text.must_match /^\s+CONFIG EXAMPLES:$/
      end
    end

    describe 'with non-default executable name' do
      name = 'not-fossgit'

      it 'returns help text with custom name' do
        CLI.new(args, name).help_text.must_match /USAGE:  #{name} /
      end
    end
  end

  describe 'option_switch?' do
    args = ['-a', '-c', '/path/to/heck', '--local']

    it 'deletes and returns short option from args' do
      optfound = CLI.new(args).option_switch? 'all'
      optfound.must_equal '-a'
      refute args.include? '-a'
    end

    it 'deletes and returns long option from args' do
      optfound = CLI.new(args).option_switch? 'local'
      optfound.must_equal '--local'
      refute args.include? '--local'
    end
  end

  describe 'read_switches' do
    switchopts = %w(alpha charlie golf fox-trot)
    cli = CLI.new(['-a', '-c', '/path/to/heck', '--trot', '--fox-trot'])
    cli.parse_switches switchopts

    it 'correctly sets switches' do
      assert (cli.switches['alpha'] and cli.switches['fox-trot'])
      refute (cli.switches['golf'] or cli.switches['trot'])
      cli.switches.keys.sort.must_equal %w(alpha charlie fox-trot golf)
    end
  end
end
