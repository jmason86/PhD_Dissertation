#!/bin/bash

git checkout master

rm -f logfile
git log --pretty=oneline | tail -r > logfile
num=`wc logfile | awk '{print $1}'`

rm -f progress_data
touch progress_data

for (( i=1; i<=${num}; i++ ))
do
	sha=`head -n ${i} logfile | tail -n 1 | awk '{print $1}'`
	timestamp=`git log --pretty=email ${sha} | head -n 3 | tail -n 1 | sed 's\Date:\\\g' | sed 's\-0600\\\g'`
	t=`date -d "${timestamp}" +%s`
	# 1446184800
	t1=`echo "scale=4; (1446184800. - ${t})/3600./24." | bc -q 2>/dev/null`
	
	# count words
	git checkout ${sha}
	w1=`wc LaTeX/chapter1.tex | awk '{print $2}'`
	w2=`wc LaTeX/chapter2.tex | awk '{print $2}'`
	w3=`wc LaTeX/chapter3.tex | awk '{print $2}'`
	w4=`wc LaTeX/chapter4.tex | awk '{print $2}'`
	w5=`wc LaTeX/chapter5.tex | awk '{print $2}'`
	w6=`wc LaTeX/chapter6.tex | awk '{print $2}'`
	w7=`wc LaTeX/chapter7.tex | awk '{print $2}'`
	w8=`wc LaTeX/chapter8.tex | awk '{print $2}'`

	echo ${t1} 0${w1} 0${w2} 0${w3} 0${w4} 0${w5} 0${w6} 0${w7} 0${w8} >> progress_data
done

git checkout master

rm -f logfile