Obfuscation
===========

A simple [Haskell][1] program to obfuscate sensitive data.

As a programmer, I sometimes need to ask questions about code. Sometimes my
program is meant to transform data. Most of the time that data is sensitive,
private, or otherwise not meant to be viewed publically. So I'll change names,
numbers, etc. I tired of doing this manually, and so, wrote this program.

This is a console application that takes its input from stdin and writes to
stdout.

Usage
-----

`cat filename(s) | obfuscate [-x filename] > filename`

Obfuscates text files. This obliterates the text--there is no recovery. This is
NOT encryption. It's simple, if slow, obfuscation.

To include a list of words not to obfuscate, use the -x option. List one word
per line in the file.

The file `exclusions.txt` I've included is a list of some of the common Haskell
keywords. This allowed me to test the program on its own source code. Fun! :)

[1]: https://www.haskell.org/haskellwiki/Haskell
