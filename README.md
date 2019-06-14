# fossgit

FossGit provides a simple command line utility for creating and updating Git
repositories as (one-way) mirrors of Fossil repositories.

## Installation

Install the [Ruby Gem][gem]:

    $ gem install fossgit

If, for some reason, that is not an available option for you or you wish to do
things the hard way, there is another installation method:

1. Clone it from the [Fossil repository][frepo] or a mirror at [GitHub][ghrepo]
   or [GitLab][glrepo].

2. Copy the `fossgit` file to a directory in your execution path, create a
   symlink or hardlink to the repository's `fossgit` file in a directory in
   your execution path, add its location in this repository to your execution
   path, or execute it by entering the explicit path to the `fossgit` file at a
   shell prompt.

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
* Add a ticket in the GitHub repository (then I'll copy it to Fossil).

## Roadmap

* Add tests, maybe.
* Incorporate this functionality into FossRec, a more comprehensive tool.
* Test with GitLab.  FossGit has only been tested with GitHub so far.
* Add support for updating multiple mirrors by default.

## Development

The discerning programmer may look over FossGit in its current form and realize
it is neither object-oriented nor functional in its design.  It is, in fact, a
pretty straightforward procedural program, written in Ruby (an odd language to
use for procedural programming, perhaps).  The reason for this is simple: it is
in essence a glorified shell script.  There are plans to make it part of a
larger set of libraries and utilities (see the Roadmap), and it will need to
undergo a fair bit of redesign as part of that; I expect it to be largely
unrecognizable by then.

Much of this work was done on Christmas weekend 2016.  That may or may not be
significant.

[gem]: https://rubygems.org/gems/fossgit
[frepo]: https://fossrec.com/u/apotheon/fossgit
[ghrepo]: https://github.com/apotheon/fossgit
[glrepo]: https://gitlab.com/apotheon/fossgit
