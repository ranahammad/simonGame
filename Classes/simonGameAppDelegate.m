//
//  simonGameAppDelegate.m
//  simonGame
//
//  Created by Gobbledygook on 10/23/10.
//  Copyright TelephonyMedia 2010. All rights reserved.
//

#import "simonGameAppDelegate.h"
#import "MainViewController.h"

@implementation simonGameAppDelegate


@synthesize window;
@synthesize mainViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
	[aController release];
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [mainViewController release];
    [window release];
    [super dealloc];
}

@end
