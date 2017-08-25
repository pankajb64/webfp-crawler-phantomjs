FROM ubuntu:14.04

MAINTAINER Pankaj Bhambhani <pankajb64@gmail.com>

#Ref1 - https://blog.scrapinghub.com/2016/09/08/how-to-deploy-custom-docker-images-for-your-web-crawlers/
#Ref2 - https://github.com/webfp/tor-browser-crawler

#Install the necessary background tools
RUN apt-get update -qq && \
    apt-get install -qy htop iputils-ping lsof ltrace strace telnet vim xorg libxext-dev libxrender-dev libxtst-dev libgtk2.0-dev zenity

#Install the tools needed to run the code
RUN apt-get install -qy python python-pip python-dev tcpdump wireshark Xvfb phantomjs ethtool

#Remove the apt lists
#RUN rm -rf /var/lib/apt/lists/*

#RUN ifconfig eth0 mtu 1500 - Needs privileges, so moved to runtime

#RUN ethtool -K eth0 tx off rx off tso off gso off gro off lro off - Needs privileges, so moved to runtime

COPY ./tor-browser-crawler-webfp-paper /tor

ENV PATH $PATH:/tor/tbb/tor-browser-linux64-6.5.2_en-US/Browser/

RUN pip install pip --upgrade

#Install the required python packages
RUN pip install --no-cache-dir -r /tor/requirements.txt

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/tor/tbb/tor-browser-linux64-6.5.2_en-US/Browser/TorBrowser/Tor/

WORKDIR /tor
#Run the start.sh command
CMD [ "bash", "./start.sh" ]
