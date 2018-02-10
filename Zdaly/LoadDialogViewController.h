//
//  LoadDialogViewController.h
//  Zdaly
//
//  Created by AAA on 2017. 10. 31..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadDialogViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *dialogView;
@property (strong, nonatomic) IBOutlet UILabel *contentLb;
@property (strong, nonatomic) IBOutlet UIImageView *logoIv;
@property (nonatomic, assign) NSString *contentStr;
@end
