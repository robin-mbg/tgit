#! /bin/bash

UPLINE=$(tput cuu1)
ERASELINE=$(tput el)

GIT_COMMAND_ARGS="$@"
TERMINAL_COLS=$(tput cols)

execute_git_in_background () {
    git $GIT_COMMAND_ARGS &
    git_PID=$!
    echo "Launching $GIT_COMMAND_ARGS with PID $git_PID"
}

end_if_git_finished () {
    if [[ -z `ps -p $git_PID | grep $git_PID` ]] ;
    then
        echo "Finished."
        exit 0
    fi
}

# Execute only long-running git commands with the progress tortoise
if [[ "$@" == clone* || "$@" == pull* || "$@" ==  push* || "$@" ==  fetch* ]] ;
then
    execute_git_in_background
else
    git "$@"
    exit 0
fi

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
    
    print_tortoise $TERMINAL_COLS
    #for i in {$(expr $(tput cols) - 20)..1}
    for i in {74..1}
    do
        end_if_git_finished
        erase_tortoise      
        print_tortoise $i
        
        sleep .05
    done
}

for i in {1..100}
do
    move_tortoise
    erase_tortoise
done

