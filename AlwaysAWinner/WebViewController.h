//
//  WebViewController.h
//
//  Created by NextFaze
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController <UIWebViewDelegate> {
    BOOL errorLoading;
}

- (id)initWithURLRequest:(NSURLRequest *)request;

@end
