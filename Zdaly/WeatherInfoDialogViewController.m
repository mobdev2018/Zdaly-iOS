//
//  WeatherInfoDialogViewController.m
//  Zdaly
//
//  Created by AAA on 2017. 11. 23..
//  Copyright © 2017년 com. All rights reserved.
//

#import "WeatherInfoDialogViewController.h"
#import "APIManager.h"
#import "Global.h"
#import "SDWebImageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface WeatherInfoDialogViewController () <APIManagerListener>
{
}
@end

@implementation WeatherInfoDialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureDesign];
    [self setWeatherInfo];
}

- (void)configureDesign {
    self.dialogView.layer.cornerRadius = 10;
    self.dialogView.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeClicked:(id)sender {
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.alpha = 0;
        
    }completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

- (void)setWeatherInfo {
    double latitude = [[self.oceanDict objectForKey:@"lat"] doubleValue];
    double longitude = [[self.oceanDict objectForKey:@"lon"] doubleValue];
    [self.latLb setText:[NSString stringWithFormat:@"Latitude: %.2f", latitude]];
    [self.lonLB setText:[NSString stringWithFormat:@"Longitude: %.2f", longitude]];
    NSDictionary *marineDict = [self.oceanDict objectForKey:@"weather"];//[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSDictionary *dataDict = [marineDict objectForKey:@"data"];
    NSArray *weatherArr = [dataDict objectForKey:@"weather"];
    NSDictionary *weatherDict = [weatherArr objectAtIndex:0];
    int maxTemp = [[weatherDict objectForKey:@"maxtempC"] intValue];
    int minTemp = [[weatherDict objectForKey:@"mintempC"] intValue];
    NSArray *hourlyArr = [weatherDict objectForKey:@"hourly"];
    NSDictionary *hourDict = [hourlyArr objectAtIndex:0];
    int temp = [[hourDict objectForKey:@"tempC"] intValue];
    int windspeed = [[hourDict objectForKey:@"windspeedKmph"] intValue];
    int humidity = [[hourDict objectForKey:@"humidity"] intValue];
    int visibility = [[hourDict objectForKey:@"visibility"] intValue];
    [self.minMaxTempLb setText:[NSString stringWithFormat:@"%d℃ ~ %d℃", minTemp, maxTemp]];
    [self.tempLb setText:[NSString stringWithFormat:@"%d℃", temp]];
    [self.tempFLb setText:[NSString stringWithFormat:@"%@℉", [hourDict objectForKey:@"tempF"]]];
    [self.windSpeedLb setText:[NSString stringWithFormat:@"%dkm/h", windspeed]];
    [self.windSpeedMLb setText:[NSString stringWithFormat:@"%@miles/hour", [hourDict objectForKey:@"windspeedMiles"]]];
    [self.windDirectionLb setText:[hourDict objectForKey:@"winddir16Point"]];
    [self.precipitationLb setText:[NSString stringWithFormat:@"%@mm", [hourDict objectForKey:@"precipMM"]]];
    [self.humidityLb setText:[NSString stringWithFormat:@"%d%@", humidity, @"%"]];
    [self.visibilityLb setText:[NSString stringWithFormat:@"%dkm", visibility]];
    [self.pressureLb setText:[NSString stringWithFormat:@"%@mb", [hourDict objectForKey:@"pressure"]]];
    NSArray *weatherIconUrlArr = [hourDict objectForKey:@"weatherIconUrl"];
    NSDictionary *weatherIconUrlDict = [weatherIconUrlArr objectAtIndex:0];
    NSString *weatherIconUrl = [weatherIconUrlDict objectForKey:@"value"];
    NSArray *weatherDescArr = [hourDict objectForKey:@"weatherDesc"];
    NSDictionary *weatherDescDict = [weatherDescArr objectAtIndex:0];
    NSString *weatherDesc = [weatherDescDict objectForKey:@"value"];
    [self.weatherIv sd_setImageWithURL:[NSURL URLWithString:weatherIconUrl]];
    [self.conditionLb setText:weatherDesc];
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
