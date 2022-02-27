
actor counter{

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
}