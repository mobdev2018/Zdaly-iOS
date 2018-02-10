//
//  AppDelegate.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import "AppDelegate.h"
#import "GraphShowViewController.h"
#import "LoadDialogViewController.h"
@interface AppDelegate ()
{
    LoadDialogViewController *loadDialogVC;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //[application setStatusBarHidden:YES];
    NSArray *initialColors = @[[UIColor colorWithRed:103.0 / 255.0 green:183.0 / 255.0 blue:220.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:253.0 / 255.0 green:212.0 / 255.0 blue:0.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:132.0 / 255.0 green:183.0 / 255.0 blue:97.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:204.0 / 255.0 green:71.0 / 255.0 blue:72.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:205.0 / 255.0 green:130.0 / 255.0 blue:173.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:47.0 / 255.0 green:64.0 / 255.0 blue:116.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:68.0 / 255.0 green:142.0 / 255.0 blue:77.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:124.0 / 255.0 green:35.0 / 255.0 blue:0.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:232.0 / 255.0 green:13.0 / 255.0 blue:97.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:24.0 / 255.0 green:71.0 / 255.0 blue:172.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:105.0 / 255.0 green:230.0 / 255.0 blue:173.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:47.0 / 255.0 green:164.0 / 255.0 blue:116.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:225.0 / 255.0 green:230.0 / 255.0 blue:73.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:147.0 / 255.0 green:64.0 / 255.0 blue:126.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:168.0 / 255.0 green:42.0 / 255.0 blue:77.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:124.0 / 255.0 green:235.0 / 255.0 blue:80.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:132.0 / 255.0 green:113.0 / 255.0 blue:7.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:214.0 / 255.0 green:111.0 / 255.0 blue:12.0 / 255.0 alpha:1],
                           [UIColor colorWithRed:75.0 / 255.0 green:100.0 / 255.0 blue:73.0 / 255.0 alpha:1]];
    self.graphColorArr = [[NSMutableArray alloc] initWithArray:initialColors];
    return YES;
}

- (void)showLoadDialog: (NSString*)title viewController:(UIViewController*)vc{
    UIStoryboard *mainBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    loadDialogVC = [mainBoard instantiateViewControllerWithIdentifier:@"LoadDialogVC"];
    loadDialogVC.contentStr = title;
    [vc addChildViewController:loadDialogVC];
    loadDialogVC.view.frame = vc.view.frame;
    [vc.view addSubview:loadDialogVC.view];
    loadDialogVC.view.alpha = 0;
    [loadDialogVC didMoveToParentViewController:vc];
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        loadDialogVC.view.alpha = 1;
    }completion:nil];
}

- (void)hideLoadDialog {
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        loadDialogVC.view.alpha = 0;
        
    }completion:^(BOOL finished) {
        [loadDialogVC.view removeFromSuperview];
    }];
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if ([self.window.rootViewController.presentedViewController isKindOfClass:[GraphShowViewController class]])
    {
        GraphShowViewController *graphShowVC = (GraphShowViewController *) self.window.rootViewController.presentedViewController;
        
        if (graphShowVC.isPresented)
        {
            return UIInterfaceOrientationMaskLandscapeLeft;
        }
        else return UIInterfaceOrientationMaskPortrait;
    }
    else return UIInterfaceOrientationMaskPortrait;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AppOpened" object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)showAlert :(NSString*)title content:(NSString*)content controller:(UIViewController*)controller{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okButton];
    [controller presentViewController:alert animated:YES completion:nil];
}

- (void)addColorsToGraphColorArr:(int)count {
    for(int i = 0; i < count; i++) {
        float r = rand() % 255;
        float g = rand() % 255;
        float b = rand() % 255;
        UIColor *newColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
        [self.graphColorArr addObject:newColor];
    }
}

@end
