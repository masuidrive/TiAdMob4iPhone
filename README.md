TiAdMob4iPhone
===========================================

This is a AdMob integration module for Titanium Mobile iPhone.



HOW TO USE IT
-----------------------------

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


INSTALL TiAdMob4iPhone
--------------------

1. Open `Terminal`
2. Run below command

	`python build.py && unzip ad-iphone-0.1.zip -d /Library/Application\ Support/Titanium/`


REGISTER TO YOUR PROJECT
---------------------

Register your module with your application by editing `tiapp.xml` and adding your module.
Example:

	<modules>
		<module version="0.1">Ad</module>
	</modules>

When you run your project, the compiler will know automatically compile in your module
dependencies and copy appropriate image assets into the application.


LICENSE
---------------------
MIT License

Copyright 2010 Yuichiro MASUI (masuidrive)
