class FossGit
  attr_reader :checkout_path
  attr_reader :fossil_repository

  def initialize checkout_path=''
    @checkout_path = checkout_path
    @checkout_path = get_element_matching :'local-root'

    @fossil_repository = get_repository_path
  end

  def self.version
    '1.1.2'
  end

  def self.help_text name='fossgit'
    help = <<-EOF

      FossGit provides a simple tool for creating Git mirrors of Fossil
      repositories.  To use it, you need:
      
      1. both Fossil SCM and Git installed
      2. a Fossil repository to mirror with an open checkout
      3. a Git repository to use as a mirror

      USAGE:  #{name} -h
              #{name} [-c <CHECKOUT>] [-l] <GITREPO>
              #{name} -t

          By default, when exporting to local Git repository GITREPO, #{name}
          attempts to push updates to a configured upstream Git repository.  It
          harmlessly fails to push if no upstream repository is configured for
          the local Git repository.

      OPTIONS/ARGUMENTS:

          -h              Display this help text and exit, ignoring all other
                          arguments.

          -c CHECKOUT     Specify the location of your Fossil repository's open
                          checkout, CHECKOUT.  This is optional; you may simply
                          use this tool from within an open checkout of your
                          Fossil repository instead.

          -l              Perform local-only mirror operations, without trying
                          to push Git updates to a remote repository.  By
                          default, #{name} tries to push to an upstream Git
                          repository whenever it exports from Fossil to Git.

          -t              Dump export to STDOUT rather than sending it to Git.
                          This overrides the `-l` option and GITREPO argument,
                          if present.

          GITREPO         Specify the location of your local Git repository.

      EXAMPLES:

          $ fossgit -h

          $ fossgit -c ~/fossil_checkouts/projectname ~/git/projectname

          $ cd ~/fossil_checkouts/projectname && fossgit ~/git/projectname

    EOF
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

  def update_export?
    File.exist? git_marks and File.exist? fossil_marks
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

    if system 'fossil status'
      `fossil status`.split(/\n/)
    else
      raise ArgumentError, "#{checkout_path} is not a valid checkout path"
    end
  end
end
