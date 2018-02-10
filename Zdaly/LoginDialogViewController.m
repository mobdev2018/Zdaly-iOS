//
//  LoginDialogViewController.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import "LoginDialogViewController.h"
#import "MainTabViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "SharedData.h"
#import "SDWebImageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LoginDialogViewController () <APIManagerListener>
{
    AppDelegate *appDelegate;
    NSUserDefaults *defaults;
}
@end

@implementation LoginDialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:@"id"];
    NSURL *logoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://74.63.228.198/DownloadCsv/%@.jpg", userId]];
    [self.logoIv sd_setImageWithURL:logoUrl placeholderImage:[UIImage imageNamed:@"top_logo"]];
    
    self.dialogView.layer.cornerRadius = 5;
    [[APIManager sharedInstance] authenticateUser:self email:self.loginVC.nameField.text password:self.loginVC.passwordField.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)httpSuccess:(NSData *)data {
    NSError *error;
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if([[resultDict objectForKey:@"state"] isEqualToString:@"success"]) {
        NSString *userId = [resultDict objectForKey:@"result"];
        [SharedData sharedInstance].userId = userId;
        [SharedData sharedInstance].token = [resultDict objectForKey:@"token"];
        NSURL *logoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://74.63.228.198/DownloadCsv/%@.jpg", userId]];
        [self.logoIv sd_setImageWithURL:logoUrl placeholderImage:[UIImage imageNamed:@"top_logo"]];
        
        UIStoryboard *mainBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MainTabViewController *mainTabVC = [mainBoard instantiateViewControllerWithIdentifier:@"MainTabVC"];
        [self.loginVC.navigationController pushViewController:mainTabVC animated:YES];
        [defaults setObject:self.loginVC.nameField.text forKey:@"email"];
        [defaults setObject:self.loginVC.passwordField.text forKey:@"password"];
        [defaults setObject:userId forKey:@"id"];
    }
    else {
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.view.alpha = 0;
            
        }completion:^(BOOL finished) {
            [self.view removeFromSuperview];
            [appDelegate showAlert:@"Warning" content:@"Login failed and try again." controller:self.loginVC];
        }];
    }
}

- (void)httpError:(NSError *)error {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
