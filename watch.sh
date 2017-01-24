#!/bin/bash

ESC=$(printf '\033') ;
r1="s/Warning \([0-9]*\):/$ESC[38;5;226mWarning \1:$ESC[m/g" ;
r2="s/^Error:/$ESC[38;5;196mError:$ESC[m/g" ;
r3="s/^ninja:/$ESC[38;5;33mninja:$ESC[m/g" ;
r4="s/^FAILED:/$ESC[38;5;196mFAILED:$ESC[m/g" ;
r5="s/>>>> Finish compiling/$ESC[38;5;47m>>>> Finish compiling$ESC[m/g" ;
r6="s/line \([0-9]*\), characters \([[:graph:]]*\)/$ESC[38;5;208mline \1, characters \2$ESC[m/g" ;
r7="s/build stopped: subcommand failed\./$ESC[38;5;196mbuild stopped: subcommand failed.$ESC[m/g"

npm run watch -s | \
  sed -e "$r1" -e "$r2" -e "$r3" -e "$r4" -e "$r5" -e "$r6" -e "$r7"
