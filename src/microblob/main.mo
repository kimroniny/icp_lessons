import List "mo:base/List";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Time "mo:base/Time";

actor {
    public type Message = {
        text: Text; 
        time: Time.Time
        };
    stable var followed: List.List<Principal> = List.nil();
    stable var messages: List.List<Message> = List.nil();

    public type Microblog = actor {
        follow: shared (Principal) -> async();
        follows: shared query () -> async [Principal];
        post: shared (Text) -> async ();
        posts: shared query (since: Time.Time) -> async [Message];
        timeline: shared (since: Time.Time) -> async [Message];
    };

    

    public shared func follow(id : Principal) : async () {
        followed := List.push(id, followed);
    };

    public shared query func follows() : async [Principal] {
        List.toArray(followed)
    };

    public shared (msg) func post(text : Text) : async (Time.Time) {
        assert(Principal.toText(msg.caller) == "rsqv3-7dkj5-yvrcl-l2bkm-vkvuj-tdync-my6md-ob6uj-ah3bu-dpk3x-gqe");
        let now = Time.now();
        let postMsg = {
            text = text; 
            time = now;
            };
        messages := List.push(postMsg, messages);
        now
    };

    public shared query func posts(since: Time.Time) : async [Message] {
        let sinceList = List.filter(
            messages, 
            func(msg: Message) : Bool{
                msg.time > since
            }
        );
        List.toArray(sinceList)
    };

    public shared func timeline(since: Time.Time) : async [Message] {
        var all : List.List<Message> = List.nil();

        for (id in Iter.fromList(followed)) {
            let canister : Microblog = actor(Principal.toText(id));
            let msgs = await canister.posts(since);
            for (msg in Iter.fromArray(msgs)) {
                all := List.push(msg, all)
            }
        };

        List.toArray(all)
    };

}