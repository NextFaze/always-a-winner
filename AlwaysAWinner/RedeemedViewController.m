//
//  RedeemedViewController.m
//  AlwaysAWinner
//
//  Created by NextFaze on 24/05/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import "RedeemedViewController.h"
#import "WebViewController.h"

@interface RedeemedViewController ()

@end

@implementation RedeemedViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - 

- (void)showWebViewWithURL:(NSString *)url
{
    if (url) {
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        WebViewController *wvc = [[WebViewController alloc] initWithURLRequest:req];
        [self presentModalViewController:wvc animated:YES];
        [wvc release];     
    }
}

#pragma mark - 

- (IBAction)buttonTappedClose:(id)sender
{
    NFLog(@"Button tapped closed");
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [delegate redeemedViewControllerDidTapClose:self];
}

- (IBAction)buttonTappedFacebook:(id)sender
{
    [self showWebViewWithURL:@"http://facebook.com/nextfaze"];
}

- (IBAction)buttonTappedTwitter:(id)sender
{
    [self showWebViewWithURL:@"http://twitter.com/nextfaze"];    
}


@end
