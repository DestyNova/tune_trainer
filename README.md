# Tune trainer

A tool for learning traditional Irish tunes.

## Why?

When learning traditional tunes on the violin, I sometimes find it difficult to memorise a lot of tunes at once. Just thinking about it makes me less likely to pick the instrument up and practice.

To try to fix that (or, possibly, as a diversion to avoid addressing my issues with putting in the practice...), I created this program, a [Processing](https://processing.org) sketch that incrementally reveals one bar at a time. By revealing the music piece by piece, it encourages the viewer to try to play the next bar from memory before it appears, instead of just playing while reading the sheet music. I like to think of this as 'active' versus 'passive' learning, although the literature seems to overload these terms so it's better to just call it [retrieval practice](https://en.wikipedia.org/wiki/Testing_effect) -- in short, this type of study is much more effective than passively reviewing the material. It's hard to say if the same applies to procedural skills, which I suspect includes musical pieces you've learned.

## Features

This first version is really barebones and overly-specialised. It shows one bar at a time, moving to the next bar every 5 seconds. The fade / tempo timings are specified in the Processing sketch. At the end, the whole tune is displayed, or you can reveal the tune at any time by pressing the `enter` key.
The tunes are read from files in the sketch's `data` directory, and you can move to the next or previous tune by pressing `n` or `p`, respectively. `Esc` or `q` exits the program.

There's also some code for rendering video frames which I might use to share output on YouTube.

## File format

The current file format is very simplistic and inflexible. The first line is taken to be the song title, and subsequent lines are assumed to be the tune, broken into two bars per line with a possible upbeat at the beginning of each bar. The upbeat should be left as a blank bar if it's not needed. For example:

```
Inis Oírr (key: G)
D-  |B- BA BD'|B- BA BD'
    |E- EB AB |D- DB AG
    |B- BA BD'|B- BA BD'
    |G- GB AGF|G-
ABD'|E'- E'F' E'D'|B- BA BD'
    |E'F' E'D' BCD'|E- ED BD'
    |E'- E'F' E'D'|B- BA BD'
    |G- GB AGF|G- GA BD'
    |E'- E'F' E'D'|B- BA BD'
    |G'F' E'D' BCD'|E'- E'D' BD'
    |E'- E'F' E'D'|B- BA BD'
    |G- GB AGF|G-
```

## Future updates

The current setup is very rigid and only designed to suit the kinds of traditional Irish tunes I've been learning. It would be great to extract each bar of actual sheet music and display that incrementally, but obviously a lot more work. Pulling apart sheet music with OpenCV probably isn't impossible, but it'd be very difficult and error-prone. Perhaps a good way to go would be to use a structured music format and renderer like Lilypond or MuseScore. The MuseScore database already has a ton of stuff, so... maybe?

Back / forward buttons or keys would probably be a good idea too.
