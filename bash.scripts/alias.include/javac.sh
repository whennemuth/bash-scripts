#!/bin/bash
#
# requires misc.sh

# Compile one .java file in the coeus-impl codebase into its maven-built target directory.
# Maven takes too long to build the whole project for the sake of a single file.
# This requires that maven has built the coeus-webapp module so that a WEB-INF/lib
# directory exists and has all the jar files needed for the javac classpath to be satisfied.
#
compile_one() {

  # Hard-coded variables (modify if necessary).
  local TAG=1705.0034-SNAPSHOT
  local KC='C:\whennemuth\workspaces\kuali_workspace\kuali-research'

  # Composed variables (assumed correct by following maven/tomcat convention).
  local WEBAPP=$KC'\coeus-webapp'
  local LIB=$WEBAPP'\target\coeus-webapp-'$TAG'\WEB-INF\lib'
  local CLAZZPATH=$LIB'\*'
  local IMPL=$KC'\coeus-impl'
  local IMPL_SRC=$IMPL'\src\main\java'
  local IMPL_TARGET=$IMPL'\target\classes'
  
  local pathname=$(find $IMPL_SRC -type f -iname $1.java)
  local CLASS_TO_COMPILE=$(convertToWindowsPath $pathname)

  local CMD=$(cat <<-EOF
  javac \
     -d $IMPL_TARGET \
    -cp $CLAZZPATH \
        $CLASS_TO_COMPILE
EOF
  )

  echo $CMD
  # escape the windows path separarators
  CMD=$(echo $CMD | sed 's/\\/\\\\/g')
  eval $CMD
}
