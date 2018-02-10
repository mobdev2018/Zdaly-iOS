//
//  CustomLineView.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 30..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLineView : UIView
@property (nonatomic, strong) NSMutableArray *pointArr;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat lineAlpha;
@property (nonatomic, assign) CGFloat fillAlpha;

- (id) initWithPointArrayAndFrame: (NSMutableArray *)pointArr frame:(CGRect)rect color:(UIColor*)color lineAlpha:(CGFloat)lineAlpha fillAlpha:(CGFloat)fillAlpha;
@end
