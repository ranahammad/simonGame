//
//  FlipsideViewController.h
//  simonGame
//
//  Created by Gobbledygook on 10/23/10.
//  Copyright TelephonyMedia 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
//#import <AVFoundation/AVAudioPlayer.h>

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController {
	id <FlipsideViewControllerDelegate> delegate;
	
	UIImageView *pBackgroundImage;
	UIImageView *pHeaderImage;
	UIButton	*btnTopLeft;
	UIButton	*btnTopRight;
	UIButton	*btnBottomLeft;
	UIButton	*btnBottomRight;
	UILabel		*lblScore;
	
	SystemSoundID idSoundTopLeft;
	SystemSoundID idSoundTopRight;
	SystemSoundID idSoundBottomLeft;
	SystemSoundID idSoundBottomRight;

}

@property (nonatomic, retain) IBOutlet UIImageView	*pBackgroundImage;
@property (nonatomic, retain) IBOutlet UIImageView	*pHeaderImage;
@property (nonatomic, retain) IBOutlet UIButton		*btnTopLeft;
@property (nonatomic, retain) IBOutlet UIButton		*btnTopRight;
@property (nonatomic, retain) IBOutlet UIButton		*btnBottomLeft;
@property (nonatomic, retain) IBOutlet UIButton		*btnBottomRight;
@property (nonatomic, retain) IBOutlet UILabel		*lblScore;


@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (IBAction) endGame;
- (IBAction) topLeftBtnClicked;
- (IBAction) topRightBtnClicked;
- (IBAction) bottomLeftBtnClicked;
- (IBAction) bottomRightBtnClicked;
@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

