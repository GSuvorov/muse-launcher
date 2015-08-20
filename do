#!/bin/bash -u -e
source ~/.bashrc

# build flattened jar
mvn # clean compile assembly:single

# add the needed icons etc.
cd lib
jar uvf ../target/muse-standalone-jar-with-dependencies.jar index.html edu/stanford/ejalbert/launching/windows/windowsConfig.properties 

# add crossdomain.xml only to full epadd, not to discovery
jar uvf ../target/muse-standalone-jar-with-dependencies.jar crossdomain.xml 

# add wars to standalone-jar
cd ../../muse/target
/bin/cp -p muse-1.0.0-SNAPSHOT.war muse.war
jar uvf ../../muse-launcher/target/muse-standalone-jar-with-dependencies.jar muse.war

# delete epadd.war to avoid any confusion about which version it is (regular or discovery)
/bin/rm -f muse.war

# prepare standalone jars
cd ../../muse-launcher
/bin/mv -f target/muse-standalone-jar-with-dependencies.jar muse-standalone.jar
