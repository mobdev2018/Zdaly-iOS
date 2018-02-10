//
//  WeatherInfoDialogViewController.h
//  Zdaly
//
//  Created by AAA on 2017. 11. 23..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherInfoDialogViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *dialogView;
@property (nonatomic, strong) NSMutableDictionary *oceanDict;
@property (strong, nonatomic) IBOutlet UIImageView *weatherIv;
@property (strong, nonatomic) IBOutlet UILabel *tempLb;
@property (strong, nonatomic) IBOutlet UILabel *tempFLb;

@property (strong, nonatomic) IBOutlet UILabel *minMaxTempLb;
@property (strong, nonatomic) IBOutlet UILabel *conditionLb;
@property (strong, nonatomic) IBOutlet UILabel *latLb;
@property (strong, nonatomic) IBOutlet UILabel *lonLB;
@property (strong, nonatomic) IBOutlet UILabel *windSpeedLb;
@property (strong, nonatomic) IBOutlet UILabel *windSpeedMLb;

@property (strong, nonatomic) IBOutlet UILabel *windDirectionLb;
@property (strong, nonatomic) IBOutlet UILabel *precipitationLb;
@property (strong, nonatomic) IBOutlet UILabel *humidityLb;
@property (strong, nonatomic) IBOutlet UILabel *visibilityLb;
@property (strong, nonatomic) IBOutlet UILabel *pressureLb;

@end
