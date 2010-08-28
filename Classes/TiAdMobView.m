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
@synthesize refreshTimer, admob;

#pragma mark Cleanup 

-(void)dealloc
{
	self.publisher = nil;
	self.backgroundColor = nil;
	self.primaryTextColor = nil;
	self.secondaryTextColor = nil;
	[refreshTimer invalidate];
	self.refreshTimer = nil;
	self.admob = nil;
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
        self.admob = [AdMobView requestAdOfSize:CGSizeMake(width, height) withDelegate:self];
        [self addSubview:admob];
	}
	admob.frame = CGRectMake(0, 0, width, height);
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
	self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:(refresh > AD_REFRESH_PERIOD ? refresh : AD_REFRESH_PERIOD)
													target:self
												  selector:@selector(refreshAd:)
												  userInfo:nil
												   repeats:YES];
}

- (void)didFailToReceiveAd:(AdMobView *)adView {
	[refreshTimer invalidate];
	if ([self.proxy _hasListeners:@"error"])
	{
		NSDictionary* error = [NSDictionary dictionaryWithObjectsAndKeys: @"Did fail to receive ad" ,@"message", nil];
		[self.proxy fireEvent:@"error" withObject:error];
	}
}

- (UIColor*)colorValue:(id)color_
{
	UIColor* color = color_;
	if (![color isKindOfClass:[UIColor class]]) {
		color = [[TiUtils colorValue:color] _color];
	}
	if([color isEqual:[UIColor blackColor]]) {
		color = RGBACOLOR(0.0, 0.0, 0.0, 1.0);
	}
	if([color isEqual:[UIColor whiteColor]]) {
		color = RGBACOLOR(255.0, 255.0, 255.0, 1.0);
	}
	return color;
}

#pragma Properties

-(void)setHeight_:(id)height_
{
	height = [TiUtils floatValue:height_];
}

-(void)setWidth_:(id)width_
{
	width = [TiUtils floatValue:width_];
}

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
	self.adBackgroundColor = [self colorValue:color];
}

-(void)setPrimaryTextColor_:(id)color
{
	self.primaryTextColor = [self colorValue:color];
}

-(void)setSecondaryTextColor_:(id)color
{
	self.secondaryTextColor = [self colorValue:color];
}

#pragma Public APIs

@end
