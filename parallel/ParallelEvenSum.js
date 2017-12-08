var Worker = require('webworker-threads').Worker;
var now = require("performance-now");

// WAITTING FOR UPDATE AND IMPLEMENTATION.
// ArrayBuffer is not accessible to a worker at present
// issue #18 https://github.com/audreyt/node-webworker-threads/issues/18 
/*var b = new Buffer(1024*1024*32);
var arrayBuffer = b.buffer.slice(b.byteOffset,b.byteOffset + b.byteLength);
var view = new Uint8Array(arrayBuffer);
for (var i = 0; i < view.length; i++) {
    view[i] = i;
}*/
var view = [];
var result;

for (var i = 0; i < 30000000; i++) {
    view.push(i);
}

measure('sum using loop',function(){sum(view);});
measure('sum using filter reduce',function(){
var res = view.filter(function(i){return i % 2 == 0;}).
    reduce(function(a,b){return a + b;},0);
    result = res;
});

var N = 3;  
var offset = view.length / N;
res = 0;
var count = 0;
start = now();
for(var i = 0;i < N;i++){
    var w =new Worker(psum);
    // slice will do a shallow copy of origin array.
    w.postMessage(view.slice(i*offset,i*offset+offset));
    // transerable:ON
    //var subBuffer = view.slice(i*offset,i*offset+offset).buffer;
    //w.postMessage(subBuffer,[subBuffer]);
    w.onmessage = function (event) {
        res += event.data;
        count++;
        if(count == N){
            elapsed = now() - start;
            result = res;
            console.log('sum using parallel: ' +  elapsed.toFixed(3) + 'ms');
        }
    };
}

function sum(array){
    var res = 0;
    for(var i = 0;i < array.length;i++){
        if(array[i] % 2 == 0) res += array[i];
    }
    result = res;
    return res;
}

function psum() {
    this.onmessage = function(e){
        /*var b = e.data;
        var view = new Uint8Array(b.buffer,b.byteOffset, b.byteLength / Uint8Array.BYTES_PER_ELEMENT);
        //console.log(view.length);*/
        var view = e.data;
        res = 0;
        for(var i = 0;i < view.length;i++){
            if (view[i] % 2 == 0) res += view[i];
        }
        postMessage(res);
        close();
    };
}

function measure(text,f){
    var start = now();
    f();
    var elapsed = now() - start;
    console.log(text + ': ' +  elapsed.toFixed(3) + 'ms');
}
