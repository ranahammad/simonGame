//
//  simonGameAppDelegate.h
//  simonGame
//
//  Created by Gobbledygook on 10/23/10.
//  Copyright TelephonyMedia 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface simonGameAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;

@end

