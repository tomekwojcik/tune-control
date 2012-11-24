tune-control for Mac OS X
=========================

WTF?
----

tune-control is a tiny command line program for Mac OS X that makes controlling
iTunes or Spotify from shell a walk in a park.

But why?
--------

Because reasons. Because I needed it. Because I was bored. Because teh lulz,
that's why.

Features
--------

* Native OS X program (no bash-wrapped AppleScript or other nonsense),
* Support for iTunes and Spotify,
* Play, pause, next track, previous track and info commands.

Commands
--------

* ``play`` - play the current track (or the playlist in case of iTunes),
* ``pause`` - pause the current track,
* ``next`` - play the next track in the playlist,
* ``prev`` - play the previous track in the playlist,
* ``track`` - print basic track info to stdout,
* ``state`` - print player state (e.g. Playing) to stderr,
* ``player`` - print target player name to stderr,
* ``home`` - open project's home page,
* ``version`` - print version to stderr,
* ``help`` - print usage info to sdterr.

Choosing the player
-------------------

Since tune-control supports iTunes and Spotify there must be a way to choose
the controlled player. You can do it with::

    $ defaults write pl.bthlabs.tune-control PlayerName <player_name>

where ``player_name`` is either ``iTunes`` (default) or ``Spotify``.

Easy peasy.

License
-------

tune-control is licensed under MIT License. See `LICENSE`_ for more details.

Credits
-------

Flask-HTAuth is developed by `BTHLabs`_.

.. _LICENSE: http://github.com/tomekwojcik/tune-control/blob/master/LICENSE
.. _BTHLabs: http://www.bthlabs.pl/
