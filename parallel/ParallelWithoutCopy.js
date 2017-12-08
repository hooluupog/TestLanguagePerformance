// ATTENTION:
// This file will be deprecated once node.js support transferale data.

var Worker = require('webworker-threads').Worker;
var now = require("performance-now");

var LEN = 30000000;
console.log('sum using loop');
var start = now();
console.log(sum(LEN));
var elapsed = now() - start;
console.log('Elapsed time: ' +  elapsed.toFixed(3) + 'ms');

console.log('sum using parallel');
var N = 4;  
var offset = LEN / N;
res = 0;
var count = 0;
start = now();
for(var i = 0;i < N;i++){
    var w =new Worker(psum);
    w.postMessage([i*offset,i*offset+offset]);
    w.onmessage = function (event) {
        res += event.data;
        count++;
        if(count == N){
            elapsed = now() - start;
            console.log(res);
            console.log('Elapsed time: ' +  elapsed.toFixed(3) + 'ms');
        }
    };
}

function sum(len){
    var res = 0;
    for(var i = 0;i < len;i++){
        if(i % 2 == 0) res += i;
    }
    return res;
}

function psum() {
    this.onmessage = function(e){
        var start = e.data[0],end = e.data[1];
        res = 0;
        for(var i = start;i < end;i++){
            if (i % 2 == 0) res += i;
        }
        postMessage(res);
        close();
    };
}
