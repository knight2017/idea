var isEven = function (x) { return x % 2 == 0; };



var filter = function(arr, fn){
    var temp =[]
    for(x in arr ){
      if(fn(arr[x])) {
       temp.push(arr[x])
      }
    }
   return temp
}

console.log(filter([1, 2, 3, 4], isEven));
 // => [2, 4]
