findAndOpenInVim(){
   vi $(find . -type f -iname $1)
}

# Turn a unix style path to a windows style path.
# The first parameter either:
#   1) A string representing one or more paths (it's windows-converted value will be echoed)
#   2) The path to a file whose content contains unix paths which need to be converted in place to windows paths.
# Include a second parameter (any value) to indicate the first parameter is a file pathname
convertToWindowsPath() {
  local drive='s/\/c\//c:\\/gi'
  local slash='s/\//\\/gi'
  
  if [ -n "$2" ] ; then  
    sed -i $drive $1
    sed -i $slash $1
  else 
    local temp=$(echo -n $1 | sed $drive)
    temp=$(echo -n $temp | sed $slash)
    echo -n $temp
  fi
}

# Turn a windows style path to a unix style path.
# The first parameter either:
#   1) A string representing one or more paths (it's unix-converted value will be echoed)
#      NOTE: This parameter must be surrounded by single quotes when the function is called.
#   2) The path to a file whose content contains windows paths which need to be converted in place to unix paths.
# Include a second parameter (any value) to indicate the first parameter is a file pathname
convertToUnixPath() {
  local drive='s/c:\\/\/c\//gi'
  local slash='s/\\/\//gi'
  
  if [ -n "$2" ] ; then  
    sed -i $drive $1
    sed -i $slash $1
  else 
    local temp=$(echo -n $1 | sed $drive)
    temp=$(echo -n $temp | sed $slash)
    echo -n $temp
  fi
}