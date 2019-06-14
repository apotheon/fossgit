class FossGit
  attr_reader :checkout_path
  attr_reader :fossil_repository

  def initialize checkout_path=''
    @checkout_path = checkout_path
    @checkout_path = get_element_matching :'local-root'

    @fossil_repository = get_repository_path
  end

  def self.version
    '1.1.0'
  end

  def fossil_marks
    File.join checkout_path, 'fossil.marks'
  end

  def git_marks
    File.join checkout_path, 'git.marks'
  end

  def fossil_command
    cmd = ['fossil export --git']

    cmd << "--import-marks #{fossil_marks}" if update_export?
    cmd << "--export-marks #{fossil_marks}"
    cmd << fossil_repository

    cmd.join ' '
  end

  def git_command
    cmd = ['git fast-import']

    cmd << "--import-marks=#{git_marks}" if update_export?
    cmd << "--export-marks=#{git_marks}"

    cmd.join ' '
  end

  def sed_command
    %q{sed 's/^\(committer \+\)\([^ ]\+@[^ ]\+\)\( *<\)\(\w\+\)\(>.*\)$/\1\4\3\2\5/'}
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
      stat.split(/\n/)
    else
      raise ArgumentError, "#{checkout_path} is not a valid checkout path"
    end
  end
end
