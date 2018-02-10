//
//  MarineDetailViewController.h
//  Zdaly
//
//  Created by AAA on 2017. 12. 2..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarineDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *nameLb;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameHeightConst;

@property (strong, nonatomic) IBOutlet UILabel *locLb;
@property (strong, nonatomic) IBOutlet UILabel *dateLb;
@property (strong, nonatomic) IBOutlet UIImageView *weatherIv;
@property (strong, nonatomic) IBOutlet UILabel *conditionLb;
@property (strong, nonatomic) IBOutlet UILabel *tempLb;
@property (strong, nonatomic) IBOutlet UILabel *maxTempLb;
@property (strong, nonatomic) IBOutlet UILabel *minTempLb;
@property (strong, nonatomic) IBOutlet UILabel *windSpeedLb;
@property (strong, nonatomic) IBOutlet UILabel *windDirectionLb;

@property (strong, nonatomic) IBOutlet UILabel *windSpeedMLb;
@property (strong, nonatomic) IBOutlet UILabel *precipitationLb;
@property (strong, nonatomic) IBOutlet UILabel *humidityLb;
@property (strong, nonatomic) IBOutlet UILabel *visibilityLb;
@property (strong, nonatomic) IBOutlet UILabel *pressureLb;
@property (nonatomic, strong) NSMutableDictionary *oceanDict;
@end
