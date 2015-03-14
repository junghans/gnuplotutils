#Some scripts to improve the work with gnuplot.

##gplot
* quick plot: `gplot file with lines`
* plot from stdin: `seq 1 10 | gplot`
* quick eps: `gplot -t "Title" -o pic.eps file`
* generate a plot script: `gplot -p -xx data with lines`

##gp2eps
* Convert gnuplot script to eps quickly using LaTeX: `gp2eps plot.gp`
* Allows to scale numbers different than labels: `gp2eps --ratioscale X.X plot.gp`
* Flexible font size: `gp2eps -p 12 plot.gp`

##tricktex
* Take many eps pics and make an pdf: `tricktex --pic *.eps`
* Text to eps: `tricktex 'A text'`
* Formulars to eps: `tricktex '\omega'`

##Issues

Report bugs on the [github issues site](https://github.com/junghans/gnuplotutils/issues)

