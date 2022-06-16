#!/bin/bash

pushd /opt/wef &>/dev/null
rm /opt/wef/wef 2>/dev/null
rm /usr/bin/wef 2>/dev/null

wget "https://raw.githubusercontent.com/D3Ext/WEF/main/WEF" &>/dev/null
cp WEF /usr/bin/wef 2>/dev/null
mv WEF /opt/wef/wef 2>/dev/null
chmod +x /opt/wef/wef 2>/dev/null
chmod +x /usr/bin/wef 2>/dev/null

popd &>/dev/null
