# haskell-ide-engine-build

Apparently the `haskell-ide-engine` is very much worth using.

It is unfortunately quite a mammoth effort to build.

You also can't have runtime plugins, and even the compile time ones
are implemented in an unfriendly manner, it looks like you have to fork it,
(rather than say, use it as a library, and inject your plugins).

So we have setup our own build here that we publish, where we would probaly put our own plugins...
