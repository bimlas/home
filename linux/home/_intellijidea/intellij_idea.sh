#!/bin/bash

cd ~/.IntelliJIdea*/config
rm -rf eval/

cd options
grep -v 'evlsprt' options.xml > options.xml.tmp; mv options.xml.tmp options.xml

rm -rf ~/.java/.userPrefs/jetbrains/
