
for line in $(find ~/bash.scripts/alias.include -type f -iname '*.sh') ; do 
  eval "source $line"; 
done
alias scripts='vim ~/bash.scripts/alias.include/misc.sh'

S3(){ cd /c/whennemuth/scrap/s3/docker/$1/$2 && ls -la; }

# The AWS toolkit extension for Visual studio 2017 targets .net 4.0, which is not installed on this computer.
# Therefore any project created with this extension cannot be reloaded when anything happens to cause a reload.
# So, it's necessary to rebuild the project and keep it open.
# This is very annoying.
# This function restores the cloudformation template files.
vsremake() {
  # Delete the VS solution & project and recreate (remember to uncheck creation of a solution folder).
  cd  /c/whennemuth/documentation/bu/aws/ecs/cloudformation/kuali
  # Remove the default template made by project creation
  rm -f cloudformation.template
  git init
  git remote add github git@github.com:bu-ist/kuali-cloudformation.git
  git_ssh /c/whennemuth/documentation/bu/aws/ecs/cloudformation/kuali bu_github_id_kuali_cloudformation_rsa bu-ist/kuali-cloudformation.git
  git pull github master
}

alias gitbudoc='git_ssh /c/whennemuth/documentation/bu github_id_rsa github whennemuth/bu-docs.git'
alias gittest1='git_ssh /c/gittest1 gittest_rsa_key github whennemuth/gittest.git'
alias gittest2='git_ssh /c/gittest2 gittest_rsa_key github whennemuth/gittest.git'
alias gitkc='git_ssh /c/whennemuth/workspaces/kuali_workspace/kuali-research github_id_rsa github bu-ist/kuali-research.git'
alias gitkcremote='git_ssh /c/whennemuth/workspaces/kuali_workspace_remote/kuali-research github_id_rsa github bu-ist/kuali-research.git'
alias gitkualiui='git_ssh /c/kuali-ui bu_github_id_kualiui_rsa bu bu-ist/kuali-ui.git'
alias gitdocker='git_ssh /c/whennemuth/kuali-research-docker github_id_rsa bu-ist/kuali-research-docker.git'
alias gitcloudformation='git_ssh /c/whennemuth/workspaces/ecs_workspace/cloud-formation/kuali bu_github_id_kuali_cloudformation_rsa bu-ist/kuali-cloudformation.git'
alias cfn='cd /c/whennemuth/workspaces/ecs_workspace/cloud-formation/kuali; ls -la'
alias bye='eval `ssh-agent -k` && exit'

alias versions='cat pom.xml | grep -P "(<coeus\-api\-all\.version)|(<coeus\-s2sgen\.version)|(<rice\.version)|(<schemaspy\.version)|(<version>[a-zA-Z\d\.\-]+</version>)"'

alias bastion='source /c/whennemuth/documentation/bu/aws/ssh/bastion.sh'

# AWS EC2 instances
alias sandbox='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.237.84'
alias sandboxcoretunnel='ssh -i ~/.ssh/buaws-kuali-rsa -N -v -L 9229:10.57.237.84:9229 -L 3000:10.57.237.84:3000 wrh@10.57.237.84'
alias sandboxcoitunnel='ssh -i ~/.ssh/buaws-kuali-rsa -N -v -L 9228:10.57.237.84:9228 wrh@10.57.237.84'
alias cicoretunnel='ssh -i ~/.ssh/buaws-kuali-rsa -N -v -L 9229:10.57.237.36:9229 wrh@10.57.237.36'
alias cicoretunnel2='ssh -i ~/.ssh/buaws-kuali-rsa -N -v -L 9229:10.57.237.37:9229 wrh@10.57.237.37'
alias cicoitunnel='ssh -i ~/.ssh/buaws-kuali-rsa -N -v -L 8092:10.57.237.36:8092 wrh@10.57.237.36'
alias qacoretunnel='ssh -i ~/.ssh/buaws-kuali-rsa -N -v -L 9229:10.57.236.244:9229 -L 3000:10.57.236.244:3000 wrh@10.57.236.244'
alias ci='ssh -i  ~/.ssh/buaws-kuali-rsa wrh@10.57.237.36'
alias jenkins='ssh -i  ~/.ssh/buaws-kuali-rsa wrh@10.57.236.6'
alias qa='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.236.244'
alias qacoitunnel='ssh -i ~/.ssh/buaws-kuali-rsa -N -v -L 8092:10.57.236.244:8092 wrh@10.57.236.244'
alias staging1='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.236.68'
alias staging2='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.236.100'
alias mydevbox='ssh -i ~/.ssh/buaws-kuali-rsa-warren ec2-user@10.57.237.89'
alias mydevboxtunnel='ssh -i ~/.ssh/buaws-kuali-rsa-warren -N -v -L 8080:10.57.237.89:8080 -L 1043:10.57.237.89:1043 ec2-user@10.57.237.89'
alias mydevboxtunnel2='ssh -i ~/.ssh/buaws-kuali-rsa-warren -N -v -L 3000:10.57.237.89:3000 -L 9229:10.57.237.89:9229 ec2-user@10.57.237.89'

alias scpsandbox='echo "Enter path to the file to upload and press [ENTER]: " ; read file ; eval "scp -C -i ~/.ssh/buaws-kuali-rsa $file wrh@10.57.237.84:~/dockerbuild/"'

alias up='cd ..'

alias upp='cd ../..'

alias uppp='cd ../../..'

alias bld='mvn clean compile source:jar javadoc:jar install -Dgrm.off=true'

alias blde='mvn clean compile source:jar javadoc:jar install -e -Dgrm.off=true'

alias bldo='mvn clean compile source:jar javadoc:jar install -Poracle -Dgrm.off=true'

# alias taillog="eval \"sudo tail /var/log/kuali/tomcat/$(eval 'sudo ls -lat /var/log/kuali/tomcat | grep -P "localhost\." | head -1' | rev | cut -d' ' -f1 | rev) -f -n 2000\""

# alias cleanrmi='DANGLING=$(docker images --filter dangling=true -q); if [ -n "$DANGLING" ]; then docker rmi -f $DANGLING; else echo "No images to remove!"; fi'

# alias cleanvol='DANGLING=$(docker volume ls -qf dangling=true); if [ -n "$DANGLING" ]; then docker volume rm $DANGLING; else echo "No volumes to remove!"; fi'

# alias cleanall='cleanrmi && cleanvol'

alias killssh='eval "ssh-agent -k"'

alias buildkc='mvn clean compile source:jar javadoc:jar install -Dgrm.off=true -Dmaven.test.skip=true'
alias centos='ssh -i ~/.ssh/centos7_rsa -p 2222 root@localhost'
alias centos2='ssh -i ~/.ssh/centos7_rsa -p 2223 root@localhost'
alias ci2='ssh -i  ~/.ssh/buaws-kuali-rsa wrh@10.57.237.37'
alias sandbox2='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.237.85'
alias sandbox3='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.237.88'
alias sandbox4='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.237.93'
alias sandboxweb1='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.237.69'
alias prod1='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.242.100'
alias prod2='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.243.100'
alias agile='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.237.86'
alias pgdata='ssh -i ~/.ssh/buaws-kuali-rsa -L 63333:172.17.0.3:5432 wrh@10.57.237.86'
alias training='ssh -i ~/.ssh/buaws-sandbox-warren-rsa ec2-user@34.197.201.237'
alias coi='ssh -i ~/.ssh/centos7_rsa -p 2224 root@localhost'
alias fvi='findAndOpenInVim'
alias coitest='ssh -i ~/.ssh/buaws-coi-test ec2-user@52.3.122.103'
alias krd='cd /c/whennemuth/kuali-research-docker'
alias backup='read -p "Type the pathname of the file: " file; cat $file > ${file}.backup.$(date +"%m-%d-%y")'
alias grepnode='grepNode $1 $2'
alias compileone='compile_one'
alias compileonetest='compile_one_test'
alias coeus.impl.build='cd /c/whennemuth/workspaces/kuali_workspace/kuali-research; mvn -e -Dmaven.test.skip=true -pl coeus-impl clean compile package -Dgrm.off=true'
alias coeus.webapp.build='cd /c/whennemuth/workspaces/kuali_workspace/kuali-research; mvn -e -Dmaven.test.skip=true -pl coeus-webapp clean compile package -Dgrm.off=true'
alias webapp='cd /c/whennemuth/workspaces/kuali_workspace_remote/kuali-research/coeus-webapp'
alias impl='cd /c/whennemuth/workspaces/kuali_workspace_remote/kuali-research/coeus-impl'
alias git.bash.scripts='git_ssh ~ github_id_rsa github whennemuth/bash-scripts.git'
alias notes='vim /c/whennemuth/documentation/bu/linux/expressions.txt'
alias scrap='cd /c/whennemuth/scrap; ls -la'
alias 1705='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.237.88'
alias 1709='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.237.93'
alias rice='cd /c/kuali-kc-rice'
alias framework='cd /c/kuali-kc-rice/rice-framework'
alias gitselenium='git_ssh /c/whennemuth/workspaces/bu_workspace/selenium-test github_id_rsa github whennemuth/selenium-test.git'
alias gitknickknacks='git_ssh /c/whennemuth/workspaces/bu_workspace/knickknacks github_id_rsa github whennemuth/knickknacks.git'
alias gitkcbuilder='git_ssh /c/whennemuth/workspaces/bu_workspace/kcbuilder github_id_rsa github whennemuth/kcbuilder.git'
alias githelloworld='git_ssh /c/whennemuth/workspaces/bu_workspace/hello-world github_id_rsa github whennemuth/hello-world.git'
alias gitsyncusers='git_ssh /c/sync-users bu_github_id_kualiui_rsa bu bu-ist/sync-users.git'
alias kc='cd /c/whennemuth/kuali-research-docker/kuali-research/build.context; ls -la'
alias todo='vim /c/whennemuth/scrap/todo.txt'
alias bashlib='vim /c/whennemuth/kuali-research-docker/bash.lib.sh'
alias sourcebashlib='source /c/whennemuth/kuali-research-docker/bash.lib.sh'
alias core='cd /c/whennemuth/kuali-research-docker/core/build.context; ls -la'
alias coi='cd /c/whennemuth/kuali-research-docker/coi/build.context; ls -la'
alias gitcorecommon='git_ssh /c/kuali-core-common bu_github_id_core_common_rsa bu bu-ist/kuali-core-common.git'
alias portal='cd /c/whennemuth/kuali-research-docker/research-portal/build.context; ls -la'
alias findcust="grep -rP 'BU[\-\x20]CUSTOMIZATION' ."
alias coi='cd /c/whennemuth/kuali-research-docker/coi/build.context && ls -la'
alias bashrc='vim ~/.bashrc'
alias sbrc='source ~/.bashrc'
alias gitgadgets='git_ssh /c/kuali/cor-formbot-gadgets bu_github_id_cor_formbot_gadgets_rsa github bu-ist/kuali-cor-formbot-gadgets.git'
alias gitformbot='git_ssh /c/kuali/formbot bu_github_id_formbot_rsa github bu-ist/kuali-formbot.git'
alias gitlogdate='git log --oneline --decorate=full --pretty="format:%h %ci %d %s" $1 $2'
alias lab='ssh -i ~/.ssh/lab2.pem ec2-user@ec2-35-153-160-127.compute-1.amazonaws.com'
alias debuglink='docker exec core curl localhost:9229/json/list'
alias gitportal='git_ssh /c/kuali/research-portal bu_github_id_research_portal_rsa github bu-ist/kuali-research-portal.git'
alias dockermounts="docker inspect -f \"{{json .Mounts}}\" kuali-research | jq"
alias apache="cd /c/whennemuth/kuali-research-docker/apache-shib/build.context && ls -la"
alias prodcoretunnel='ssh -i ~/.ssh/buaws-kuali-rsa -N -v -L 9229:10.57.242.100:9229 wrh@10.57.242.100'
alias stagecoretunnel='ssh -i ~/.ssh/buaws-kuali-rsa -N -v -L 9229:10.57.236.68:9229 wrh@10.57.236.68'
alias presnotes='vim /c/whennemuth/scrap/ecs.presentation.notes.txt'
