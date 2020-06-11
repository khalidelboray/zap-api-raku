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
