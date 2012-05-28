//
//  PrizeViewController.m
//  AlwaysAWinner
//
//  Created by NextFaze on 23/05/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import "PrizeViewController.h"

#define kExpiresIn 20*60 //20 minutes

@interface PrizeViewController ()

@end

@implementation PrizeViewController

@synthesize imageViewYouHaveWon, imageViewPrizeImage, imageViewPrizeDescription;
@synthesize labelPrizeDescription, labelCountdownTime, labelIssueDate;

- (id)initWithPrize:(Prize *)p
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        prize = [p retain];
    }
    return self;
}

- (void)dealloc
{
    [rvc release];
    [countdownTimer release];
    [prize release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    labelCountdownTime.font = [UIFont fontWithName:@"Rockwell" size:28.0f];
    labelCountdownTime.textColor = [UIColor grayColor];
    
    labelPrizeDescription.font = [UIFont fontWithName:@"Rockwell-Bold" size:20.0f];
    
    //customize base on prize
    imageViewPrizeImage.image = [prize image];
    if ([prize text]) {
        labelPrizeDescription.text = [prize text];
        imageViewPrizeDescription.alpha = 0.0;
    }
    else {
        labelPrizeDescription.alpha = 0.0;
        imageViewPrizeDescription.image = [prize textImage];
    }
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //start the you have won image flashing
    self.imageViewYouHaveWon.alpha = 0.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationRepeatCount:FLT_MAX];
    self.imageViewYouHaveWon.alpha = 1.0;
    [UIView commitAnimations];
    
    //start the timer counting down
    secondsRemaining = kExpiresIn;    
    countdownTimer = [[NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(updateTime)
                                   userInfo:nil repeats:YES] retain];
    
    //set the date
    NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
    [format setDateFormat:@"dd/MM/YYYY"];
    NSDate *now = [[[NSDate alloc] init] autorelease];
    NSString *dateString = [format stringFromDate:now];
    labelIssueDate.text = dateString;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [countdownTimer invalidate];
}

- (void)updateTime
{
    //convert time to string
    int minutes = secondsRemaining / 60;
    int seconds = secondsRemaining % 60;
    
    NSString *timeRemaining = [NSString stringWithFormat:@"%i:%.2i", minutes, seconds];
    
    labelCountdownTime.text = timeRemaining;

    secondsRemaining--;
    if (secondsRemaining < 0) secondsRemaining = kExpiresIn;
}

#pragma mark -

- (IBAction)buttonTappedClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)buttonTappedDone:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"Be sure you have claimed your prize before you continue!"
                                                   delegate:self
                                          cancelButtonTitle:@"Go Back"
                                          otherButtonTitles:@"Continue", nil];
    [alert  show];
    [alert release];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //done - flip to the redeemed view
        if (!rvc) {
            rvc = [[RedeemedViewController alloc] init];
            rvc.delegate = self;
        }

        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.80];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight 
                               forView:self.view cache:NO];
        
        [self.view addSubview:rvc.view];
        [UIView commitAnimations];
    }
}

#pragma mark RedeemedViewControllerDelegate

- (void)redeemedViewControllerDidTapClose:(RedeemedViewController *)rvc
{
    [self dismissModalViewControllerAnimated:YES];
}



@end
