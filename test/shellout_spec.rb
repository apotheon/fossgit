require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/rg'

require_relative '../lib/fossgit.rb'

describe FossGit do
  checkout_path = File.absolute_path '..'

  repo_path = File.absolute_path(
    `fossil status`.split(/\n/).select do |line|
      line.match(/^repository: +/)
    end.first.sub /repository: +/, ''
  )

  fossil_marks_path = File.join checkout_path, 'fossil.marks'
  git_marks_path = File.join checkout_path, 'git.marks'

  fossil_mirror_update_command = [
    'fossil export --git',
    "--import-marks #{fossil_marks_path}",
    "--export-marks #{fossil_marks_path}",
    repo_path
  ].join ' '

  FossGit.new(checkout_path).tap do |fg|
    it 'uses appropriate fossil commands' do
      fg.fossil_command.must_equal fossil_mirror_update_command
    end
  end
end
