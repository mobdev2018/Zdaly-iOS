//
//  WeekdayWeatherTableViewCell.h
//  Zdaly
//
//  Created by AAA on 2017. 11. 21..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekdayWeatherTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLb;
@property (strong, nonatomic) IBOutlet UILabel *conditionLb;
@property (strong, nonatomic) IBOutlet UILabel *highLb;
@property (strong, nonatomic) IBOutlet UILabel *lowLb;
@property (strong, nonatomic) IBOutlet UIImageView *weatherIv;
@property (nonatomic, assign) int weekdayIndex;
@property (nonatomic, strong) NSDictionary *weatherDict;
@end
