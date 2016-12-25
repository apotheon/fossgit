load 'lib/fossgit.rb'

Gem::Specification.new do |s|
  s.name        = 'fossgit'
  s.version     = FossGit.version
  s.authors     = ['Chad Perrin']
  s.date        = '2016-12-25'
  s.description = <<-EOF
    Maintain a presence in Git hosting for Fossil projects.
  EOF
  s.summary     = 'FossGit: Mirror Fossil to Git.'
  s.email       = 'code@apotheon.net'
  s.files       = [
    'LICENSE',
    'README.md',
    'lib/fossgit.rb'
  ]
  s.homepage    = 'https://fossrec.com/u/apotheon/fossgit'
  s.license     = 'COIL'
  s.bindir      = 'bin'
  s.executables << 'fossgit'

  s.post_install_message  = <<-EOF
    Thank you for using FossGit.  For it to work properly, you need to have the
    following software dependencies installed:

    * Fossil SCM (the world's most decentralized SCM and DVCS)
    * Git (the world's most popular DVCS)
    * sed (standard on Unix-like systems)

    Run "fossgit -h" for usage information.

    Version 1.0.0 of FossGit is dedicated to my wife.  Happy holidays.
  EOF

  s.required_ruby_version = '>= 1.9.3'
end
