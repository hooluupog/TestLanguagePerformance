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
for (var i = 0; i < 30000000; i++) {
    view.push(i);
}

console.log('sum using loop');
var start = now();
console.log(sum(view));
var elapsed = now() - start;
console.log('Elapsed time: ' +  elapsed.toFixed(3) + 'ms');

console.log('sum using filter reduce');
start = now();
var res = view.filter(function(i){return i % 2 == 0;}).
    reduce(function(a,b){return a + b;},0);
console.log(res);
elapsed = now() - start;
console.log('Elapsed time: ' +  elapsed.toFixed(3) + 'ms');

console.log('sum using parallel');
var N = 3;  
var offset = view.length / N;
res = 0;
var count = 0;
start = now();
for(var i = 0;i < N;i++){
    var w =new Worker(psum);
    w.postMessage(view.slice(i*offset,i*offset+offset));
    // transerable:ON
    //var subBuffer = view.slice(i*offset,i*offset+offset).buffer;
    //w.postMessage(subBuffer,[subBuffer]);
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

function sum(array){
    var res = 0;
    for(var i = 0;i < array.length;i++){
        if(array[i] % 2 == 0) res += array[i];
    }
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
