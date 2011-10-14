#! /bin/bash
# Last edited on 2009-10-11 19:20:59 by stolfilocal

usage="$0 [ -delay N ] OUTNAME.gif  FRAME.png ..."

delay=5

while [[ ( $# -gt 0 ) && ( "/${1:0:1}" == "/-" ) ]]; do
  if [[ ( $# -ge 2 ) && ( "/$1" == "/-delay" ) ]]; then
    delay="$2"; shift; shift
  else
    echo 'invalid option "'"$1"'"' 1>&2
    echo "usage: ${usage}" 1>&2; exit 1
  fi
done

if [[ $# -lt 2 ]]; then 
  echo "usage: ${usage}" 1>&2; exit 1
fi

outimg="$1"; shift
frames=( $@ )

convert -loop 20 -delay ${delay} ${frames[@]} ${outimg}
