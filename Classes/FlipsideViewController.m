//
//  FlipsideViewController.m
//  simonGame
//
//  Created by Gobbledygook on 10/23/10.
//  Copyright TelephonyMedia 2010. All rights reserved.
//

#import "FlipsideViewController.h"
#import "simongameConstants.h"

@interface FlipsideViewController (private)

// private properties, normally for simon game implementation

// Objects
NSMutableArray *pSequenceArray;
BOOL			bGeneratingSequence;
NSInteger		iCurrentIndex;

UIImage *pListenImage;
UIImage *pRepeatImage;
UIImage *pCorrectImage;
UIImage *pWrongImage;

@end



@implementation FlipsideViewController

@synthesize delegate;
@synthesize pBackgroundImage;
@synthesize pHeaderImage;
@synthesize btnTopLeft;
@synthesize btnTopRight;
@synthesize btnBottomLeft;
@synthesize btnBottomRight;
@synthesize lblScore;


-(void) highlightButton:(int) iIndex
{
	
	[btnTopLeft setSelected:FALSE];
	[btnTopRight setSelected:FALSE];
	[btnBottomLeft setSelected:FALSE];
	[btnBottomRight setSelected:FALSE];
	
	switch (iIndex) {
		case 0:
			[btnTopLeft setSelected:TRUE];
			AudioServicesPlaySystemSound(idSoundTopLeft);
			break;
		case 1:
			[btnTopRight setSelected:TRUE];
			AudioServicesPlaySystemSound(idSoundTopRight);
			break;
		case 2:
			[btnBottomLeft setSelected:TRUE];
			AudioServicesPlaySystemSound(idSoundBottomLeft);
			break;
		case 3:
			[btnBottomRight setSelected:TRUE];
			AudioServicesPlaySystemSound(idSoundBottomRight);
			break;
	}
}

-(void) showSequence
{
	if(iCurrentIndex == [pSequenceArray count])
	{
		iCurrentIndex = 0;
		
		bGeneratingSequence = FALSE;
		[btnTopLeft setSelected:FALSE];
		[btnTopRight setSelected:FALSE];
		[btnBottomLeft setSelected:FALSE];
		[btnBottomRight setSelected:FALSE];
		
		[pHeaderImage setImage:pRepeatImage];
		return;
	}
	int iValue = [[pSequenceArray objectAtIndex:iCurrentIndex] intValue];
	
	// highlight the cornor indicated by iValue
	
//	[self showHighlightYellowAtCornor:iValue andHide:TRUE];

	[self highlightButton:iValue];
	
	iCurrentIndex++;
	[NSTimer scheduledTimerWithTimeInterval:0.5 
									 target:self 
								   selector:@selector(showSequence)
								   userInfo:nil
									repeats:NO];
}

-(void) growSequence
{
	[pHeaderImage setImage:pListenImage];
	
	[lblScore setText:[NSString stringWithFormat:@"%d",[pSequenceArray count] * 10]];
	
	bGeneratingSequence = TRUE;
	iCurrentIndex = 0;
	
	int iPrevVal = -1;
	
	if([pSequenceArray count]>0)
	{
		iPrevVal = [((NSString*)[pSequenceArray objectAtIndex:[pSequenceArray count] -1]) intValue];
	}
	
	int iRandomVal = arc4random()%4;
	if(iPrevVal == iRandomVal)
	{
		iRandomVal = 3 - iPrevVal;
		
	}
	
	NSString *strVal = [[NSString alloc] initWithFormat:@"%d",iRandomVal];
	[pSequenceArray addObject:strVal];
	[strVal release];
	
	//[pSelectedImageView setUserInteractionEnabled:FALSE];
	[NSTimer scheduledTimerWithTimeInterval:0.75 
									 target:self 
								   selector:@selector(showSequence) 
								   userInfo:nil 
									repeats:NO];		
}

- (void) startGame
{
	[self growSequence];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];

    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
	
	[pBackgroundImage setImage:[UIImage imageNamed:BackgroundImage_GameView]];
	
	[btnTopLeft setImage:[UIImage imageNamed:NormalImage_TopLeftButton] forState:UIControlStateNormal];
	[btnTopLeft	setImage:[UIImage imageNamed:SelectedImage_TopLeftButton] forState:UIControlStateHighlighted];
	[btnTopLeft	setImage:[UIImage imageNamed:SelectedImage_TopLeftButton] forState:UIControlStateSelected];	
	
	[btnTopRight setImage:[UIImage imageNamed:NormalImage_TopRightButton] forState:UIControlStateNormal];
	[btnTopRight setImage:[UIImage imageNamed:SelectedImage_TopRightButton] forState:UIControlStateHighlighted];
	[btnTopRight setImage:[UIImage imageNamed:SelectedImage_TopRightButton] forState:UIControlStateSelected];	

	[btnBottomLeft setImage:[UIImage imageNamed:NormalImage_BottomLeftButton] forState:UIControlStateNormal];
	[btnBottomLeft	setImage:[UIImage imageNamed:SelectedImage_BottomLeftButton] forState:UIControlStateHighlighted];
	[btnBottomLeft	setImage:[UIImage imageNamed:SelectedImage_BottomLeftButton] forState:UIControlStateSelected];	

	[btnBottomRight setImage:[UIImage imageNamed:NormalImage_BottomRightButton] forState:UIControlStateNormal];
	[btnBottomRight	setImage:[UIImage imageNamed:SelectedImage_BottomRightButton] forState:UIControlStateHighlighted];
	[btnBottomRight	setImage:[UIImage imageNamed:SelectedImage_BottomRightButton] forState:UIControlStateSelected];	

	[lblScore setCenter:CGPointMake(xPosition_Score, yPosition_Score)];
	
	pListenImage = [UIImage imageNamed:ListenImage_Header];
	pRepeatImage = [UIImage imageNamed:RepeatImage_Header];
	pCorrectImage = [UIImage imageNamed:CorrectImage_Header];
	pWrongImage = [UIImage imageNamed:WrongImage_Header];
	
	
	NSString *file = [[NSBundle mainBundle] pathForResource:SoundFilePath_TopLeftButton 
													 ofType:SoundFileType_TopLeftButton];	
	AudioServicesCreateSystemSoundID( ((CFURLRef) [NSURL fileURLWithPath:file]), &idSoundTopLeft);
	
	file = [[NSBundle mainBundle] pathForResource:SoundFilePath_TopRightButton 
										   ofType:SoundFileType_TopRightButton];	
	AudioServicesCreateSystemSoundID( ((CFURLRef) [NSURL fileURLWithPath:file]), &idSoundTopRight);

	file = [[NSBundle mainBundle] pathForResource:SoundFilePath_BottomLeftButton 
										   ofType:SoundFileType_BottomLeftButton];	
	AudioServicesCreateSystemSoundID( ((CFURLRef) [NSURL fileURLWithPath:file]), &idSoundBottomLeft);

	file = [[NSBundle mainBundle] pathForResource:SoundFilePath_BottomRightButton 
										   ofType:SoundFileType_BottomRightButton];	
	AudioServicesCreateSystemSoundID( ((CFURLRef) [NSURL fileURLWithPath:file]), &idSoundBottomRight);
	
	pSequenceArray = [[NSMutableArray alloc] init];

	[self startGame];
}

- (IBAction) endGame
{
	if(bGeneratingSequence)
		return;
	
	[self dismissModalViewControllerAnimated:YES];
}


-(void) detectValue:(int) iIndex
{
	int iValue = [[pSequenceArray objectAtIndex:iCurrentIndex] intValue];

	if(iValue == iIndex)
	{
		iCurrentIndex++;
		if(iCurrentIndex == [pSequenceArray count])
		{
			[pHeaderImage setImage:pCorrectImage];
			
			// sequence is complete
			[NSTimer scheduledTimerWithTimeInterval:0.5
											 target:self 
										   selector:@selector(growSequence) 
										   userInfo:nil 
											repeats:NO];
			
		}
	}
	else {
		[pHeaderImage setImage:pWrongImage];
		[pSequenceArray removeAllObjects];
		[NSTimer scheduledTimerWithTimeInterval:1.0
										 target:self 
									   selector:@selector(growSequence) 
									   userInfo:nil 
										repeats:NO];
	}

}

- (IBAction) topLeftBtnClicked
{
	if(bGeneratingSequence)
		return;
	// show selected state and play audio
	// stay selected until audio finishes
	AudioServicesPlaySystemSound(idSoundTopLeft);
	[self detectValue:0];
}

- (IBAction) topRightBtnClicked
{
	if(bGeneratingSequence)
		return;

	AudioServicesPlaySystemSound(idSoundTopRight);

	[self detectValue:1];
}

- (IBAction) bottomLeftBtnClicked
{
	if(bGeneratingSequence)
		return;

	AudioServicesPlaySystemSound(idSoundBottomLeft);
	[self detectValue:2];
}

- (IBAction) bottomRightBtnClicked
{
	if(bGeneratingSequence)
		return;

	AudioServicesPlaySystemSound(idSoundBottomRight);
	[self detectValue:3];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc 
{
	if(pSequenceArray)
	{
		[pSequenceArray removeAllObjects];
		[pSequenceArray release];
		pSequenceArray = nil;
	}
	
	if(idSoundTopLeft)
	{
		AudioServicesDisposeSystemSoundID(idSoundTopLeft);
	}
	if(idSoundTopRight)
	{
		AudioServicesDisposeSystemSoundID(idSoundTopRight);
	}
	if(idSoundBottomLeft)
	{
		AudioServicesDisposeSystemSoundID(idSoundBottomLeft);
	}
	if(idSoundBottomRight)
	{
		AudioServicesDisposeSystemSoundID(idSoundBottomRight);
	}
	
	
    [super dealloc];
}


@end
