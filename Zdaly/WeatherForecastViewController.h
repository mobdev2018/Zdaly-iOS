//
//  WeatherForecastViewController.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MainTabViewController.h"
@interface WeatherForecastViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MainTabViewController *mainTabVC;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *underlineLb;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *undLbWidthConst;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *undLbLeftConst;
@property (strong, nonatomic) IBOutlet UIButton *cityTabBt;
@property (strong, nonatomic) IBOutlet UIButton *oceanTabBt;
@property (strong, nonatomic) IBOutlet UIButton *switchBt;

@end
