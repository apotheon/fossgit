class FossGit
  def self.version
    '1.0.1'
  end

  def help_text name='fossgit'
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
          harmlessly fails to push if no upstream repository is configured for the
          local Git repository.

      OPTIONS/ARGUMENTS:

          -h              Display this help text and exit, ignoring all other
                          arguments.

          -c CHECKOUT     Specify the location of your Fossil repository's open
                          checkout, CHECKOUT.  This is optional; you may simply use
                          this tool from within an open checkout of your Fossil
                          repository instead.

          -l              Perform local-only mirror operations, without trying to
                          push Git updates to a remote repository.  By default,
                          #{name} tries to push to an upstream Git repository
                          whenever it exports from Fossil to Git.

          -t              Dump export to STDOUT rather than sending it to Git.
                          This overrides the `-l` option and GITREPO argument, if
                          present.

          GITREPO         Specify the location of your local Git repository.

      EXAMPLES:

          $ fossgit -h

          $ fossgit -c ~/fossil_checkouts/projectname ~/git/projectname

          $ cd ~/fossil_checkouts/projectname && fossgit ~/git/projectname

    EOF
  end
end
