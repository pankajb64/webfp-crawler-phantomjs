# webfp-crawler-phantomjs

**Update - the repo has been modified since the first release to facilitate my work. If you want the phantomjs related code, check the release v1.0 [here](https://github.com/pankajb64/webfp-crawler-phantomjs/releases/tag/release-v1.0)**

A python crawler for crawling Tor and collect network traces using wireshark. Used to create dataset for testing Website Fingerprinting (WF) attacks on Tor.

Ref - M. Juarez, S. Afroz, G. Acar, C. Diaz, R. Greenstadt, “A Critical Analysis of Website Fingerprinting Attacks”, in the proceedings of the ACM Conference on Computer and Communications Security (CCS), pp. 263-274, ACM, 2014. http://www1.icsi.berkeley.edu/~sadia/papers/ccs-webfp-final.pdf

Source taken from the release version of https://github.com/webfp/tor-browser-crawler (see https://github.com/webfp/tor-browser-crawler/releases/tag/webfp-paper)

**Adapted to use phantomjs instead of firefox, so it can run on a headless linux server.**

It is best to run the code in a container like docker. A docker file is provided, and a docker image is available at https://hub.docker.com/r/pankajb64/webfp-crawler-phantomjs/ **The docker image needs to be run in privileged mode as it modifies local network interface settings.**

Source code is available under the same license (GPL2) as it was originally published.

**Tested on Ubuntu 14.04 and Python 2.7**

The contents below are taken from the original README at https://github.com/webfp/tor-browser-crawler/blob/master/README.md

Requirements
---------------
* Linux packages: ```python tcpdump wireshark Xvfb```
* Python packages: ```selenium requests stem psutil(version < 3) tld xvfbwrapper scapy```

# Getting started

### 1. Configure the environment

* We recommend running crawls in a VM or a container (e.g. LXC) to avoid perturbations introduced by the background network traffic and system level network settings. Please note that the crawler will not only store the Tor traffic but will capture all the network traffic generated during a visit to a website. That’s why it’s extremely important to disable all the automatic/background network traffic such as the auto-updates. See, for example the [instructions for disabling automatic connections for Ubuntu](https://help.ubuntu.com/community/AutomaticConnections).

* You’ll need to set capture capabilities to your user: `sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap`

* [Download the TBB](https://www.torproject.org/download/download.html.en) and extract it to `./tbb/tor-browser-linux<arch>-<version>_<locale>/`.

* You might want to change the MTU of your network interface and disable NIC offloads that might make the traffic collected by tcpdump look different from how it would have been seen on the wire.

 * Change MTU to standard ethernet MTU (1500 bytes): `sudo ifconfig <interface> mtu 1500`

 * Disable offloads: `sudo ethtool -K <interface> tx off rx off tso off gso off gro off lro off`

 * See the [Wireshark Offloading page](https://wiki.wireshark.org/CaptureSetup/Offloading) for more info.



### 2. Run a crawl with the defaults

```
python main.py -u ./etc/localized-urls-100-top.csv -e wang_and_goldberg
```

To get all the available command line parameters and the usage run:

```
python main.py --help
```

### 3. Check out the results

The collected data can be found in the `results` folder:

    * Pcaps: `./results/latest`
    * Logs: `./results/latest_crawl_log`


Sample crawl data
-------------
You can download a sample of data collected using this crawler with the configuration used by Wang and Goldberg in their WPES'13 paper (namely 10 batches, 100 pages and 4 instances per page) from here:

* [Crawl `140203_042843`](https://mega.co.nz/#!ekIXBTbZ!1bn7zSPuV5r8fS0zpp2hrMvNc4Xrj6F2oUbjlyBb87o)
(SHA256: 06a007a41ca83bd24ad3f7e9f5e8f881bd81111a547cbfcf20f057be1b89d0dd)

The crawl names include a timestamp. The list of crawls used in our study can be found in the appendix of the paper [1].


Notes
-------
* Tested on *Xubuntu 14.04* and *Debian 7.8*.


References
-------------

[1] M. Juarez, S. Afroz, G. Acar, C. Diaz, R. Greenstadt, “A Critical Analysis of Website Fingerprinting Attacks”, in the proceedings of the ACM Conference on Computer and Communications Security (CCS), pp. 263-274, ACM, 2014.

[2] T. Wang and I. Goldberg. “Improved Website Fingerprinting on Tor”, in the proceedings of the ACM Workshop on Privacy in the Electronic Society (WPES), pp. 201–212. ACM, 2013.
