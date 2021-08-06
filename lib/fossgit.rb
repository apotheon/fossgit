require 'yaml'

class FossGit
  attr_reader :checkout_path
  attr_reader :fossil_repository
  attr_accessor :project_name

  def initialize checkout_path=''
    @checkout_path = checkout_path
    @checkout_path = get_element_matching :'local-root'

    @fossil_repository = get_repository_path

    @project_name = get_project_name
  end

  def self.version
    '1.2.2'
  end

  def fossil_marks
    File.join checkout_path, 'fossil.marks'
  end

  def git_marks
    File.join checkout_path, 'git.marks'
  end

  def fossil_export_cmd
    if `fossil help export`.match /This command is deprecated\./
      'fossil git export --git'
    else
      'fossil export --git'
    end
  end

  def fossil_command
    cmd = [fossil_export_cmd]

    cmd << "--import-marks #{fossil_marks}" if update_export?
    cmd << "--export-marks #{fossil_marks}"
    cmd << fossil_repository

    cmd.join ' '
  end

  def push_command gitremote
    "; git checkout trunk; git push --all #{gitremote}"
  end

  def git_command
    cmd = ['git fast-import']

    cmd << "--import-marks=#{git_marks}" if update_export?
    cmd << "--export-marks=#{git_marks}"

    cmd.join ' '
  end

  def sed_command
    # legacy fix for a bug in an old Fossil version's Git-export
    %q{sed 's/^\(committer \+\)\([^ ]\+@[^ ]\+\)\( *<\)\(\w\+\)\(>.*\)$/\1\4\3\2\5/'}
  end

  def mirror_command
    [fossil_command, sed_command, git_command].join '|'
  end

  def push_mirror_command gitremote
    mirror_command + push_command(gitremote)
  end

  def push_remote_list! remote_list
    remote_list.each do |gitremote|
      puts "PUSH TO: #{gitremote}"
      system push_mirror_command(gitremote)
    end
  end

  def text_export_command
    [fossil_command, sed_command].join '|'
  end

  def update_export?
    File.exist? git_marks and File.exist? fossil_marks
  end

  def git_remotes gitpath
    Dir.chdir gitpath do
      `git remote`.split "\n"
    end
  end

  private

  def get_project_name
    fossil_info = YAML.load `fossil info | head -n 1`
    name = fossil_info ? fossil_info['project-name'] : fossil_info
    name if not name.eql? '<unnamed>'
  end

  def get_repository_path
    File.absolute_path get_element_matching :repository
  end

  def get_element_matching key
    key_regex = /^#{key}: +/
    fossil_status.select {|line| line.match key_regex }.first.sub key_regex, ''
  end

  def fossil_status
    Dir.chdir checkout_path

    stat = `fossil status`

    if stat.size > 0
      stat.split "\n"
    else
      raise ArgumentError, "#{checkout_path} is not a valid checkout path"
    end
  end
end
