import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";
import Int "mo:base/Bool";
import Nat "mo:base/Nat";

actor {
    func partition(arr: [var Int], i: Nat, j: Nat): Nat{
        let x = arr[i];
        let p = i;
        var loopi = p+1;
        var loopj = j;
        while (loopi <= loopj) {
            if (arr[loopi] >= x) {
                let t = arr[loopi]; arr[loopi] := arr[loopj]; arr[loopj] := t;
                loopj -= 1;
            } else {loopi += 1};
        };
        let t = arr[p]; arr[p] := arr[loopj]; arr[loopj] := t;
        return loopj;
    };

    func qsortreal(arr: [var Int], l: Nat, r: Nat) {
        if (l < r) {
            var x = partition(arr, l, r);
            if (x > 0) qsortreal(arr, l, x-1);
            if (x < arr.size()-1)qsortreal(arr, x+1, r);
        };
    };

    public func qsort(arr: [Int]): async [Int] {
        var arr2: [var Int] = Array.init<Int>(arr.size(), 0);
        for (j in Iter.range(0, arr.size()-1)) {
            arr2[j] := arr[j];
        };
        qsortreal(arr2, 0, arr2.size()-1);
        let arr3 : [Int] = Array.tabulate<Int>(arr2.size(), func(i:Nat) : Int {arr2[i]}) ;
        arr3;
    };
}