#!/bin/bash
set -o nounset
set -o errexit

name=$(ls | grep recent-notes)
nowName=$(date +%Y%m%d)-recent-notes.md
mv $name $nowName
