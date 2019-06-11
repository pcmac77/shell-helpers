# Source env vars

. $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/env

# To show current git branch.
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_CYAN="\[\033[0;96m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
NO_COLOR="\[\033[0m\]"

# To show exit code of previous command.
exitstatus()
{
    if [[ $? == 0 ]]; then
        echo ':)'
    else
        echo 'D:'
    fi
}

eth0_ip() {
    #/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'
    # Get just the last byte
    ip -o addr show dev "eth0" | awk '$3 == "inet" {print $4}' | sed -r 's!/.*!!; s!.*\.!!'
}

disk_free() {
    df . -k| grep -v Use | awk '{print $5}'
}

load() {
    uptime | sed -n 's/.*load average: //p'| awk '{print $1}'| tr -d ','
}
# Put everything together
#PS1="$GREEN\u@\h$NO_COLOR:\w$YELLOW\$(parse_git_branch)$NO_COLOR \$ "
PS1="$BLUE\u@$(eth0_ip) ${YELLOW}\$(disk_free) ${BLUE}\$(load)$NO_COLOR:\w$LIGHT_PURPLE\$(parse_git_branch)$NO_COLOR \$ "


# Function to copy ssh-key to aGalaxy
function copy-ssh-key() {
    local AGA_SSH_PASSWD=$AGA_ROOT_SSH_PASSWD

    local target=$1
    if [ -z $target ]; then
        echo "Please specify a target. Ex: copy-ssh-key 192.168.98.21"
        return 1
    fi
    sshpass -p${AGA_SSH_PASSWD} ssh-copy-id root@${target}
}

export AGALAXY_IP=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`
export AGA_SCP_USERNAME=a10
export AGA_SCP_PASSWORD=a101234

function disk-usage() {
    local path=$1
    if [ -z $target ]; then
        target=./
    fi
    du $path -h --max-depth=1 | sort -h
}

function get-dev-accounts() {
    ssh root@192.168.99.27 'find /mnt/a10/it/etc/sudoers.a10 -name "*tp*.sudoers" -exec grep Alias {} /dev/null \;'
}
