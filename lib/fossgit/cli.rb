class CLI
  def self.help_text name='fossgit'
    help = <<-EOF

      FossGit mirrors Fossil repositories to Git repositories.  You need:
      
      1. both Fossil SCM and Git installed
      2. a Fossil repository with an open checkout to export
      3. a Git repository to use as a mirror

      USAGE:  #{name} -h
              #{name} [-c <CHECKOUT>] [-l] [GITREPO]
              #{name} -t

          By default, when exporting to local Git repository GITREPO, #{name}
          attempts to push updates to a configured upstream Git repository.  It
          should harmlessly fail to push if there is no upstream repository
          configured for the local Git repository.  If there is no GITREPO in
          configuration (see CONFIG below), you must specify GITREPO when using
          #{name} to mirror your Fossil repository.

      OPTIONS/ARGUMENTS:

          -h              Display this help text and exit, ignoring all other
                          arguments.

          -a              Push to all configured remotes for the target Git
                          repository.  Default behavior is to push only to the
                          configured "origin" remote.

          -c CHECKOUT     Specify the location of your Fossil repository's open
                          checkout, CHECKOUT.  This is optional; you may simply
                          use this tool from within an open checkout of your
                          Fossil repository instead.

          -l              Perform local-only mirror operations, without trying
                          to push Git updates to a remote repository.  By
                          default, #{name} tries to push to an upstream Git
                          repository whenever it exports from Fossil to Git.

          -t              Dump export to STDOUT as text rather than sending it
                          to Git.  This overrides the `-l` option and GITREPO
                          argument, if present.

          -v              Show FossGit version number.

          GITREPO         Specify the location of your local Git repository.
                          This is optional, if there is a configuration file
                          that specifies it for you.

      EXAMPLES:

          $ fossgit -h

          $ fossgit -c ~/fossil_checkouts/projectname ~/git/projectname

          $ cd ~/fossil_checkouts/projectname && fossgit ~/git/projectname

      CONFIG:

          A config file named ".fossgit" can be used to set #{name} defaults.

          A universal config file can be placed in the home directory of the
          user account that executes this command, in which case it will apply
          every time that account executes #{name}.  A config file can also be
          placed in the root of an open Fossil repository, in which case it
          will only apply when #{name} is used for that particular repository.
          If both files exist, settings from both will be used, but where both
          have the same setting the more specific config (in the project
          directory) overrides the equivalent setting from the universal
          config.  This means a universal configuration can be used for the
          most common case, but for specific projects that have different needs
          you can place a config file the project repository.

          There are two configuration options:

          * The "gitdir" setting can be used to specify a directory in which
            Git repositories are kept.  In this case, #{name} infers the Git
            repository name from the "project-name" in "fossil info" output.

          * The "gitrepo" setting can be used to specify the full path to a Git
            repository, without letting #{name} try to infer the repository
            name.  This option overrides "gitdir" if both are set.  It is
            probably a bad idea to set "gitrepo" in a universal config.  It is
            intended to be set in a project-specific ".fossgit" file because
            chaos may ensue if all Fossil repositories use the same "gitrepo".

    EOF
  end
end
