git_ssh(){
  # #1 = path of local git repo
  # $2 = name of ssh private key
  # $3 = name of the git remote
  # $4 = name of the git repository
  eval "ssh-agent -k"
  cd $1
  eval `ssh-agent -s`
  ssh-add ~/.ssh/$2
  ssh -T git@github.com
  if [ -z "$(git remote | grep -P ^$3\$)" ] ; then
    git remote add $3 git@github.com:$4
  fi
}
