
for line in $(find ~/bash.scripts/alias.include -type f -iname '*.sh') ; do 
  eval "source $line"; 
done

alias gitbudoc='git_ssh /c/whennemuth/documentation/bu github_id_rsa github whennemuth/bu-docs.git'
alias gittest1='git_ssh /c/gittest1 gittest_rsa_key github whennemuth/gittest.git'
alias gittest2='git_ssh /c/gittest2 gittest_rsa_key github whennemuth/gittest.git'
alias gitkc='git_ssh /c/whennemuth/workspaces/kuali_workspace/kuali-research github_id_rsa github bu-ist/kuali-research.git'
alias gitkualiui='git_ssh /c/kuali-ui bu_github_id_kualiui_rsa bu bu-ist/kuali-ui.git'
alias bye='eval `ssh-agent -k` && exit'

alias versions='cat pom.xml | grep -P "(<coeus\-api\-all\.version)|(<coeus\-s2sgen\.version)|(<rice\.version)|(<schemaspy\.version)|(<version>[a-zA-Z\d\.\-]+</version>)"'

alias bastion='source /c/whennemuth/documentation/bu/aws/ssh/bastion.sh'

# AWS EC2 instances
alias sandbox='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.237.84'
alias sandboxcoretunnel='ssh -i ~/.ssh/buaws-kuali-rsa -N -v -L 9229:10.57.237.84:9229 wrh@10.57.237.84'
alias sandboxcoitunnel='ssh -i ~/.ssh/buaws-kuali-rsa -N -v -L 9228:10.57.237.84:9228 wrh@10.57.237.84'
alias cicoretunnel='ssh -i ~/.ssh/buaws-kuali-rsa -N -v -L 9229:10.57.237.36:9229 wrh@10.57.237.36'
alias qacoretunnel='ssh -i ~/.ssh/buaws-kuali-rsa -N -v -L 9229:10.57.236.244:9229 wrh@10.57.236.244'
alias ci='ssh -i  ~/.ssh/buaws-kuali-rsa wrh@10.57.237.36'
alias jenkins='ssh -i  ~/.ssh/buaws-kuali-rsa wrh@10.57.236.6'
alias qa='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.236.244'
alias staging1='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.236.68'
alias staging2='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.236.100'
alias mydevbox='ssh -i ~/.ssh/buaws-kuali-rsa-warren ec2-user@10.57.237.89'
alias mydevboxtunnel='ssh -i ~/.ssh/buaws-kuali-rsa-warren -N -v -L 8080:10.57.237.89:8080 -L 1043:10.57.237.89:1043 ec2-user@10.57.237.89'

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
alias sandboxweb1='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.237.69'
alias prod1='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.242.100'
alias prod2='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.243.100'
alias sandbox3='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.237.87'
alias agile='ssh -i ~/.ssh/buaws-kuali-rsa wrh@10.57.237.86'
alias pgdata='ssh -i ~/.ssh/buaws-kuali-rsa -L 63333:172.17.0.3:5432 wrh@10.57.237.86'
alias training='ssh -i ~/.ssh/buaws-sandbox-warren-rsa ec2-user@34.197.201.237'
alias coi='ssh -i ~/.ssh/centos7_rsa -p 2224 root@localhost'
alias fvi='findAndOpenInVim'
alias coitest='ssh -i ~/.ssh/buaws-coi-test ec2-user@52.3.122.103'
alias krd='cd /c/whennemuth/kuali-research-docker'
alias backup='read -p "Type the pathname of the file: " file; cat $file > ${file}.backup.$(date +"%m-%d-%y")'
alias grepnode='read -p "Type a regex expression to search for: " expression; grep --exclude-dir={node_modules,dist,build,test} -irP "$expression" .'
alias compileone='compile_one'
alias compileonetest='compile_one_test'
alias coeus.impl.build='cd /c/whennemuth/workspaces/kuali_workspace/kuali-research; mvn -e -Dmaven.test.skip=true -pl coeus-impl clean compile package -Dgrm.off=true'
alias coeus.webapp.build='cd /c/whennemuth/workspaces/kuali_workspace/kuali-research; mvn -e -Dmaven.test.skip=true -pl coeus-webapp clean compile package -Dgrm.off=true'
alias coeus.webapp='cd /c/whennemuth/workspaces/kuali_workspace/kuali-research/coeus-webapp'
alias coeus.impl='cd /c/whennemuth/workspaces/kuali_workspace/kuali-research/coeus-impl'
alias git.bash.scripts='git_ssh ~ github_id_rsa github whennemuth/bash-scripts.git'
alias notes='vim /c/whennemuth/documentation/bu/linux/expressions.txt'
