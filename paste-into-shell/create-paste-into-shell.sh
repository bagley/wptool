#!/bin/bash

file=./paste-into-shell

# vars
filetmp=./${file}.tmp
rm -f $file $filetmp
wptool_file="../wptool"
scan_strings_file="../scanstrings"

# check we can access the 
if ! [ -f $wptool ] || ! [ -f $scan_strings_file ] ; then
  echo "Could not find wptool or scan strings files. Exiting"
  exit
fi

# wptool
cat $wptool_file > $filetmp

# scan_strings
scan_strings="$(cat $scan_strings_file)"
#echo -e 'scan_strings="' >> $filetmp
#cat $scan_strings_file | sed 's/"/\\"/g' >> $filetmp
#echo '"' >> $filetmp

# other commands
# cat <<EOF > ./$file
morecmds=$(echo '
clear
if [ "$(type -t wpurl)" != "function" ] ; then 
  echo "Failed to load tool"
else
  if [ -d "./public_html" ] ; then
    cd ./public_html
  fi
  if [ -f "./wp-config.php" ] ; then
    wpdb
    wpscan rquick script
    wpurl
  fi
  echo "All loaded and ready"
fi
' | base64 -w0)
# EOF

#if [ "\$(type -t wpurl)" != "function" ] ; then ; echo "Failed to load tool" ; else ; if [ -d "./public_html" ] ; then ; cd ./public_html ; fi ; if [ -f "./wp-config.php" ] ; then ; wpurl ; wpdb ; wpscan rquick quiet ; fi ; echo "All loaded and ready" ; fi

# base64 it
wptool64="$(cat $filetmp | base64 -w0)"


cat <<EOF > ./$file
read -s -dĦ scan_strings
$scan_strings
Ħnone 2>/dev/null

read -s -dĦ INPUT
$wptool64
Ħnone 2>/dev/null
. <(echo \$INPUT | base64 -d) >/dev/null

read -s -dĦ INPUT
$morecmds
Ħnone 2>/dev/null
. <(echo \$INPUT | base64 -di)

EOF

rm -f $filetmp

echo "  Paste file created: $file"
echo "   Open that and you can paste the contents into a terminal,"
echo "    as an optional way to load it."
