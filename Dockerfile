FROM alpine

RUN \
  apk update && \
  apk add curl bash bash-completion jq util-linux

ADD mesos-cli /usr/local/bin/mesos-cli
ADD dicker /usr/local/bin/dicker
ADD mesos-cli-completion /usr/local/share/bash-completion/mesos-cli-completion
ADD dicker-completion /usr/local/share/bash-completion/dicker-completion
ADD docker-assets/bashrc /root/.bashrc

CMD ["/bin/bash"]

