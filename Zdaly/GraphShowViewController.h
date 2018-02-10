//
//  GraphShowViewController.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 26..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphShowViewController : UIViewController
@property (nonatomic) BOOL isPresented;
@property (nonatomic, strong) NSDictionary *graphDict;
@property (strong, nonatomic) IBOutlet UIScrollView *descScrollView;
@property (strong, nonatomic) IBOutlet UILabel *titleLb;
@property (strong, nonatomic) IBOutlet UIView *xBaseView;
@property (strong, nonatomic) IBOutlet UIView *yAxisView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollHeightConst;

@end
