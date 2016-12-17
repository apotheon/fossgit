# fossgit

This is a simple command line utility for creating and updating Git
repositories as (one-way) mirrors of Fossil repositories.

## Installation

Clone it from the [Fossil repository](https://fossrec.com/u/apotheon/fossgit/)
or the [GitHub mirror](https://github.com/apotheon/fossgit/).

Copy the `fossgit` file to a directory in your execution path, add its location
in this repository to your execution path, or execute it by entering the path
to the `fossgit` file.

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

* Make this a stand-alone Ruby Gem some day, maybe.
* Add tests, maybe.
* Add automatic GitHub publishing, maybe.
* Incorporate this functionality into FossRec, a more comprehensive tool.
