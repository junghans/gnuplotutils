**gp2eps**

Christoph Junghans

_03/08/2012_


#summary Manpage of gp2eps
# NAME #

gp2eps - converts gnuplot scripts to eps pictures directly

# SYNOPSIS #

**gp2eps** `[`_OPTION_`]`... _FILE_

_FILE_ can be a plot script (.gp) or  tex file from gnuplot

# DESCRIPTION #

**gp2eps** is a GPL converting script, which uses gnuplot's epslatex terminal and allows to change the ratio between fonts and picture
as well as the ratio between axis numbers and axis labels.
Latex syntax ($\something$) in the labels (and everywhere else) is allowed.
gp2eps always tries make the eps bounding box as tight as possible and applies an other scale correction factor for that.

In case the automatic parser fails one can use _\gplabel_ and _\gpnumber_ to tag things to scale in a certain way.
An additional fonts scale can be defined with _\gpown_.

Please visit the program site at
[http://gnuplotutils.googlecode.com](http://gnuplotutils.googlecode.com).

# OPTIONS #

All options are first come first evaluated. Concatenation of short options is possible.

**-v**, **--version**
Prints version

**--gversion**
Show gnuplot version (may use **--gnuplot** before)

**-h**, **--help**
Show help message

**-q**, **--quiet**
Do not show messages, except errors

**-s**, **--scale** _X.X_
scale of the image to text

It should be the same as using in main tex file `\includegraphics[width=X.X\textwidth]{YYY.eps`}, when s=X.X.

0.5=halfsides 1.0=normal

default: 0.5

**-p**, **--pointsize** _X.X_
pointsize of the fonts

default: 10

**-r**, **--ratioscale** _X.X_
change the ratio between size of labels (\gplabel) and numbers (\gpnumber)

default: 0.8

**-t**, **--textwidth** _X.X_
textwidth (in cm) of tex docment (use --widthfile if unknown)

default: 12.7 cm

**-r**, **--ratio** _X.X_
ratio of the image (width/heigth)

default: 1.42857143

**--margin** _XXX_
margin of the images of the image (comma separeted numbers l,r,t,b - empty = auto)

default: auto

**--multi** _XXX_
This is a multiplot (comma separated number x,y)

default: 1,1

**--widthfile** _FILE_
Get textwidth from this latex file

**-o** _FILE_
give the output filename, else it is grep from the gp-file or tex-file that is used

**--gpown** _X.X_
give size of additional label (\gpown)

mefault: 10

**--termopts** _OPTS_
extra options to be given to 'set terminal epslatex standalone'

default: color

**--view** _VIEWER_
start _VIEWER_ at the end

**--deps**
show makefile rule for the eps file (implies **--quiet**)

**--gnuplot** _NAME_
change the gnuplot command to run

default: "gnuplot"

**--debug**
keep .tex file for debugging (implies **--nobbfix**)

**--keep**
keep .tex file for debugging

Axis numbers are always scaled with 0.8 (change with **-r** option).
Additional stuff to scale like the graph numbers can be marked with \gpnumber.
Stuff to scale like labels can be marked with \gplabel.
Stuff to scale somehow else can be marked with \gpown (use **--gpown**).

# EXAMPLE #

A simple, but nice example plot file would like this:

```
set title '$\rho$'
set xlabel "$x_i$ [nm]"
set ylabel "$\\theta$ [deg]"

plot cos(x) w l
```

Save it as file.gp and run `gp2eps file.gp`

Also mind the double backslash, when using double quotes. It works like in shell, in double quotes backslash sequences are interpreted.
Sometimes this is useful, for `\n` or so.

# HOW THIS WORKS #

To explain how this script actually works one has to understand what gnuplot is doing first.
It takes a plot script and generates two files. A tex file with all the numbers and label in a picture environment. And an eps file with the graphs lines and lines of axis and the tics.

Usually the plot is made in such a way that it can be included with `\include` in an main tex file.
This would normally work quite nice, except for the case where one has two columns, like in papers.
Anyway one could still use the gnuplot option

```
set size 0.5,0.5
```

to overcome this problem.
However this has some disadvantages:

  * the numbers and labels have the same size which look ugly. This problem one could overcome by hacking gnuplot's format option with something like
```
set format x "\tiny %g"' 
```

> and compensating for the wrong length with
```
set xtics 5 offset 3,0
```

  * this tex file from gnuplot with the picture environment tend to break with some latex class and journals like APS, usually one wants to have a complete figures, so it would be nice to have the figure as an eps.
  * this wrong length calculation in gnuplot are very tedious, and coming from the fact that e.g. _\theta_ counts in gnuplot as 6 letters and in latex as 1.
  * the bounding boxes of gnuplot are always slightly too big, which one could compensate in latex as well.

So what **gp2eps** is doing, is nothing more than taking the plot script, generate a tex file out of that (with help of gnuplot)
and giving the labels and the numbers the "right" size. Then latex is executed and the bounding box is made tight.
Right size very much depends on what do you want to do and what you think is nice. It normally makes

  * a label footnote size (0.8\*fontsize), change this with -f option
  * a numbers again 80% of the size of the labels, change this with -r option

The tricky things starts when you want to do half size (one column out of two) plots with the correct fontsize.
There essential two ways of doing that the `set size` way (see above) or the use of the -s option.
To make it as easy for the user as possible, you can forget about `set size` and just use -s and
include it without any  scale in your latex file with something like

```
\includegraphics{YYY.eps}
```

Internally it uses the size option of the terminal command. It also removed the pdf mark from the target file and adds the psfrag package to the header of the tex file.
Additionally it can generate dependencies for makefiles.

```
gp2eps --deps file.gp >> Makefile.incl
```

# TRICKS #

As all the gnuplot label and key are interpreted by latex, hence there are certain pitfalls and power features. Just to mention one of each:

  * The names of datafiles in the `plot` command tend to contain underscores (e.g. `data_1_super.d`) and gnuplot automatically puts the filename in the key, but latex interprets them afterwards and complains about a missing **$** or something. To overcome this use
```
unset key
```

> first to find out if there is a problem with underscores and then use
```
plot 'datafile' t 'some title'
```

> to avoid the underscores.
  * A very powerful thing one can do is to put a label with latex code, something like
```
set label 2 '\includegraphics[width=6cm]{sketch.eps}' at graph 0.3,graph 0.55
```

> to put a small sketch picture in the plot.

# HISTORY #

When I, Christoph, was at [ITP](http://www.physik.uni-leipzig.de) in Leipzig in 2005, there exist a script called fixpslatex which was doing
somehow the same thing, based upon gunplot's latex psauxfile terminal.
First I modified in a way to make it worked with epslatex terminal.
But when I went to [Mainz](http://www.mpip-mainz.mpg.de) in 2007, it was completely rewritten and I constantly added new options.

In 2009 I first published it outside my groups on googlecode under GPLv2.

In 2011 I rewrote gp2eps to use the size option of the terminal.

# AUTHOR #

Written and maintained by Christoph Junghans <<junghans (a) mpip-mainz mpg de>>

This Manual Page was written by Christoph
as a text file, then converted to this format by [txt2tags](http://txt2tags.sourceforge.net) !

# COPYRIGHT #

Copyright (C) 2005 - 2012 Christoph Junghans

This is free software; see the source for copying conditions. There is
NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.
