#! /bin/bash

if [[ "$@" == clone* ]] ;
then
    git "$@" & &> tgit_tmp.txt
    git_PID=$!
    echo "Started git clone with PID $git_PID"
elif [[ "$@" == pull* ]] ;
then
    git "$@" & &> tgit_tmp.txt
    git_PID=$!
    echo "Started git pull with PID $git_PID"
elif [[ "$@" ==  push* ]] ;
then
    git "$@" & &> tgit_tmp.txt
    git_PID=$!
    echo "Started git push with PID $git_PID"
else
    git "$@"
    exit 0
fi

UPLINE=$(tput cuu1)
ERASELINE=$(tput el)

end_if_git_finished () {
    if [ -n "$git_PID" -a -e /proc/$git_PID ]; then
        echo "\n$UPLINE$ERASELINE"
    else
        echo "Process for PID $git_PID has finished"
        cat tgit_tmp.txt
        # rm tgit_tmp.txt
        exit 0
    fi
}

print_tortoise () {
    PREFIX=`seq 1 $1 | sed 's/.*/ /' | tr -d '\n'`
    echo "$PREFIX    ._     .--."
    echo "$PREFIX   (' \\  ,'    \`."
    echo "$PREFIX    \`._:^        \\:>"
    echo "$PREFIX        ^T~~~~~~T'"
    echo "$PREFIX        ~\"     ~\""
}

erase_tortoise () {
  echo "$UPLINE$ERASELINE$UPLINE$ERASELINE$UPLINE$ERASELINE$UPLINE$ERASELINE$UPLINE$ERASELINE$UPLINE$ERASELINE"
}

move_tortoise () {
    
    print_tortoise 0
    for i in {30..1}
    do
        erase_tortoise
        end_if_git_finished
        print_tortoise $i
        
        sleep .1
    done
}

echo "tgit CLI\n"

for i in {1..10}
do
    move_tortoise
    erase_tortoise
done

