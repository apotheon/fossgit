load 'lib/fossgit.rb'

Gem::Specification.new do |s|
  s.name        = 'fossgit'
  s.version     = FossGit.version
  s.authors     = ['Chad Perrin']
  s.date        = '2019-06-26'
  s.description = <<-EOF
    Maintain a presence in Git hosting for Fossil project mirrors.
  EOF
  s.summary     = 'FossGit: Mirror Fossil to Git.'
  s.email       = 'code@apotheon.net'
  s.files       = [
    'LICENSE',
    'README.md',
    'lib/fossgit.rb',
    'lib/fossgit/cli.rb'
  ]
  s.homepage    = 'https://fossrec.com/u/apotheon/fossgit'
  s.license     = 'COIL'
  s.bindir      = 'bin'
  s.executables << 'fossgit'

  s.post_install_message  = <<-EOF
    Thank you for using FossGit.  For it to work properly, you need to have the
    following external software dependencies installed:

    * Fossil SCM (the world's most decentralized SCM and DVCS)
    * Git (the world's most popular DVCS)
    * sed (standard on Unix-like systems)

    This update adds support for the full range of long options and for
    creating a new local Git mirror on the fly via command line option.

        https://fossrec.com/u/apotheon/fossgit/index.cgi/reportlist

    Run "fossgit -h" for usage and configuration information.
  EOF

  s.required_ruby_version = '>= 2.4.5'
end
