#!/bin/bash

arr=$(ls /home )

for t in ${arr[@]}; do
cat << EOF >> /home/$t/.bashrc
if [ "\$(id -u)" -eq 0 ]; then
    PS1="\e[31m\u@\h \e[34m\t\e[m # "
else
    PS1="\e[32m\u@\h \e[34m\t\e[m $ "
fi
EOF
done

cat << EOF >> /etc/bash.bashrc
if [ "\$(id -u)" -eq 0 ]; then
    PS1="\e[31m\u@\h \e[34m\t\e[m # "
else
    PS1="\e[32m\u@\h \e[34m\t\e[m $ "
fi

EOF

cat << EOF >> /root/.bashrc
    PS1="\e[31m\u@\h \e[34m\t\e[m # "
EOF