//
//  PrizeViewController.h
//  AlwaysAWinner
//
//  Created by NextFaze on 23/05/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedeemedViewController.h"
#import "Prize.h"

@interface PrizeViewController : UIViewController <RedeemedViewControllerDelegate>
{
    RedeemedViewController *rvc;
    int secondsRemaining;
    NSTimer *countdownTimer;
    Prize *prize;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageViewYouHaveWon;
@property (nonatomic, retain) IBOutlet UIImageView *imageViewPrizeImage;
@property (nonatomic, retain) IBOutlet UIImageView *imageViewPrizeDescription;
@property (nonatomic, retain) IBOutlet UILabel *labelPrizeDescription;
@property (nonatomic, retain) IBOutlet UILabel *labelCountdownTime;
@property (nonatomic, retain) IBOutlet UILabel *labelIssueDate;


- (id)initWithPrize:(Prize *)p;

- (IBAction)buttonTappedClose:(id)sender;
- (IBAction)buttonTappedDone:(id)sender;

@end
