//
//  WebViewController.m
//
//  Created by Ricardo Santos.
//  Copyright (c) 2011 Ricardo Santos. All rights reserved.
//

#import "WebViewController.h"

#define ToolbarHeight 44

@implementation WebViewController

- (id)initWithURLRequest:(NSURLRequest *)request
{
    NFLog(@"");

    self = [super init];
    if (self) {        
        // Custom initialization
        errorLoading = NO;
        
        CGRect rectWeb = CGRectMake(0, ToolbarHeight, self.view.frame.size.width, self.view.frame.size.height - ToolbarHeight);
        UIWebView *webView = [[UIWebView alloc] initWithFrame:rectWeb];
        [webView loadRequest:request];
        webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        webView.opaque = NO;
        webView.delegate = self;
        webView.backgroundColor = [UIColor whiteColor];
        webView.scalesPageToFit = YES;
        [self.view addSubview:webView];
        [webView release];
        
    }
    return self;
}

- (void)deallocView {

}

- (void)dealloc
{    
    [self deallocView];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, ToolbarHeight);
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                    target:self 
                                                                    action:@selector(buttonTappedDone:)] autorelease]];
    [toolbar setItems:items animated:NO];
    [items release];
    [self.view addSubview:toolbar];
    [toolbar release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -

- (void)buttonTappedDone:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{   
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //NFLog(@"WebView");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //NFLog(@"WebView");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NFLog(@"%@", error);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
   
    if (error.code == NSURLErrorCancelled) return; // this is Error -999
    
    // error handling for "real" errors here
    if (!errorLoading && error) {
        errorLoading = YES;
        NSString *message = [NSString stringWithFormat:@"Unable to load webpage. %@", [error localizedDescription]];
        
        [[[[UIAlertView alloc] initWithTitle:@"Error loading webpage"
                                     message:message
                                    delegate:self
                           cancelButtonTitle:@"Close"
                           otherButtonTitles:nil] autorelease] show];
    }
    

}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //acknowledged error
    [self.navigationController popViewControllerAnimated:YES];
}

@end
