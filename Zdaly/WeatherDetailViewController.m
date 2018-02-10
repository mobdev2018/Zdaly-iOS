//
//  WeatherDetailViewController.m
//  Zdaly
//
//  Created by AAA on 2017. 11. 21..
//  Copyright © 2017년 com. All rights reserved.
//

#import "WeatherDetailViewController.h"
#import "WeekdayWeatherTableViewCell.h"
#import "SDWebImageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface WeatherDetailViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *weatherArr;
}
@end

@implementation WeatherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureDesign];
}

- (void)configureDesign {
    
    NSDictionary *dataDict = [self.weatherDict objectForKey:@"data"];
    NSArray *requestArr = [dataDict objectForKey:@"request"];
    NSDictionary *requestDict = [requestArr objectAtIndex:0];
    NSString *city = [requestDict objectForKey:@"query"];
    
    UIFont *cityFont = self.nameLb.font;
    CGSize contentSize = [city boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 104, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: cityFont} context:nil].size;
    [self.nameHeightConst setConstant:contentSize.height + 1];
    [self.nameLb setText:city];
    NSArray *conditionArr = [dataDict objectForKey:@"current_condition"];
    NSDictionary *conditionDict = [conditionArr objectAtIndex:0];
    [self.tempLb setText:[NSString stringWithFormat:@"%@℃", [conditionDict objectForKey:@"temp_C"]]];
    [self.windSpeedLb setText:[NSString stringWithFormat:@"Wind Speed: %@km/h", [conditionDict objectForKey:@"windspeedKmph"]]];
    [self.pressureLb setText:[NSString stringWithFormat:@"Pressure: %@mb", [conditionDict objectForKey:@"pressure"]]];
    [self.humidityLb setText:[NSString stringWithFormat:@"Humidity: %@%@", [conditionDict objectForKey:@"humidity"], @"%"]];
    [self.visibilityLb setText:[NSString stringWithFormat:@"Visibility: %@km", [conditionDict objectForKey:@"visibility"]]];

    NSArray *weatherIconUrlArr = [conditionDict objectForKey:@"weatherIconUrl"];
    NSDictionary *weatherIconUrlDict = [weatherIconUrlArr objectAtIndex:0];
    NSString *weatherIconUrl = [weatherIconUrlDict objectForKey:@"value"];
    NSArray *weatherDescArr = [conditionDict objectForKey:@"weatherDesc"];
    NSDictionary *weatherDescDict = [weatherDescArr objectAtIndex:0];
    NSString *weatherDesc = [weatherDescDict objectForKey:@"value"];
    [self.weatherIv sd_setImageWithURL:[NSURL URLWithString:weatherIconUrl]];
    [self.conditionLb setText:weatherDesc];
    
    weatherArr = [dataDict objectForKey:@"weather"];
    if(weatherArr == nil) {
        weatherArr = [[NSArray alloc] init];
    }
    NSDictionary *weatherDict = [weatherArr objectAtIndex:0];
    [self.dateLb setText:[weatherDict objectForKey:@"date"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return weatherArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeekdayWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeekdayWeatherTVC"];
    cell.weekdayIndex = (int)indexPath.row;
    cell.weatherDict = self.weatherDict;
    return cell;
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
