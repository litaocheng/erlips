#! /bin/bash
# author: litaocheng@gmail.com
# date: 2009.9.16
# desc: get the maxmind geolite binary ip database, move it to the
#       erlips priv dir

GEODATAGZ=GeoIPCity.dat.gz
ROOT=$(cd `dirname $0`/..; pwd)
PRIV=${ROOT%/}/priv
mkdir -p $PRIV

#echo "priv $PRIV"

cleanup()
{
    echo "do the cleanup"
    rm -rf GeoIPCity.dat.*
    exit 1
}
trap cleanup INT TERM

echo "downloading the geolite.dat.gz..."
OUTPUT=$PRIV/$GEODATAGZ
if wget -O $OUTPUT http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz; then
    echo "ok"
    echo ""
else
    echo "failed"
    exit 1
fi

echo "gungzip the database..."
if gunzip $OUTPUT; then
   echo "ok"
else 
   echo "failed"
   exit 1
fi
