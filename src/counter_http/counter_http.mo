import Int "mo:base/Nat";
import Text "mo:base/Text";
actor CounterHttp {
    public type HeaderField = (Text, Text);
    public type HttpRequest = {
        url : Text;
        method : Text;
        body : [Nat8];
        headers : [HeaderField];
    };
    public type HttpResponse = {
        body : Blob;
        headers : [HeaderField];
        streaming_strategy : ?StreamingStrategy;
        status_code : Nat16;
    };
    public type Key = Text;
    public type StreamingCallbackHttpResponse = {
        token : ?StreamingCallbackToken;
        body : [Nat8];
    };
    public type StreamingCallbackToken = {
        key : Key;
        sha256 : ?[Nat8];
        index : Nat;
        content_encoding : Text;
    };
    public type StreamingStrategy = {
        #Callback : {
        token : StreamingCallbackToken;
        callback : shared query StreamingCallbackToken -> async ?StreamingCallbackHttpResponse;
        };
    };
    stable var countVal: Nat = 0;

    public func increment(): async (){
        countVal += 1;
    };

    public query func get(): async Nat {
        countVal;
    };

    public func set(x:Nat): async () {
        countVal := x;
    };
    
    public shared query func http_request(request: HttpRequest): async HttpResponse {
        {
            body = Text.encodeUtf8("the counter value is: "#Int.toText(countVal));
            headers = [];
            streaming_strategy = null;
            status_code = 200;
        }
    }
}