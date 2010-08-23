/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "JpMasuidriveTiAdmobModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"

#import "AdMobView.h"
#import "TiAdMobViewProxy.h"

@implementation JpMasuidriveTiAdmobModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"b409ac9d-8f54-4625-b3c8-d113a4b2e3f5";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"jp.masuidrive.ti.admob";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma Public APIs

-(id)createAdMob:(id)args
{
	ENSURE_SINGLE_ARG_OR_NIL(args, NSDictionary);
	NSDictionary* dict = args ? args : [NSDictionary dictionary];
	return [[[TiAdMobViewProxy alloc] _initWithPageContext:[self pageContext] args:[NSArray arrayWithObject:dict]] autorelease];
}

@end
