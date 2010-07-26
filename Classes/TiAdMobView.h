/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2010 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import "AdMobDelegateProtocol.h"
#import "AdMobView.h"

@interface TiAdMobView : TiUIView<AdMobDelegate> {

@private
	NSTimer *refreshTimer;
	AdMobView* admob;	
	
	// properties
	NSString* publisher;
	BOOL test;
	float refresh;
	UIColor* primaryTextColor;
	UIColor* secondaryTextColor;
	
}
@property (nonatomic, retain) NSString* publisher;
@property (nonatomic, assign) BOOL test;
@property (nonatomic, assign) float refresh;
@property (nonatomic, retain) UIColor* primaryTextColor;
@property (nonatomic, retain) UIColor* secondaryTextColor;

@end
