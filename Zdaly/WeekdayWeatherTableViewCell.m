//
//  WeekdayWeatherTableViewCell.m
//  Zdaly
//
//  Created by AAA on 2017. 11. 21..
//  Copyright © 2017년 com. All rights reserved.
//

#import "WeekdayWeatherTableViewCell.h"
#import "SDWebImageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation WeekdayWeatherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setWeekdayIndex:(int)weekdayIndex {
    _weekdayIndex = weekdayIndex;
}

- (void)setWeatherDict:(NSDictionary *)weatherDict {
    _weatherDict = weatherDict;
    NSDictionary *dataDict = [weatherDict objectForKey:@"data"];
    NSArray *weatherArr = [dataDict objectForKey:@"weather"];
    NSDictionary *weekWeatherDict = [weatherArr objectAtIndex:self.weekdayIndex];
    [self.dateLb setText:[weekWeatherDict objectForKey:@"date"]];
    [self.highLb setText:[NSString stringWithFormat:@"High: %@℃", [weekWeatherDict objectForKey:@"maxtempC"]]];
    [self.lowLb setText:[NSString stringWithFormat:@"Low: %@℃", [weekWeatherDict objectForKey:@"mintempC"]]];
    NSArray *hourlyArr = [weekWeatherDict objectForKey:@"hourly"];
    NSDictionary *hourDict = [hourlyArr objectAtIndex:0];
    NSArray *weatherIconUrlArr = [hourDict objectForKey:@"weatherIconUrl"];
    NSDictionary *weatherIconUrlDict = [weatherIconUrlArr objectAtIndex:0];
    NSString *weatherIconUrl = [weatherIconUrlDict objectForKey:@"value"];
    NSArray *weatherDescArr = [hourDict objectForKey:@"weatherDesc"];
    NSDictionary *weatherDescDict = [weatherDescArr objectAtIndex:0];
    NSString *weatherDesc = [weatherDescDict objectForKey:@"value"];
    [self.weatherIv sd_setImageWithURL:[NSURL URLWithString:weatherIconUrl]];
    [self.conditionLb setText:weatherDesc];
}

@end
