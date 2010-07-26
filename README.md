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
	    backgroundColor: "#ffffff",
	    primaryTextColor: "#000000",
	    secondaryTextColor: "#000000",
	    refresh: 12.5
	});
	window.add(admob);
	window.open();


INSTALL TiAdMob4iPhone
--------------------

1. Run `build.py` which creates your distribution
2. cd to `/Library/Application Support/Titanium`
3. extract your zip into this folder


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
