# Raku ZAP API module


## Description 
### A Raku module for the OWASP ZAP API.

SYNOPSIS
========

```perl6
    use Zap;
    # Config Zap Client
    ZapConfig(:apikey<apikey12345>,:port<8081>,:addr<127.0.0.1>);
    # send a url to the spider
    my $scanId = Zap::Spider.scan(:url<https://raku.org>)<scan>;
    # get the spider status
    my $status = Zap::Spider.status(:$scanId)<status>;
    # waith for the spider to finish then get the result
    $*OUT = $*OUT.open(:!buffer);
    while Zap::Spider.status(:$scanId)<status> < 100 {
        print "Spider progress {Zap::Spider.status(:$scanId)<status>}  \r";
    }
    $*OUT = $*OUT.open(:buffer);
    put "URL : $_" for Zap::Spider.results(:$scanId)<results>[];
    my @scans = Zap::Spider.scans<scans>[]; # this needs some work
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

* Make the code and API Response more easy to handle
* Write a Script to provide a CLI `raku-zap` maybe ?
* Write an Interface for the zap CLI 
* Automate Spider and Scanners 


## Docs

* [`Zap::Client`](Client/)