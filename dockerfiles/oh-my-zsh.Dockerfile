FROM ubuntu
RUN apt-get update
RUN apt-get install -y wget zsh git
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
CMD zsh
