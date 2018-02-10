//
//  MainTabViewController.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import "MainTabViewController.h"
#import "DailyNewsViewController.h"
#import "DailyNewsWebViewController.h"
#import "SpotPricesViewController.h"
#import "WeatherForecastViewController.h"
#import "KeyTrendsViewController.h"

@interface MainTabViewController () {
    int tabIndex;
    UIStoryboard *mainBoard;
    DailyNewsViewController *dailyNewsVC;
    DailyNewsWebViewController *dailyNewsWebVC;
    WeatherForecastViewController *weatherForecastVC;
    SpotPricesViewController *spotPricesVC;
    KeyTrendsViewController *keyTrendsVC;
}
@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mainBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    dailyNewsVC = [mainBoard instantiateViewControllerWithIdentifier:@"DailyNewsVC"];
    dailyNewsVC.mainTabVC = self;
    [self addChildViewController:dailyNewsVC];
    [dailyNewsVC.view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:dailyNewsVC.view];
    [dailyNewsVC didMoveToParentViewController:self];
    tabIndex = 0;
    [self setTabButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppOpenTask:) name:@"AppOpened" object:nil];
}

- (void)AppOpenTask:(NSNotification *)notification {
    [self removeViewController];
    dailyNewsVC = [mainBoard instantiateViewControllerWithIdentifier:@"DailyNewsVC"];
    dailyNewsVC.mainTabVC = self;
    [self addChildViewController:dailyNewsVC];
    [dailyNewsVC.view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:dailyNewsVC.view];
    [dailyNewsVC didMoveToParentViewController:self];
    tabIndex = 0;
    [self setTabButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)firstTabClicked:(id)sender {
    [self removeViewController];
    dailyNewsVC = [mainBoard instantiateViewControllerWithIdentifier:@"DailyNewsVC"];
    dailyNewsVC.mainTabVC = self;
    [self addChildViewController:dailyNewsVC];
    [dailyNewsVC.view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:dailyNewsVC.view];
    [dailyNewsVC didMoveToParentViewController:self];
    tabIndex = 0;
    [self setTabButton];
}

- (IBAction)secondTabClicked:(id)sender {
    [self removeViewController];
    keyTrendsVC = [mainBoard instantiateViewControllerWithIdentifier:@"KeyTrendsVC"];
    keyTrendsVC.mainTabVC = self;
    [self addChildViewController:keyTrendsVC];
    [keyTrendsVC.view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:keyTrendsVC.view];
    [keyTrendsVC didMoveToParentViewController:self];
    tabIndex = 1;
    [self setTabButton];
}

- (IBAction)thirdTabClicked:(id)sender {
    [self removeViewController];
    spotPricesVC = [mainBoard instantiateViewControllerWithIdentifier:@"SpotPricesVC"];
    spotPricesVC.mainTabVC = self;
    [self addChildViewController:spotPricesVC];
    [spotPricesVC.view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:spotPricesVC.view];
    [spotPricesVC didMoveToParentViewController:self];
    tabIndex = 2;
    [self setTabButton];
}

- (IBAction)fourthTabClicked:(id)sender {
    [self removeViewController];
    weatherForecastVC = [mainBoard instantiateViewControllerWithIdentifier:@"WeatherForecastVC"];
    weatherForecastVC.mainTabVC = self;
    [self addChildViewController:weatherForecastVC];
    [weatherForecastVC.view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:weatherForecastVC.view];
    [weatherForecastVC didMoveToParentViewController:self];
    tabIndex = 3;
    [self setTabButton];
}

- (void)removeViewController
{
    if(tabIndex == 0) {
        [dailyNewsVC willMoveToParentViewController:nil];
        [dailyNewsVC.view removeFromSuperview];
        [dailyNewsVC removeFromParentViewController];
        [[NSNotificationCenter defaultCenter] removeObserver:dailyNewsVC];
    }
    else if(tabIndex == 1) {
        [keyTrendsVC willMoveToParentViewController:nil];
        [keyTrendsVC.view removeFromSuperview];
        [keyTrendsVC removeFromParentViewController];
        [[NSNotificationCenter defaultCenter] removeObserver:keyTrendsVC];
    }
    else if(tabIndex == 2) {
        [spotPricesVC willMoveToParentViewController:nil];
        [spotPricesVC.view removeFromSuperview];
        [spotPricesVC removeFromParentViewController];
        [[NSNotificationCenter defaultCenter] removeObserver:spotPricesVC];
    }
    else if(tabIndex == 3) {
        [weatherForecastVC willMoveToParentViewController:nil];
        [weatherForecastVC.view removeFromSuperview];
        [weatherForecastVC removeFromParentViewController];
        [[NSNotificationCenter defaultCenter] removeObserver:weatherForecastVC];
    }
    else {
        [dailyNewsVC willMoveToParentViewController:nil];
        [dailyNewsVC.view removeFromSuperview];
        [dailyNewsVC removeFromParentViewController];
        [[NSNotificationCenter defaultCenter] removeObserver:dailyNewsVC];

        [weatherForecastVC willMoveToParentViewController:nil];
        [weatherForecastVC.view removeFromSuperview];
        [weatherForecastVC removeFromParentViewController];
        [[NSNotificationCenter defaultCenter] removeObserver:weatherForecastVC];
    }
}

- (void)setTabButton {
    if(tabIndex == 0 || tabIndex == 4) {
        [self.dailyNewsTabBt setBackgroundColor:[UIColor colorWithRed:0.903512 green:0.258715 blue:0.263742 alpha:1]];
        [self.keyTrendsTabBt setBackgroundColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1]];
        [self.spotPricesTabBt setBackgroundColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1]];
        [self.weatherForecastTabBt setBackgroundColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1]];
    }
    else if(tabIndex == 1) {
        [self.dailyNewsTabBt setBackgroundColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1]];
        [self.keyTrendsTabBt setBackgroundColor:[UIColor colorWithRed:0.903512 green:0.258715 blue:0.263742 alpha:1]];
        [self.spotPricesTabBt setBackgroundColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1]];
        [self.weatherForecastTabBt setBackgroundColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1]];
    }
    else if(tabIndex == 2) {
        [self.dailyNewsTabBt setBackgroundColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1]];
        [self.keyTrendsTabBt setBackgroundColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1]];
        [self.spotPricesTabBt setBackgroundColor:[UIColor colorWithRed:0.903512 green:0.258715 blue:0.263742 alpha:1]];
        [self.weatherForecastTabBt setBackgroundColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1]];
    }
    else {
        [self.dailyNewsTabBt setBackgroundColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1]];
        [self.keyTrendsTabBt setBackgroundColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1]];
        [self.spotPricesTabBt setBackgroundColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1]];
        [self.weatherForecastTabBt setBackgroundColor:[UIColor colorWithRed:0.903512 green:0.258715 blue:0.263742 alpha:1]];
    }
}

- (void)showDailyNewsWebView:(NSDictionary*)newsDict {
    dailyNewsWebVC = [mainBoard instantiateViewControllerWithIdentifier:@"DailyNewsWebVC"];
    dailyNewsWebVC.mainTabVC = self;
    dailyNewsWebVC.newsDict = newsDict;
    [self addChildViewController:dailyNewsWebVC];
    [dailyNewsWebVC.view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:dailyNewsWebVC.view];
    [dailyNewsWebVC didMoveToParentViewController:self];
    tabIndex = 4;
    [self setTabButton];
}

- (void)removeDailyNewsWebView {
    [dailyNewsWebVC willMoveToParentViewController:nil];
    [dailyNewsWebVC.view removeFromSuperview];
    [dailyNewsWebVC removeFromParentViewController];
    [[NSNotificationCenter defaultCenter] removeObserver:dailyNewsWebVC];
    tabIndex = 0;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
