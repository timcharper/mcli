FROM alpine

RUN \
  apk update && \
  apk add curl bash bash-completion jq util-linux

ADD dicker mesos-cli marathon-cli /usr/local/bin/mesos-cli/
ADD marathon-cli-completion dicker-completion mesos-cli-completion /usr/local/share/bash-completion/mesos-cli-completion/
ADD docker-assets/bashrc /root/.bashrc

CMD ["/bin/bash"]

