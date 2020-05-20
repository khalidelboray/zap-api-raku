# class `Zap::Client`

-------------------


# Basic Construction

```perl6
    use Zap::Client;
    
    my $client = Zap::Client.new: :port(8081) #`( defaults to 8080 ) ,
                                  :addr<192.168.1.120> #`( defaults to 127.0.0.1 ) ,
                                  :format<XML> #`( Response Format -  defaults to JSON ) ,
                                  :apikey<apikey123> ; # required
    
```

## Attributes 
* ## port
    > the port which ZAP API is on
* ## addr
    > the host/addr ip which ZAP API is on
* ## format
    > the format that the api should return, defaults to JSON.
    
    > can also be changed while using `.request` method  

# Sending requests

```perl6
    my $res = $client.request('spider/view/fullResults',{scanId => 1});
    
    # $res is a raw xml Str                               
    # if the format is set to json , the response will be parsed by
    # the client which uses JSON::fast
    
    $res = $client.request('spider/view/fullResults',{scanId => 1},:format<JSON>);
```