//
//  WeatherForecastTableViewCell.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import "WeatherForecastTableViewCell.h"
#import "SDWebImageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation WeatherForecastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setWeatherDict:(NSMutableDictionary *)weatherDict {
    _weatherDict = weatherDict;
    NSDictionary *dataDict = [weatherDict objectForKey:@"data"];
    NSArray *requestArr = [dataDict objectForKey:@"request"];
    NSDictionary *requestDict = [requestArr objectAtIndex:0];
    NSString *city = [requestDict objectForKey:@"query"];
    [self.nameLb setText:city];
    NSArray *conditionArr = [dataDict objectForKey:@"current_condition"];
    NSDictionary *conditionDict = [conditionArr objectAtIndex:0];
    [self.tempcLb setText:[NSString stringWithFormat:@"%@℃", [conditionDict objectForKey:@"temp_C"]]];
    [self.tempfLb setText:[NSString stringWithFormat:@"%@℉", [conditionDict objectForKey:@"temp_F"]]];
    [self.windSpeedLb setText:[NSString stringWithFormat:@"%@km/h", [conditionDict objectForKey:@"windspeedKmph"]]];
    [self.humidityLb setText:[NSString stringWithFormat:@"%@%@", [conditionDict objectForKey:@"humidity"], @"%"]];
    
    NSArray *weatherIconUrlArr = [conditionDict objectForKey:@"weatherIconUrl"];
    NSDictionary *weatherIconUrlDict = [weatherIconUrlArr objectAtIndex:0];
    NSString *weatherIconUrl = [weatherIconUrlDict objectForKey:@"value"];
    NSArray *weatherDescArr = [conditionDict objectForKey:@"weatherDesc"];
    NSDictionary *weatherDescDict = [weatherDescArr objectAtIndex:0];
    NSString *weatherDesc = [weatherDescDict objectForKey:@"value"];
    [self.weatherIv sd_setImageWithURL:[NSURL URLWithString:weatherIconUrl]];
    [self.descLb setText:weatherDesc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
