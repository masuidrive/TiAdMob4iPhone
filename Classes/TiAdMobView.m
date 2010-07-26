/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2010 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiAdMobView.h"
#import "TiUtils.h"
#import "TiApp.h"
#import "Webcolor.h"

#define AD_REFRESH_PERIOD 12.5 // display fresh ads every 12.5 seconds


@implementation TiAdMobView
@synthesize publisher, test, refresh, adBackgroundColor, primaryTextColor, secondaryTextColor;


#pragma mark Cleanup 

-(void)dealloc
{
	NSLog(@"ad>dealloc");
	self.publisher = nil;
	self.backgroundColor = nil;
	self.primaryTextColor = nil;
	self.secondaryTextColor = nil;
	
	RELEASE_TO_NIL(refreshTimer);
	RELEASE_TO_NIL(admob);
	[super dealloc];
}


#pragma Internal


#pragma Delegates
-(void)initializeState
{
	[super initializeState];
	self.adBackgroundColor = [UIColor blackColor];
	self.primaryTextColor = [UIColor whiteColor];
	self.secondaryTextColor = [UIColor whiteColor];
	self.test = NO;
	self.publisher = @"";
	self.refresh = AD_REFRESH_PERIOD;
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
	if (admob==nil)
	{
        admob = [[AdMobView requestAdOfSize:bounds.size withDelegate:self] retain];
        [self addSubview:admob];
	}
	admob.frame = bounds;
}

- (NSString *)publisherIdForAd:(AdMobView *)adView {
	return self.publisher;
}

- (UIViewController *)currentViewControllerForAd:(AdMobView *)adView {
	return [[TiApp app] controller];
}

- (UIColor *)adBackgroundColorForAd:(AdMobView *)adView {
	return self.adBackgroundColor;
}

- (UIColor *)primaryTextColorForAd:(AdMobView *)adView {
	return self.primaryTextColor;
}

- (UIColor *)secondaryTextColorForAd:(AdMobView *)adView {
	return self.secondaryTextColor;
}

- (BOOL)useTestAd {
	return test;
}

- (void)refreshAd:(NSTimer *)timer {
	[admob requestFreshAd];
}

- (void)didReceiveAd:(AdMobView *)adView {
	[refreshTimer invalidate];
	refreshTimer = [NSTimer scheduledTimerWithTimeInterval:(refresh > AD_REFRESH_PERIOD ? refresh : AD_REFRESH_PERIOD)
													target:self
												  selector:@selector(refreshAd:)
												  userInfo:nil
												   repeats:YES];
}

- (void)didFailToReceiveAd:(AdMobView *)adView {
	if ([self.proxy _hasListeners:@"error"])
	{
		NSDictionary* error = [NSDictionary dictionaryWithObjectsAndKeys: @"Did fail to receive ad" ,@"message", nil];
		[self.proxy fireEvent:@"error" withObject:error];
	}
}

#pragma Properties

-(void)setPublisher_:(id)publisher_
{
	self.publisher = [TiUtils stringValue:publisher_];
}

-(void)setTest_:(id)test_
{
	self.test = [TiUtils boolValue:test_];
}

-(void)setRefresh_:(id)refresh_
{
	self.refresh = [TiUtils floatValue:refresh_];
}

-(void)setAdBackgroundColor_:(id)color
{
	if ([color isKindOfClass:[UIColor class]])
	{
		self.adBackgroundColor = color;
	}
	else
	{
		TiColor *ticolor = [TiUtils colorValue:color];
		self.adBackgroundColor = [ticolor _color];
	}
}

-(void)setPrimaryTextColor_:(id)color
{
	if ([color isKindOfClass:[UIColor class]])
	{
		self.primaryTextColor = color;
	}
	else
	{
		TiColor *ticolor = [TiUtils colorValue:color];
		self.primaryTextColor = [ticolor _color];
	}
}

-(void)setSecondaryTextColor_:(id)color
{
	if ([color isKindOfClass:[UIColor class]])
	{
		self.secondaryTextColor = color;
	}
	else
	{
		TiColor *ticolor = [TiUtils colorValue:color];
		self.secondaryTextColor = [ticolor _color];
	}
}

#pragma Public APIs

@end
