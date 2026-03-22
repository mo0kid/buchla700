BASE=$1
cp68 -I d:\inc\ $BASE.c \tmp\cc.i
c068 \tmp\cc.i \tmp\cc.1 \tmp\cc.2 \tmp\cc.3 -e
rm \tmp\cc.i
rm \tmp\cc.3
c168 \tmp\cc.1 \tmp\cc.2 $BASE.s -l
rm \tmp\cc.1
rm \tmp\cc.2
