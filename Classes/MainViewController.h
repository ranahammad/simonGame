//
//  MainViewController.h
//  simonGame
//
//  Created by Gobbledygook on 10/23/10.
//  Copyright TelephonyMedia 2010. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> 
{
	UIImageView *pBackgroundImage;
}

@property (nonatomic, retain) IBOutlet 	UIImageView *pBackgroundImage;
- (IBAction)startGameClicked;

@end
