#!/bin/sh


current=$(git describe --exact-match --tags)
saved=$(cat mytag.txt)

echo ${current} ${saved}

if [ "${current}" == "${saved}" ]; then
  echo "They are the same, so do nothing"
else
  echo "Execute stuff and update mytag.txt"
  git describe --exact-match --tags |& tee mytag.txt
fi
  

