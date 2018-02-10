//
//  ViewController.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import "ViewController.h"
#import "LoginDialogViewController.h"

@interface ViewController () <UITextFieldDelegate>
{
    BOOL termAgreed;
    NSUserDefaults *defaults;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.userNameBackLb.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.userNameBackLb.layer.borderWidth = 1;
    self.passwordBackLb.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.passwordBackLb.layer.borderWidth = 1;
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *savedEmail = [defaults objectForKey:@"email"];
    NSString *savedPassword = [defaults objectForKey:@"password"];
    if(savedEmail != nil && savedPassword != nil) {
        [self.nameField setText:savedEmail];
        [self.passwordField setText:savedPassword];
        [self doLogin];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)termsClicked:(id)sender {
    UIApplication *myApplication = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"https://www.zdaly.com/home/termsAndCondition"];
    NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @NO};
    [myApplication openURL:url options:options completionHandler:nil];
}

- (IBAction)agreeClicked:(id)sender {
    termAgreed = !termAgreed;
    if(termAgreed) {
        [self.checkIv setImage:[UIImage imageNamed:@"check"]];
    }
    else {
        [self.checkIv setImage:[UIImage imageNamed:@"un_check"]];
    }
}


- (IBAction)loginClicked:(id)sender {
    [self.view endEditing:YES];
    if(termAgreed) {
        [self doLogin];
    }
    else {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Warning"
                                     message:@"You need to agree with Zdaly terms of usage in order to login."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okBt = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        
        [alert addAction:okBt];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)doLogin {
    UIStoryboard *mainBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginDialogViewController *loginDialogVC = [mainBoard instantiateViewControllerWithIdentifier:@"LoginDialogVC"];
    loginDialogVC.loginVC = self;
    [self addChildViewController:loginDialogVC];
    loginDialogVC.view.frame = self.view.frame;
    [self.view addSubview:loginDialogVC.view];
    loginDialogVC.view.alpha = 0;
    [loginDialogVC didMoveToParentViewController:self];
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        loginDialogVC.view.alpha = 1;
    }completion:nil];
}

@end
