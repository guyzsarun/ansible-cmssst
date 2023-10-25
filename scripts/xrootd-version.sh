unset XRD_LOGLEVEL
xrdmapc --list s $1 | awk '{print $2}'  > tmp.txt

while read line || [ -n "$line" ]; do
  XRD_VERSION="timeout"
  XRD_VERSION=$( timeout 10s xrdfs $line query config version)
  echo $line $XRD_VERSION
done < tmp.txt

rm tmp.txt