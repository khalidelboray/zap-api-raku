use Zap;
unit class Zap::Simple;

ZapConfig(:apikey<apikey12345>,:port<8081>,:addr<127.0.0.1>);

has $.Ascan handles (
    :ascan<scan>,
    :ascans<scans>
) = Zap::Ascan.new;
