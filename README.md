# list-SSH-info-on-mac
script to list your ssh information on mac. Add script to $home/.ssh directory and place 

alias sshinfo='bash $HOME/.ssh/sshInfo.sh'

in your .bash_profile to access it form anywhere

todo: 

add another entry to config file for .ssh
autocomplete for hosts
setup RSA key 
  cases:
  - all: copy to all hosts
  - all password: copy to all hosts that have password as preferredAuth
  - host: copy to specific host
    - if host - check if host exists
      - yes - use info under host to connect
      - no - ask for ip or hostName
  - hostName: copy to specific hostName
  - ip: copy to specific ip
    - if ip - check under hostNames in config
      - if yes - use connection info
      - if no - ask for username

