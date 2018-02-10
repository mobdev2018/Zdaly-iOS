//
//  MarineDetailTableViewCell.h
//  Zdaly
//
//  Created by AAA on 2017. 12. 2..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarineDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *weatherIv;
@property (strong, nonatomic) IBOutlet UILabel *tempLb;
@property (strong, nonatomic) IBOutlet UILabel *tempFLb;

@property (strong, nonatomic) IBOutlet UILabel *dateLb;
@property (strong, nonatomic) IBOutlet UILabel *conditionLb;
@property (strong, nonatomic) IBOutlet UILabel *highLb;
@property (strong, nonatomic) IBOutlet UILabel *lowLb;
@property (strong, nonatomic) IBOutlet UILabel *windSpeedLb;

@property (strong, nonatomic) IBOutlet UILabel *windspeedMLb;
@property (strong, nonatomic) IBOutlet UILabel *windDirectionLb;

@property (strong, nonatomic) IBOutlet UILabel *humidityLb;
@property (strong, nonatomic) IBOutlet UILabel *visibilityLb;
@property (strong, nonatomic) IBOutlet UILabel *pressureLb;
@property (strong, nonatomic) IBOutlet UILabel *precipitationLb;
@property (nonatomic, strong) NSDictionary *weatherDict;
@property (strong, nonatomic) IBOutlet UIImageView *windDirectionIv;

@end
