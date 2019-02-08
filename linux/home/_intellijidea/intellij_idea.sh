#!/bin/bash

cd ~/.IntelliJIdea*/config
rm -rf eval/

cd options
grep -v 'evlsprt' other.xml > other.xml.tmp; mv other.xml.tmp other.xml

rm -rf ~/.java/.userPrefs/jetbrains/
