//
//  KeyTrendsViewController.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabViewController.h"
@interface KeyTrendsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *underlineLb;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *underlineLeftConst;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *underlineWidthConst;
@property (strong, nonatomic) IBOutlet UIButton *firstTabBt;
@property (strong, nonatomic) IBOutlet UIButton *secondTabBt;
@property (strong, nonatomic) IBOutlet UIButton *thirdTabBt;
@property (nonatomic, strong) MainTabViewController *mainTabVC;

@property (strong, nonatomic) IBOutlet UIScrollView *headerScrollView;

@end
