FROM ubuntu:latest

RUN apt-get -y update
RUN apt-get install -y vim git zsh wget tmux curl unzip sudo

COPY .dot-files /root/dot-files
COPY .localrc /root/.localrc

WORKDIR /root

# setup dot files
RUN ./dot-files/install
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install

CMD /bin/zsh
