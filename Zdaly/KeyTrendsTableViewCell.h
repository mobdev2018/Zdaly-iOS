//
//  KeyTrendsTableViewCell.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyTrendsViewController.h"

@interface KeyTrendsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *zoomBt;
@property (nonatomic, strong) NSDictionary *graphDict;
@property (strong, nonatomic) IBOutlet UIScrollView *descScrollView;
@property (strong, nonatomic) IBOutlet UILabel *titleLb;
@property (strong, nonatomic) IBOutlet UIView *yAxisView;
@property (strong, nonatomic) IBOutlet UIView *xBaseView;
@property (nonatomic, strong) KeyTrendsViewController *keyTrendsVC;
@end
