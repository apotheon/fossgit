require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/rg'

require_relative '../lib/fossgit.rb'

describe FossGit do
  describe 'with a valid checkout path' do
    checkout_path = File.absolute_path '..'

    repo_path = `fossil status`.split(/\n/).select do |line|
      line.match(/^repository: +/)
    end.first.sub /repository: +/, ''

    FossGit.new(checkout_path).tap do |fg|
      it 'uses the specified Fossil repository' do
        fg.fossil_repository.must_equal File.absolute_path repo_path
      end
    end
  end

  describe 'with a nonexistent checkout path' do
    checkout_path = '/home/invalid/username/with/invalid/path'

    it 'raises an ENOENT error' do
      proc { FossGit.new checkout_path }.must_raise Errno::ENOENT
    end
  end

  describe 'with an invalid Fossil checkout path' do
    it 'raises an ArgumentError' do
      proc { FossGit.new '/' }.must_raise ArgumentError
    end
  end
end
