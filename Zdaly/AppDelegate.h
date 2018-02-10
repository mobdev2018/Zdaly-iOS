//
//  AppDelegate.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) NSMutableArray *graphColorArr;
@property (strong, nonatomic) UIWindow *window;
- (void)showAlert :(NSString*)title content:(NSString*)content controller:(UIViewController*)controller;
- (void)addColorsToGraphColorArr:(int)count;
- (void)showLoadDialog: (NSString*)title viewController:(UIViewController*)vc;
- (void)hideLoadDialog;
@end

