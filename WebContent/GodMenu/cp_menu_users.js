var tds = document.getElementsByTagName('td');
var column = [];
for (var i=0; i<tds.length; i++) {
    if (tds[i].innerHTML.match("Admin")) {
       tds[i].innerHTML.bgcolor = "Yellow";
    }
}