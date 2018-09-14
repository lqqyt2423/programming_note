#!/bin/sh

name=$(ls | grep recent-notes)
nowName=$(date +%Y%m%d)-recent-notes.md
mv $name $nowName
