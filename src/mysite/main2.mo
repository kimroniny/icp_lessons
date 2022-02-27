import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Int "mo:base/Bool";
import Nat "mo:base/Nat";

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
        qsortreal(arr, x+1, r);
    };
};

func quicksort(arr: [var Int]) {
    qsortreal(arr, 0, arr.size()-1);
};

let a = [var 3:Int,1:Int, 0];
quicksort(a);
var i = 0;
while ( i < a.size()) {
    Debug.print(debug_show(a[i]));
    i += 1;
};
