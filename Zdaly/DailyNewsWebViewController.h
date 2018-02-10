//
//  DailyNewsWebViewController.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabViewController.h"

@interface DailyNewsWebViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) MainTabViewController *mainTabVC;
@property (nonatomic, strong) NSDictionary *newsDict;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@end
