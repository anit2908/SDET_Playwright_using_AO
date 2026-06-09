

function GetuserStatus(){

console.log(statuscode)
var statuscode = " 200OK"; // cannot use let as status code is not initialized first so Var is used
console.log(statuscode)

}

GetuserStatus();

// Note: var is function-scoped, so status is hoisted to
// the top of getUserStatus(), NOT the global scope.