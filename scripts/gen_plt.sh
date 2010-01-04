# !/bin/bash
# author: litaocheng@gmail.com
# date  : 2009.9.4
# desc  : create the plt file for dialyzer
usage()
{
    echo "-----------------------------------------------------------------"
    echo ""
    echo "gen_plt -p path -a app ..."
    echo " if the app is ommited, then default appliactions is"
    echo " erts, kernel, stdlib"
    echo ""
    echo "options:"
    echo "  -p      specify the dialyzer output path."
    echo "          the plt file is path/.dialyzer_plt"
    echo "  -a      addtional application name exclude erts, kernel, stdlib. "
    echo "          e.g. mnesia, inets"
    echo ""
    echo "-----------------------------------------------------------------"
}

erl_top()
{
    ERL_RUN="erl -eval 'io:format(\"ERL_TOP|~s|\", [code:root_dir()]), init:stop()'"
    ERL_OUTPUT=$(eval $ERL_RUN)
    ERL_TOP=`echo $ERL_OUTPUT | cut -d '|' -f 2`
    echo -e "ERL_TOP is " $ERL_TOP
    export ERL_TOP 
}

# check if the ERL_TOP has been set
if [ -z "$ERL_TOP" ]; then
   erl_top 
fi

ROOTDIR=`cd $(dirname $0)/..; pwd`   
#echo "rootdir $ROOTDIR"

PLT_PATH=$ROOTDIR
PLT=".dialyzer_plt"

APPS=(erts kernel stdlib)

if [ $# -ge 1 ]; then
    i=${#APPS[@]}
    #echo "i is $i"
    while [ $# -ne 0 ]; do
        ARG=$1
        shift
        case $ARG in
            -p )
                PLT_PATH=$1
                shift;;
            -a )
                APP=$1
                APPS[i]=$APP
                i=$((i+1))
                shift;;
            -h )
                usage
                exit 0;;
            * )
                usage
                exit 1
        esac
    done
fi

echo "Apps is :${APPS[@]}"
    
# the app libs
DIALYZER_OPTS=
for app in "${APPS[@]}"; do
    DIALYZER_OPTS="${DIALYZER_OPTS} ${ERL_TOP}/lib/${app}-*/ebin"
    #echo "dialyzer opts is $DIALYZER_OPTS"
done

# gen the plt file
dialyzer --build_plt --verbose --output_plt $PLT_PATH/$PLT  -r ${DIALYZER_OPTS}

OUTFILE=$HOME/$PLT
echo "  create dialyzer plt ok"
echo "  the dialyzer plt is:"
echo "  $OUTFILE"
