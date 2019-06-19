# fossgit

FossGit provides a simple command line utility for creating and updating Git
repositories as (one-way) mirrors of Fossil repositories.

## Installation

Install the [Ruby Gem][gem]:

    $ gem install fossgit

If, for some reason, that is not an available option for you or you wish to do
things the hard way, there is another installation method:

1. Clone it from the [Fossil repository][frepo], the [GitHub][ghrepo] mirror,
   or the [GitLab][glrepo] mirror.

2. Build a gem, using this command:

        gem build fossgit.gemspec

3. Install the gem, using this command, using the whole filename of the gem
   filename, substituting the actual version number for `<version`:

        gem install fossgit-<version>

If that still does not suit your needs, you're on your own for now.  I'd be
happy to accept suggestions for additional installation methods to describe.

## Usage

With an open checkout of your Fossil repository:

    $ cd /path/to/open/fossil/checkout
    $ fossgit /path/to/git/repository

By placing a config file in the directory that will serve as your working
directory while running `fossgit` (typically the root of your Fossil repository
checkout directory tree), you can do away with the need to specify the path to
the local Git repository mirror.  Simply create a file there called `.fossgit`
containing the following:

    gitrepo: /path/to/gitdir/reponame

You can then run the command without arguments:

    $ cd /path/to/open/fossil/checkout
    $ fossgit

You can also place a `.fossgit` config file in your home directory, in which
case you may wish to specify the path to a directory in which you keep all your
Git repository mirrors and let `fossgit` infer your repository name from the
project-name setting in your Fossil repository:

    gitpath: /path/to/gitdir

Once again, this allows you to run the command without arguments, but in this
case you should ensure the "project name" setting has been configured in your
Fossil repository, because it will default to using that to find your local Git
mirror.  If you want to specify a different Git repository name, using the
`gitrepo` setting in a `.fossgit` file within the checkout of your Fossil
repository as described above might be a better option.

You can check whether your project name has been configured by running this
command from within an open checkout:

    $ fossil info

If the `project-name` line says `<unnamed>`, the project name is unconfigured.
You can cofigure it yourself; open the web UI for the repository (e.g.  run
`fossil serve` from within an open checkout and open `localhost:8080` in your
browser), navigate to `Admin > Configuration`, fill in the Project Name field,
and click the button to apply your changes.

If you do both, the most-specific option (gitrepo) will be chosen as the target
Git repository, which is probably a good idea if, for a specific project, you
have not configured the Fossil repository's project-name setting, or if you
want to default to updating a mirror with a different name than the Fossil
project-name.  Specifying a repository path at the command line will cause
`fossgit` to ignore both, and just use the command line argument as the target
Git repository path.

## Dependencies

* Fossil SCM
* Git
* a Fossil repository to mirror
* a Git repository you will use as your mirror
* an open checkout of the Fossil repository

## Bug Reports And Feature Requests

In order from most preferred to least preferred:

* Add a ticket in the Fossil repository.
* Add a ticket in the GitHub or GitLab repository (and I'll copy it to Fossil).

## Roadmap

* Add more tests, maybe.
* Change defaults for v2.0, perhaps.
* Incorporate this functionality into FossRec, a more comprehensive tool.

[gem]: https://rubygems.org/gems/fossgit
[frepo]: https://fossrec.com/u/apotheon/fossgit
[ghrepo]: https://github.com/apotheon/fossgit
[glrepo]: https://gitlab.com/apotheon/fossgit
