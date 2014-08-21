#!/bin/bash
# msv - docbook validation with libmsv-java
# ========== BimbaLaszlo(.github.io|gmail.com) =========== 2014.08.22 07:12 ==

if [[ -e '/usr/share/java/msv-core.jar' ]]; then
  msv='java -classpath /usr/share/java/xsdlib.jar'
  msv+=':/usr/share/java/isorelax.jar'
  msv+=':/usr/share/java/relaxngDatatype.jar'
  msv+=':/usr/share/java/msv-testharness.jar'
  msv+=':/usr/share/java/xercesImpl.jar'
  msv+=':/usr/share/java/xml-apis.jar'
  msv+=':/usr/share/java/ant.jar'
  msv+=':/usr/share/java/ant-launcher.jar'
  msv+=':/usr/share/java/xml-resolver.jar'
  msv+=':/usr/share/java/msv-core.jar'
  msv+=' com.sun.msv.driver.textui.Driver'

  $msv $*
else
  echo 'ERROR: libmsv-java not installed'
fi
