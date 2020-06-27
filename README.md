[OWASP ZAP API](https://www.zaproxy.org/docs/api/) Raku module
==============================================================

SYNOPSIS
========

## `Zap`

```perl6
use lib 'lib';
use Zap;
# Config Zap Client
ZapConfig(:apikey<apikey12345>,:port<8081>,:addr<127.0.0.1>);
# send a url to the spider
my $scanId = Zap::Spider.scan(:url<https://perl.org>);
# get the spider status
my $status = Zap::Spider.status(:$scanId);
# wait for the spider to finish then get the result
$*OUT = $*OUT.open(:!buffer);
while Zap::Spider.status(:$scanId) < 100 {
    print "Spider progress {Zap::Spider.status(:$scanId)}  \r";
}
$*OUT = $*OUT.open(:buffer);
put "URL : $_" for Zap::Spider.results(:$scanId);
my @scans = Zap::Spider.scans; # this needs some work
put "ID , Progress , State";
for @scans -> %scan {
    put %scan<id progress state>.fmt("%s",', ')
}

```
Installation
============

`zef install Zap`

TODO
====

* Documentation and documentation
* Make the code and API Response more easy to handle
* Write a Script to provide a CLI `raku-zap` maybe ?
* Write an Interface for the zap CLI 
* Automate Spider and Scanners 
* Since we are using Cro::HTTP::Client , we can handel the other response formats with `body-parsers` (a `Cro::HTTP::BodyParser` class)