# fossgit

FossGit provides a simple command line utility for creating and updating Git
repositories as (one-way) mirrors of Fossil repositories.

## Installation

Install the [Ruby Gem][gem]:

    $ gem install fossgit

If, for some reason, that is not an available option for you or you wish to do
things the hard way, there is another installation method:

1. Clone it from the [Fossil repository][frepo] or the [GitHub mirror][grepo].

2. Copy the `fossgit` file to a directory in your execution path, create a
   symlink or hardlink to the repository's `fossgit` file in a directory in
   your execution path, add its location in this repository to your execution
   path, or execute it by entering the explicit path to the `fossgit` file at a
   shell prompt.

## Usage

With an open checkout of your Fossil repository:

    $ cd /path/to/open/fossil/checkout
    $ fossgit /path/to/git/repository

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
[grepo]: https://github.com/apotheon/fossgit
