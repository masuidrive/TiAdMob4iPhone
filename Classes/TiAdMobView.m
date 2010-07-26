/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2010 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiAdMobView.h"
#import "TiUtils.h"
#import "TiApp.h"

#define AD_REFRESH_PERIOD 12.5 // display fresh ads every 12.5 seconds


@implementation TiAdMobView

-(void)dealloc
{
	RELEASE_TO_NIL(refreshTimer);
	RELEASE_TO_NIL(admob);
	RELEASE_TO_NIL(view);
	[super dealloc];
}

-(AdMobView*)admob
{
	NSLog(@"admob");
	if (admob==nil)
	{
        admob = [[AdMobView requestAdOfSize:ADMOB_SIZE_320x48 withDelegate:self] retain];
        [self addSubview:admob];
	}
	return admob;
}


-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
	NSLog(@"frameSizeChanged:%f,%f", bounds.size.width, bounds.size.height);
	self.admob.frame = bounds;
}

- (NSString *)publisherIdForAd:(AdMobView *)adView {
	NSLog(@"publisherIdForAd");
	return @"XXXXXXXXXXX"; // this should be prefilled; if not, get it from www.admob.com
}

- (UIViewController *)currentViewControllerForAd:(AdMobView *)adView {
	UIViewController *controller = [[TiApp app] controller];
	NSLog(@"current=%@", controller);
	return controller;
	//	return nil;
}
- (void)refreshAd:(NSTimer *)timer {
	[admob requestFreshAd];
}

- (UIColor *)adBackgroundColorForAd:(AdMobView *)adView {
	return [UIColor colorWithRed:0 green:0 blue:0 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (UIColor *)primaryTextColorForAd:(AdMobView *)adView {
	return [UIColor colorWithRed:1 green:1 blue:1 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (UIColor *)secondaryTextColorForAd:(AdMobView *)adView {
	return [UIColor colorWithRed:1 green:1 blue:1 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

// Sent when an ad request loaded an ad; this is a good opportunity to attach
// the ad view to the hierachy.
- (void)didReceiveAd:(AdMobView *)adView {
	NSLog(@"AdMob: Did receive ad");
	// get the view frame
	// put the ad at the bottom of the screen
	admob.frame = CGRectMake(0, 0, 320, 48);
	
	//[view addSubview:adMobAd];
	[refreshTimer invalidate];
	refreshTimer = [NSTimer scheduledTimerWithTimeInterval:AD_REFRESH_PERIOD target:self selector:@selector(refreshAd:) userInfo:nil repeats:YES];
}

// Sent when an ad request failed to load an ad
- (void)didFailToReceiveAd:(AdMobView *)adView {
	NSLog(@"AdMob: Did fail to receive ad");
	//[adMobAd removeFromSuperview];  // Not necessary since never added to a view, but doesn't hurt and is good practice
	//[adMobAd release];
	//adMobAd = nil;
	// we could start a new ad request here, but in the interests of the user's battery life, let's not
}


- (BOOL)useTestAd {
	NSLog(@"useTestAd");
	return YES;
}

@end
