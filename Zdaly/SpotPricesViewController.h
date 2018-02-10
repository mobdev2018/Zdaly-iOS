//
//  SpotPricesViewController.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabViewController.h"
@interface SpotPricesViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MainTabViewController *mainTabVC;
@end
