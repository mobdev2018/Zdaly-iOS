//
//  LoadDialogViewController.m
//  Zdaly
//
//  Created by AAA on 2017. 10. 31..
//  Copyright © 2017년 com. All rights reserved.
//

#import "LoadDialogViewController.h"
#import "SDWebImageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LoadDialogViewController ()

@end

@implementation LoadDialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dialogView.layer.cornerRadius = 5;
    [self.contentLb setText:self.contentStr];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:@"id"];
    NSURL *logoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://74.63.228.198/DownloadCsv/%@.jpg", userId]];
    [self.logoIv sd_setImageWithURL:logoUrl placeholderImage:[UIImage imageNamed:@"top_logo"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
