//
//  SpotPricesTableViewCell.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpotPricesTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLb;
@property (strong, nonatomic) IBOutlet UILabel *rateLb;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameWidthConst;

@end
