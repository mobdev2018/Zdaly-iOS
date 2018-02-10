//
//  DailyNewsWebViewController.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import "DailyNewsWebViewController.h"

@interface DailyNewsWebViewController () <UIWebViewDelegate>

@end

@implementation DailyNewsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *websiteUrl = [NSURL URLWithString:[self.newsDict objectForKey:@"LINK"]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityView stopAnimating];
}

- (IBAction)shareClicked:(id)sender {
    NSArray *activityItems = [NSArray arrayWithObjects:(NSString*)[self.newsDict objectForKey:@"TITLE"], [NSURL URLWithString:(NSString*)[self.newsDict objectForKey:@"LINK"]], nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToTwitter];
    activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:activityViewController animated:YES completion:nil];
    }
    //if iPad
    else {
        // Change Rect to position Popover
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
        [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }

}


- (IBAction)backClicked:(id)sender {
    [self.mainTabVC removeDailyNewsWebView];
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
