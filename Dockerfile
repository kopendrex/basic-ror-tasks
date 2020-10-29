# Strict version applied, Gemfile declares it and fails when there is a difference
FROM ruby:2.5.3

LABEL maintainer="Netguru S.A. <hello@netguru.com>"
ENV NODE_ENV production
RUN apt-get update \
     && apt-get install --yes --no-install-recommends openssh-server vim curl wget tcptraceroute openrc nodejs \
     && rm -f /etc/ssh/sshd_config \
     && mkdir -p /tmp \
     && mkdir -p /opt/startup \
     && echo "root:Docker!" | chpasswd

# Keep the app data in /srv
RUN mkdir -p /srv

COPY /docker/sshd_config /etc/ssh/
COPY /docker/setup_ssh.sh /tmp
COPY /docker/ngstartup.sh /opt/startup/

WORKDIR /srv

RUN chmod +x /tmp/setup_ssh.sh \
    && chmod -R +x /opt/startup \
    && (sleep 1;/tmp/setup_ssh.sh 2>&1 > /dev/null) \
    && rm -rf /tmp/*

EXPOSE 80 8080 2222 7433
ENV PORT 8080
ENV SSH_PORT 2222

ENTRYPOINT ["/opt/startup/ngstartup.sh"]

# Dependencies for RoR app
COPY Gemfile Gemfile.lock /srv/
RUN bundle install

COPY . ./

RUN chmod +x /srv/run.sh

CMD ["/srv/run.sh"]