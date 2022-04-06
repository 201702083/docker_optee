export DISPLAY=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}'):0

brew install XQuartz

open -a XQuartz
