use Cro::HTTP::Client;
unit class Zap::Client;

has $.addr is rw = "127.0.0.1";
has $.port is rw = "8080";
has $.format = "JSON";
has $.apikey is required("Provide an api key plz") is rw;
has $.client = Cro::HTTP::Client.new(
        base-uri => "http://$!addr:$!port",
        headers => [
            Accept => "application/json",
        ]
        );



# To validate the format
subset FORMAT of Str where *.uc eq any("JSON", "XML", "HTML", "OTHER");

# To validate the operation
subset PATH of Str where *.split('/', :skip-empty)[1] eq any('view', 'action', 'other');

method request(PATH $path is copy,Cool $query = {},FORMAT :$format = $!format) {
    $query<apikey> = $!apikey;
    $path = "/$format/" ~ $path;
    my $resp = await  $!client.get: $path, :$query;
    CATCH {
        when X::Cro::HTTP::Error {
            die "Unexpected error While Requesting [ '{ .request.target }' ] \n\n $_";
        }

    }
    given $format {
        when 'JSON' {
            return (await $resp.body).values[0]<>;
        }
        default {
            return await $resp.body-text;
        }
    }

}