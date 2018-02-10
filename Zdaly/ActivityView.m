//
//  ActivityView.m
//  
//
//  Created by AAA on 4/22/17.
//  Copyright © 2017 com. All rights reserved.
//

#import "ActivityView.h"

@interface ActivityView()
{
}
@end

@implementation ActivityView


+ (instancetype)sharedInstance
{
    static ActivityView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ActivityView alloc] init];
        [sharedInstance initInstance];
    });
    return sharedInstance;
}

- (void)initInstance
{
    CGFloat width = 160;
    self.waitingView = [[UIView alloc] init];
    self.childView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 120)];
    self.childView.backgroundColor = [UIColor whiteColor];
    self.childView.layer.cornerRadius = 15;
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((width - 40) / 2, 20, 40, 40)];
    [self.indicatorView startAnimating];
    self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.indicatorView setColor:[UIColor colorWithRed:0 / 255.0 green:181.0 / 255.0 blue:247.0 / 255.0 alpha:1]];
    
    self.waitingLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, width, 20)];
    [self.waitingLb setTextAlignment:NSTextAlignmentCenter];
    [self.waitingLb setFont:[UIFont systemFontOfSize:14 weight:1]];
    [self.waitingLb setTextColor:[UIColor colorWithRed:0 / 255.0 green:181.0 / 255.0 blue:247.0 / 255.0 alpha:1]];
    
    [self.waitingView addSubview:self.childView];
    [self.childView addSubview:self.indicatorView];
    [self.childView addSubview:self.waitingLb];
}

- (void)startWaiting:(UIView *)parentView text:(NSString *)waitingText
{
    CGRect viewFrame = parentView.frame;
    CGRect frame = self.childView.frame;
    self.childView.frame = CGRectMake((viewFrame.size.width - frame.size.width) / 2, (viewFrame.size.height - frame.size.height) / 2, frame.size.width, frame.size.height);
    
    [self.waitingView setFrame:parentView.frame];
    [parentView bringSubviewToFront:self.waitingView];
    [parentView addSubview:self.waitingView];
    
    self.waitingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    [self.waitingLb setText:waitingText];
    
    self.waitingView.alpha = 0;
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.waitingView.alpha = 1;
    } completion:nil];
}

- (void)stopWaiting
{
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.waitingView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.waitingView removeFromSuperview];
    }];
}


@end
