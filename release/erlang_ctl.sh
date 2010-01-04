#! /bin/bash
# desc: disable or enable the default erlang
ERL=$(which erl 2> /dev/null)
ERL_REC=.erlang.original
BAK=.bak

usage()
{
    echo ""
    echo "usage"
    echo "./erlang_ctl.sh option"
    echo " option:"
    echo -e " enable \t- enable the default erlang"
    echo -e " disable\t- disable the default erlang"
    echo ""
}

enable_erlang()
{
    if [ -n "$ERL" ]; then
        echo "$ERL"
        echo "the erlang has installed"
        exit 1
    else
        if [ ! -f "$ERL_REC" ]; then
            echo "the $ERL_REC not exists"
            exit 1
        else
            ERL=`cat $ERL_REC`
            echo "echo erl is $ERL"
            if [ -n "ERL" ] && mv ${ERL}$BAK ${ERL}; then
                echo "enable erlang successlly"
                exit 0
            else
                echo "enable erlang error!"
                exit 1
            fi
        fi
    fi
}

disable_erlang()
{
    if [ -n "$ERL" ]; then
        # record the original erl path
        if !( echo "$ERL" > "$ERL_REC" 2> /dev/null ); then
            echo "record the original erl path error"
            exit 1
        fi

        if ! (mv ${ERL} ${ERL}${BAK});then
            echo "mv the erl error"
            exit 1
        fi
    else
        echo "erl not exists"
        exit 0
    fi
}

if [ "$#" -eq 0 ]; then
    usage
    exit 1
fi

ENABLE=false
while [ "$#" -ne 0 ];do
    OPT=$1
    shift
    case $OPT in 
        enable) ENABLE=true;;
        disable) ENABLE=false;;
        *) usage; exit 1;;
    esac
done

if [ "$ENABLE" = "true" ]; then
    enable_erlang
else
    disable_erlang
fi

