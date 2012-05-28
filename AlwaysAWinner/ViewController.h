//
//  ViewController.h
//  AlwaysAWinner
//
//  Created by NextFaze on 23/05/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdWhirlDelegateProtocol.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AdWhirlDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIImageView *imageViewHeader;
@property (nonatomic, strong) IBOutlet AdWhirlView *adView;


- (IBAction)buttonTapped:(id)sender;

@end
