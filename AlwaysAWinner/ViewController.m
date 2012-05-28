//
//  ViewController.m
//  AlwaysAWinner
//
//  Created by NextFaze on 23/05/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import "ViewController.h"
#import "PrizeViewController.h"
#import "WebViewController.h"
#import "AdWhirlView.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize imageViewHeader;
@synthesize adView;
@synthesize tableView;

- (void)fadeToAlpha:(float)alpha
{
    [UIView beginAnimations:nil context:nil];

    self.imageViewHeader.alpha = alpha;
    self.adView.alpha = alpha;
    self.tableView.alpha = alpha;

    [UIView commitAnimations];
}

- (void)fadeOut
{
    [self fadeToAlpha:0.0];
}

- (void)fadeIn
{
    [self fadeToAlpha:1.0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.imageViewHeader.alpha = 0;
    self.adView.alpha = 0;
    self.tableView.alpha = 0;
    
    //adwhirl
    AdWhirlView *adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
    [self.adView addSubview:adWhirlView];
    
    //disclaimer
    UILabel *labelDisclaimer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    labelDisclaimer.font = [UIFont systemFontOfSize:10];
    labelDisclaimer.backgroundColor = [UIColor clearColor];
    labelDisclaimer.numberOfLines = 0;
    labelDisclaimer.text = @"\n\n\nDisclaimer: This app is for research and educational purposes only.";
    [labelDisclaimer sizeToFit];
    self.tableView.tableFooterView = labelDisclaimer;
    [labelDisclaimer release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidAppear:(BOOL)animated
{
    [self fadeIn];
        
    //refresh the ad
    //TODO
}

#pragma mark - 

- (IBAction)buttonTapped:(id)sender
{
    NFLog(@"Button tapped");
}

#pragma mark -  UITableViewDelegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //deselect table view cell
    [tv deselectRowAtIndexPath:tv.indexPathForSelectedRow animated:YES];
    
    if (indexPath.section == 0) {
        //prize selected
        [self fadeOut];
        
        Prize *prize = [[DataModel instance] prizeAtIndex:indexPath.row];
        
        PrizeViewController *pvc = [[PrizeViewController alloc] initWithPrize:prize];
        [self presentModalViewController:pvc animated:YES];
        [pvc release];
    }
    else if (indexPath.section == 1) {
        
        NSString *url = nil;
        
        switch (indexPath.row) {
            case 0:
                url = @"http://links.nextfaze.com/always-a-winner-blog";
                break;
            case 1:
                url = @"http://facebook.com/nextfaze";
                break;
            case 2:
                url = @"http://twitter.com/nextfaze";              
                break;                
            default:
                break;
        }  
        
        if (url) {
            NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
            WebViewController *wvc = [[WebViewController alloc] initWithURLRequest:req];
            wvc.title = @"About";
            [self presentModalViewController:wvc animated:YES];
            [wvc release];     
        }
    }

}

#pragma mark -  UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) return @"Prizes";
    if (section == 1) return @"More";
    return 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return [[DataModel instance] numberOfPrizes];
    if (section == 1) return 3;
    return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.font = [UIFont fontWithName:@"Rockwell" size:18.0f];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    // Configure the cell...
    if (indexPath.section == 0) {
        Prize *prize = [[DataModel instance] prizeAtIndex:indexPath.row];
        
        cell.imageView.image = [prize image];
        cell.textLabel.text = [prize name];
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = nil;
                cell.textLabel.text = @"About";
                cell.imageView.image = [UIImage imageNamed:@"nextfaze.png"];
                break;
            case 1:
                cell.imageView.image = nil;
                cell.textLabel.text = @"Facebook";
                cell.imageView.image = [UIImage imageNamed:@"facebook.png"];
                break;
            case 2:
                cell.imageView.image = nil;
                cell.textLabel.text = @"Twitter";
                cell.imageView.image = [UIImage imageNamed:@"twitter.png"];                
                break;                
            default:
                break;
        }
    }

    
    return cell;
}

#pragma mark - AdWhirlDelegate

- (NSString *)adWhirlApplicationKey 
{
    NFLog(@"");

    return @"1d31df590ce14cebbd81e1b0b4c5f16e";
}

- (UIViewController *)viewControllerForPresentingModalView 
{
    NFLog(@"");

    return self;
}

- (void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlView 
{
    NFLog(@"");
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.7];
    
    CGSize adSize = [adWhirlView actualAdSize];
    CGRect newFrame = adWhirlView.frame;
    
    newFrame.size = adSize;
    newFrame.origin.x = (self.view.bounds.size.width - adSize.width)/ 2;
    
    adWhirlView.frame = newFrame;
    
    [UIView commitAnimations];
}

@end












