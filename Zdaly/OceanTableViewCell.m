//
//  OceanTableViewCell.m
//  Zdaly
//
//  Created by AAA on 2017. 11. 23..
//  Copyright © 2017년 com. All rights reserved.
//

#import "OceanTableViewCell.h"

@implementation OceanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOceanDict:(NSMutableDictionary *)oceanDict {
    _oceanDict = oceanDict;
    [self.nameLb setText:[oceanDict objectForKey:@"name"]];
    float latitude = [[oceanDict objectForKey:@"lat"] floatValue];
    float longitude = [[oceanDict objectForKey:@"lon"] floatValue];
    [self.latLb setText:[NSString stringWithFormat:@"%.2f", latitude]];
    [self.lonLb setText:[NSString stringWithFormat:@"%.2f", longitude]];
}

@end
