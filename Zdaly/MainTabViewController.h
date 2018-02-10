//
//  MainTabViewController.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIButton *dailyNewsTabBt;
@property (strong, nonatomic) IBOutlet UILabel *dailyNewsTabLb;
@property (strong, nonatomic) IBOutlet UIButton *keyTrendsTabBt;
@property (strong, nonatomic) IBOutlet UILabel *keyTrendsTabLb;
@property (strong, nonatomic) IBOutlet UIButton *spotPricesTabBt;
@property (strong, nonatomic) IBOutlet UILabel *spotPricesTabLb;
@property (strong, nonatomic) IBOutlet UIButton *weatherForecastTabBt;
@property (strong, nonatomic) IBOutlet UILabel *weatherForecastTabLb;

- (void)removeDailyNewsWebView;
- (void)showDailyNewsWebView:(NSDictionary*)newsDict;
- (void)removeViewController;
@end
