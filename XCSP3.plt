#!/usr/bin/gnuplot

set terminal epslatex
set output "XCSP3.tex"
set size 0.95

set border 3
set tics nomirror

set xlabel "$d / n$"
set ylabel "$\\mathrm{TIME_{AC}} / \\mathrm{TIME_{BC}}$"

f(len, n, d, d_avg, e) = d / n
ratio(AC, BC) = AC / BC

set table "XCSP3.dat"
plot "CompetitionInstances.dat" index 0 using \
     (log10(f($2, $3, $4, $5, $6))):(log10(ratio($7, $8))) with table
unset table

set logscale xy

set arrow from graph 0,first 1 to graph 1,first 1 nohead linetype 0
set arrow from first 1,graph 0 to first 1,graph 1 nohead linetype 0

stats "" index 0 using (f($2, $3, $4, $5, $6)):(ratio($7, $8)) nooutput

plot "" index 0 using (f($2, $3, $4, $5, $6)):(ratio($7, $8)) notitle \
        with points linecolor 1 pointtype 68, \
     "" index 1 using (f($2, $3, $4, $5, $6)):(STATS_min_y) notitle \
        with points linecolor 1 pointtype 67, \
     "" index 2 using (f($2, $3, $4, $5, $6)):(STATS_max_y) notitle \
        with points linecolor 1 pointtype 66, \
     "LOESS.dat" using (10**$1):(10**$2) smooth unique notitle
