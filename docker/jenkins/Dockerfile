FROM jenkins

RUN /usr/local/bin/install-plugins.sh \
   amazon-ecs \
   cloudbees-folder \
   git \
   github \
   github-oauth \
   simple-theme-plugin \
   timestamper \
   workflow-aggregator \
   ws-cleanup

ADD config/org.codefirst.SimpleThemeDecorator.xml $JENKINS_HOME/org.codefirst.SimpleThemeDecorator.xml
