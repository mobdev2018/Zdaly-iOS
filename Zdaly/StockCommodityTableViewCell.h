//
//  StockCommodityTableViewCell.h
//  Zdaly
//
//  Created by AAA on 2017. 10. 18..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockCommodityTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLb;
@property (strong, nonatomic) IBOutlet UILabel *originLb;
@property (strong, nonatomic) IBOutlet UILabel *changeLb;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *originWidthConst;

@end
