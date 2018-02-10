//
//  LoginDialogViewController.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface LoginDialogViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *dialogView;
@property (nonatomic, strong) ViewController *loginVC;
@property (strong, nonatomic) IBOutlet UIImageView *logoIv;

@end
