//
//  WeatherDetailViewController.h
//  Zdaly
//
//  Created by AAA on 2017. 11. 21..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *nameLb;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameHeightConst;
@property (strong, nonatomic) IBOutlet UILabel *dateLb;
@property (strong, nonatomic) IBOutlet UIImageView *weatherIv;
@property (strong, nonatomic) IBOutlet UILabel *conditionLb;
@property (strong, nonatomic) IBOutlet UILabel *tempLb;
@property (strong, nonatomic) IBOutlet UILabel *windSpeedLb;
@property (strong, nonatomic) IBOutlet UILabel *pressureLb;
@property (strong, nonatomic) IBOutlet UILabel *humidityLb;
@property (strong, nonatomic) IBOutlet UILabel *visibilityLb;
@property (nonatomic, strong) NSMutableDictionary *weatherDict;

@end
