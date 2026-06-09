//Var can be reassinged and redeclared

var a = 10;
console.log (a);

var a = 20;
console.log (a);

function printHello() {
    console.log("Hello TheTestingAcademy!");
    var a = 20; // Local Scope
    console.log(a);
    if (true) {
        var a = 30;
        console.log(a); // 30
    }

}
printHello();