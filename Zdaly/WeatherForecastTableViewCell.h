//
//  WeatherForecastTableViewCell.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherForecastTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableDictionary *weatherDict;
@property (strong, nonatomic) IBOutlet UILabel *nameLb;
@property (strong, nonatomic) IBOutlet UILabel *tempcLb;
@property (strong, nonatomic) IBOutlet UILabel *tempfLb;
@property (strong, nonatomic) IBOutlet UILabel *windSpeedLb;
@property (strong, nonatomic) IBOutlet UILabel *humidityLb;
@property (strong, nonatomic) IBOutlet UIImageView *weatherIv;
@property (strong, nonatomic) IBOutlet UILabel *descLb;

@end
