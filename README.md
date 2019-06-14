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

Once again, this allows you to run the command without arguments:

If you do both, the most-specific option (gitrepo) will be chosen as the target
Git repository, which is probably a good idea if you have not configure the
Fossil repository's project-name setting or if you want to default to updating
a mirror with a different name than the Fossil project-name.  Specifying a
repository path at the command line will cause `fossgit` to ignore both, and
just use the command line argument as the target Git repository path.

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
* Change the color scheme for this repository to make tickets more readable.
* Incorporate this functionality into FossRec, a more comprehensive tool.

[gem]: https://rubygems.org/gems/fossgit
[frepo]: https://fossrec.com/u/apotheon/fossgit
[ghrepo]: https://github.com/apotheon/fossgit
[glrepo]: https://gitlab.com/apotheon/fossgit
