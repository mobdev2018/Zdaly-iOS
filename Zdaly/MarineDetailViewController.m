//
//  MarineDetailViewController.m
//  Zdaly
//
//  Created by AAA on 2017. 12. 2..
//  Copyright © 2017년 com. All rights reserved.
//

#import "MarineDetailViewController.h"
#import "MarineDetailTableViewCell.h"
#import "SDWebImageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "APIManager.h"
@interface MarineDetailViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *marineArr;
}
@end

@implementation MarineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    marineArr = [[NSMutableArray alloc] init];
    [self setWeatherInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return marineArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *marineDict = [marineArr objectAtIndex:indexPath.row];
    MarineDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarineDetailTVC"];
    cell.weatherDict = marineDict;
    return cell;
}

- (IBAction)removeClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setWeatherInfo {
    NSString *name = [self.oceanDict objectForKey:@"name"];
    UIFont *nameFont = self.nameLb.font;
    CGSize contentSize = [name boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 104, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: nameFont} context:nil].size;
    [self.nameLb setText:name];
    [self.nameHeightConst setConstant:contentSize.height + 1];

    double latitude = [[self.oceanDict objectForKey:@"lat"] doubleValue];
    double longitude = [[self.oceanDict objectForKey:@"lon"] doubleValue];
    [self.locLb setText:[NSString stringWithFormat:@"Latitude: %.2f, Longitude: %.2f", latitude, longitude]];

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
    [self.minTempLb setText:[NSString stringWithFormat:@"Low: %d℃", minTemp]];
    [self.maxTempLb setText:[NSString stringWithFormat:@"High: %d℃", maxTemp]];
    [self.tempLb setText:[NSString stringWithFormat:@"%d℃   %@℉", temp, [hourDict objectForKey:@"tempF"]]];
    [self.windSpeedLb setText:[NSString stringWithFormat:@"Wind Speed: %dkm/h", windspeed]];
    [self.windDirectionLb setText:[hourDict objectForKey:@"winddir16Point"]];
    [self.windSpeedMLb setText:[NSString stringWithFormat:@"Wind Speed: %@miles/hour", [hourDict objectForKey:@"windspeedMiles"]]];
    [self.precipitationLb setText:[NSString stringWithFormat:@"Precipitation: %@mm", [hourDict objectForKey:@"precipMM"]]];
    [self.humidityLb setText:[NSString stringWithFormat:@"Humidity: %d%@", humidity, @"%"]];
    [self.visibilityLb setText:[NSString stringWithFormat:@"Visibility: %dkm", visibility]];
    [self.pressureLb setText:[NSString stringWithFormat:@"Pressure: %@mb", [hourDict objectForKey:@"pressure"]]];
    NSArray *weatherIconUrlArr = [hourDict objectForKey:@"weatherIconUrl"];
    NSDictionary *weatherIconUrlDict = [weatherIconUrlArr objectAtIndex:0];
    NSString *weatherIconUrl = [weatherIconUrlDict objectForKey:@"value"];
    NSArray *weatherDescArr = [hourDict objectForKey:@"weatherDesc"];
    NSDictionary *weatherDescDict = [weatherDescArr objectAtIndex:0];
    NSString *weatherDesc = [weatherDescDict objectForKey:@"value"];
    [self.weatherIv sd_setImageWithURL:[NSURL URLWithString:weatherIconUrl]];
    [self.conditionLb setText:weatherDesc];
    [self.dateLb setText:[weatherDict objectForKey:@"date"]];
    
    for(int i = 1; i < weatherArr.count; i++) {
        NSDictionary *weatherDict = [weatherArr objectAtIndex:i];
        [marineArr addObject:weatherDict];
    }
    [self.tableView reloadData];
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
