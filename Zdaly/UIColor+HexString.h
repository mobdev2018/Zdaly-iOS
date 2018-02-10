//
//  UIColor+HexString.h
//  Zdaly
//
//  Created by sanjay vishwakarma on 05/01/18.
//  Copyright © 2018 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

+ (UIColor *) colorWithHexString: (NSString *) hexString;
+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;

@end
