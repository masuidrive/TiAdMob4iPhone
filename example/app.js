// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var window = Ti.UI.createWindow({
  backgroundColor: '#0000ff'
});

var Ad = require('Ad');
var admob = Ad.createAdMob({
    publisher: "Your ID", // required
    width: 320, // required
    height: 48, // required
    adBackgroundColor: "#ffffff",
    primaryTextColor: "#000000",
    secondaryTextColor: "#000000",
    refresh: 12.5
});
admob.addEventListener('error', function(error) {
    alert(error.message);
    window.remove(admob);
});

window.add(admob);
window.open();
