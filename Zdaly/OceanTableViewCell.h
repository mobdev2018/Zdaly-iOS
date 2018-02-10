//
//  OceanTableViewCell.h
//  Zdaly
//
//  Created by AAA on 2017. 11. 23..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OceanTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableDictionary *oceanDict;
@property (strong, nonatomic) IBOutlet UILabel *nameLb;

@property (strong, nonatomic) IBOutlet UILabel *latLb;
@property (strong, nonatomic) IBOutlet UILabel *lonLb;

@end
