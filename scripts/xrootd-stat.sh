ENDPOINT=$1
xrdfs $ENDPOINT query stats a > tmp-$ENDPOINT.xml

parse_xml () {
  local XML=$1
  echo $(xmllint --xpath  "$XML"  tmp-$ENDPOINT.xml)
}



VERSION=$(parse_xml "string(//statistics/@ver)")
SITE_NAME=$(parse_xml "string(//statistics/@site)")
URL=$(parse_xml "string(//statistics/@src)")
ROLE=$(parse_xml "string(/statistics/stats[@id='ofs']/role)")
OPEN=$(parse_xml "string(/statistics/stats[@id='xrootd']/ops/open)")
PID=$(parse_xml "string(/statistics/@pid)")
TOS=$(parse_xml "string(/statistics/@tos)")
D_TOS=$(date -d @${TOS})

L_NUM=$(parse_xml "string(/statistics/stats[@id='link']/num)")
L_REC=$(numfmt --to iec --format "%8.4f" $(parse_xml "string(/statistics/stats[@id='link']/in)"))
L_SEN=$(numfmt --to iec --format "%8.4f" $(parse_xml "string(/statistics/stats[@id='link']/out)"))


X_GET=$(parse_xml "string(/statistics/stats[@id='xrootd']/num)")
X_OPE=$(parse_xml "string(/statistics/stats[@id='xrootd']/ops/open)")
X_RED=$(parse_xml "string(/statistics/stats[@id='xrootd']/ops/rd)")
X_MIS=$(parse_xml "string(/statistics/stats[@id='xrootd']/ops/misc)")

echo "sitename: ${SITE_NAME}  ${URL}"
echo "version: ${VERSION} role: $ROLE"
echo "pid: ${PID} service start time : ${TOS} / ${D_TOS} "
echo "Current open connections: ${L_NUM}"
echo "Total GB sent / received ${L_SEN} / ${L_REC}"
echo "Request received ${X_GET}"
echo "  File open: ${X_OPE}"
echo "  File read: ${X_RED}"
echo "  File misc: ${X_MIS}"

rm -rf tmp-$ENDPOINT.xml