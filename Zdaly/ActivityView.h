//
//  ActivityView.h
//
//
//  Created by AAA on 4/22/17.
//  Copyright © 2017 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ActivityView : NSObject

// Shared instance..
+ (instancetype) sharedInstance;

// Waiting view..
@property (nonatomic, strong) UIView *waitingView;
@property (nonatomic, strong) UIView *childView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UILabel *waitingLb;

- (void)startWaiting:(UIView *)parentView text:(NSString *)waitingText;
- (void)stopWaiting;
@end
