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
@synthesize publisher, test, refresh, primaryTextColor, secondaryTextColor;


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


#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"failed"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"failed"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}


#pragma Internal


#pragma Delegates
-(void)initializeState
{
	[super initializeState];
	self.backgroundColor = [UIColor clearColor];
	self.primaryTextColor = [UIColor blackColor];
	self.secondaryTextColor = [UIColor blackColor];
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
	return self.backgroundColor;
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
