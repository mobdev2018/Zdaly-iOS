//
//  MarineDetailTableViewCell.m
//  Zdaly
//
//  Created by AAA on 2017. 12. 2..
//  Copyright © 2017년 com. All rights reserved.
//

#import "MarineDetailTableViewCell.h"
#import "SDWebImageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation MarineDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setWeatherDict:(NSDictionary *)weatherDict {
    _weatherDict = weatherDict;
    int maxTemp = [[weatherDict objectForKey:@"maxtempC"] intValue];
    int minTemp = [[weatherDict objectForKey:@"mintempC"] intValue];
    NSArray *hourlyArr = [weatherDict objectForKey:@"hourly"];
    NSDictionary *hourDict = [hourlyArr objectAtIndex:0];
    int temp = [[hourDict objectForKey:@"tempC"] intValue];
    int windspeed = [[hourDict objectForKey:@"windspeedKmph"] intValue];
    int humidity = [[hourDict objectForKey:@"humidity"] intValue];
    int visibility = [[hourDict objectForKey:@"visibility"] intValue];
    int pressure = [[hourDict objectForKey:@"pressure"] intValue];
    [self.lowLb setText:[NSString stringWithFormat:@"Low: %d℃", minTemp]];
    [self.highLb setText:[NSString stringWithFormat:@"High: %d℃", maxTemp]];
    [self.windSpeedLb setText:[NSString stringWithFormat:@"Wind Speed: %dkm/h", windspeed]];
    [self.windDirectionLb setText:[hourDict objectForKey:@"winddir16Point"]];
    [self.windspeedMLb setText:[NSString stringWithFormat:@"Wind Speed: %@miles/hour", [hourDict objectForKey:@"windspeedMiles"]]];
    [self.precipitationLb setText:[NSString stringWithFormat:@"Precipitation: %@mm", [hourDict objectForKey:@"precipMM"]]];
    [self.humidityLb setText:[NSString stringWithFormat:@"Humidity: %d%@", humidity, @"%"]];
    [self.visibilityLb setText:[NSString stringWithFormat:@"Visibility: %dkm", visibility]];
    [self.pressureLb setText:[NSString stringWithFormat:@"Pressure: %dmb", pressure]];
    NSArray *weatherIconUrlArr = [hourDict objectForKey:@"weatherIconUrl"];
    NSDictionary *weatherIconUrlDict = [weatherIconUrlArr objectAtIndex:0];
    NSString *weatherIconUrl = [weatherIconUrlDict objectForKey:@"value"];
    NSArray *weatherDescArr = [hourDict objectForKey:@"weatherDesc"];
    NSDictionary *weatherDescDict = [weatherDescArr objectAtIndex:0];
    NSString *weatherDesc = [weatherDescDict objectForKey:@"value"];
    [self.weatherIv sd_setImageWithURL:[NSURL URLWithString:weatherIconUrl]];
    [self.conditionLb setText:weatherDesc];
    [self.dateLb setText:[weatherDict objectForKey:@"date"]];
    [self.tempLb setText:[NSString stringWithFormat:@"%d℃", temp]];
    [self.tempFLb setText:[NSString stringWithFormat:@"%@℉", [hourDict objectForKey:@"tempF"]]];
}
@end
