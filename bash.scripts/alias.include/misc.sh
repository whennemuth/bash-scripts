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
    sed -i $drive "$1"
    sed -i $slash "$1"
  else 
    local temp=$(echo -n "$1" | sed $drive)
    temp=$(echo -n "$temp" | sed $slash)
    echo -n "$temp"
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
    sed -i $drive "$1"
    sed -i $slash "$1"
  else
    local temp=$(echo -n "$1" | sed $drive)
    temp=$(echo -n "$temp" | sed $slash)
    echo -n "$temp"
  fi
}

grepNode() {
  local switches="$1"
  local expression="$2"
  [ -z "$expression" ] && echo "No search term provided" && return 1
  [ -z "$switches" ] && switches="-r"
  [ -z "$(echo -n $switches | grep -o '-')" ] && switches="-$switches"
  # read -p "Type an expression to search for: " expression; 
  grep $switches \
    --exclude-dir={node_modules,dist,build,test} \
    --exclude=*.bundle.js \
    --exclude=bundle.js \
    --exclude=*.min.js \
    --exclude=*.min.js.* \
    --exclude=*.map \
   "$expression" .
}

ecsupload() {
  if [ $1 ] ; then
    aws \
      s3 cp \
      /c/whennemuth/workspaces/ecs_workspace/cloud-formation/kuali/$1 \
      s3://kuali-research-ec2-setup/ecs/cloudformation/$1
  else
    aws \
      s3 cp \
      /c/whennemuth/workspaces/ecs_workspace/cloud-formation/kuali \
      s3://kuali-research-ec2-setup/ecs/cloudformation \
      --exclude=* \
      --include=*.template \
      --recursive
  fi
}

ecsvalidate() {
  local here="$(pwd)"
  cd /c/whennemuth/workspaces/ecs_workspace/cloud-formation/kuali
  find . -type f -iname '*.template' | \
  while read line; do \
    local f=$(printf "$line" | sed 's/^.\///'); \
    [ -n "$1" ] && [ "$1" != "$f" ] && continue; \
    printf $f; \
    aws cloudformation validate-template --template-body "file://./$f"
    echo " "
  done
  cd $here
}

ecscreate() {
  stackaction "create-stack"
}

ecsupdate() {
  stackaction "update-stack"
}

stackaction() {
  local template="test/ec2-test-2.template"
   if [ $# == 1 ] ; then

      local action=$1

      ecsupload $template

      local parm1="ParameterKey=ConfigBucket,ParameterValue=kuali-research-ec2-setup"
      local parm2="ParameterKey=DockerImageTag,ParameterValue=1812.0024"
      local parm3="ParameterKey=DockerRepositoryURI,ParameterValue=730096353738.dkr.ecr.us-east-1.amazonaws.com/core"
      local parm4="ParameterKey=EC2InstanceType,ParameterValue=t2.small"
      local parm5="ParameterKey=Landscape,ParameterValue=sb"
      local parms="$parm1 $parm2 $parm3 $parm4 $parm5"
      
      aws \
        cloudformation $action \
        --stack-name ECS-EC2-test \
        --no-use-previous-template \
        --template-url "https://s3.amazonaws.com/kuali-research-ec2-setup/ecs/cloudformation/$template" \
        --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
        --parameters $parms

      return 0
   fi
   echo "INVALID/MISSING stack action parameter required."
}

ecsMetaRefresh() {
  local instanceId=$(aws cloudformation describe-stack-resources \
    --stack-name ECS-EC2-test \
    --logical-resource-id MyEC2Instance \
    | jq '.StackResources[0].PhysicalResourceId' \
    | sed 's/"//g')

  echo "instanceId = $instanceId"

  printf "Enter the name of the configset to run: "
  read configset
  # NOTE: The following does not seem to work properly:
  #       --parameters commands="/opt/aws/bin/cfn-init -v --configsets $configset --region "us-east-1" --stack "ECS-EC2-test" --resource MyEC2Instance"
  # Could be a windows thing, or could be a complexity of using bash to execute python over through SSM.
  aws ssm send-command \
    --instance-ids "${instanceId}" \
    --document-name "AWS-RunShellScript" \
    --comment "Implementing cloud formation metadata changes on ec2 instance MyEC2Instance ($instanceId)" \
    --parameters \
    '{"commands":["/opt/aws/bin/cfn-init -v --configsets '"$configset"' --region \"us-east-1\" --stack \"ECS-EC2-test\" --resource MyEC2Instance"]}'
}

updateIam() {
  ecsupload test/iam_for_kuali.template
  aws \
    cloudformation update-stack \
    --stack-name Kuali-IAM-EC2 \
    --no-use-previous-template \
    --template-url "https://s3.amazonaws.com/kuali-research-ec2-setup/ecs/cloudformation/test/iam_for_kuali.template" \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM
}

# Get the debuglink for a node 8.x app running inside a docker container on a remote server.
# The docker network url must be replaced with a localhost url.
# Also, for some reason, curling the json/list url may suddenly stop outputting the debuglink info, even though it is still valid.
# Therefore, we cache the last known output in the /tmp directory and output that, hoping it is still the right one.
# If not, then the only way to get a new debug link is to restart the docker container and run again.
debugurl() {

  local nodeversion="$1"

  if [ $nodeversion == "6.x" ] ; then
    docker logs core | grep "chrome-devtools" | tail -n1
    return
  fi

  # nodeversion must be 8.x
  docker exec core curl 127.0.0.1:9229/json/list  > /tmp/core.debug.link.temp

  if [ -n "(cat /tmp/core.debug.link.temp 2>/dev/null | grep -i debuglink)" ] ; then
    local refresh="true"
  elif [ ! -f /tmp/core.debug.link ] ; then
    local refresh="true"
  elif [ -z "(cat /tmp/core.debug.link 2>/dev/null | grep -i debuglink)" ] ; then
    local errmsg="Cannot find a debug link!"
    local refresh="true"
  fi

  if [ $refresh ] ; then
    [ -f /tmp/core.debug.link ] && rm -f /tmp/core.debug.link
    mv /tmp/core.debug.link.temp /tmp/core.debug.link
  fi

  rm -f /tmp/core.debug.link.temp

  [ $errmsg ] && echo $errmsg && return

  cat /tmp/core.debug.link \
    | grep devtools \
    | sed 's/[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*/127.0.0.1/g' \
    | sed 's/[",]//g' \
    | sed 's/devtools[a-zA-Z]*//' \
    | sed 's/://'
}

