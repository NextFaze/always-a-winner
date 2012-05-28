//
//  RedeemedViewController.h
//  AlwaysAWinner
//
//  Created by NextFaze on 24/05/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RedeemedViewControllerDelegate;

@interface RedeemedViewController : UIViewController {
    id<RedeemedViewControllerDelegate> delegate;
}

@property (nonatomic, assign) id<RedeemedViewControllerDelegate> delegate;

- (IBAction)buttonTappedClose:(id)sender;
- (IBAction)buttonTappedFacebook:(id)sender;
- (IBAction)buttonTappedTwitter:(id)sender;

@end



@protocol RedeemedViewControllerDelegate

- (void)redeemedViewControllerDidTapClose:(RedeemedViewController *)rvc;

@end
