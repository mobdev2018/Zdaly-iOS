//
//  DailyNewsViewController.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import "DailyNewsViewController.h"
#import "DailyNewsTableViewCell.h"
#import "ActivityView.h"
#import "APIManager.h"
#import "AppDelegate.h"
@interface DailyNewsViewController () <UITableViewDelegate, UITableViewDataSource, APIManagerListener, DailyNewsCellDelegate>
{
    NSArray *newsArr;
    NSMutableArray *searchedNewsArr;
    NSMutableArray *searchedNewsToShareArr;
    AppDelegate *appDelegate;
    UIView *disableViewOverlay;
}
@end

@implementation DailyNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    newsArr = [[NSArray alloc] init];
    [self configureComponentLayout];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppOpenTask:) name:@"AppOpened" object:nil];
}

-(void)configureComponentLayout {
    [self apiCallToGetDailyNewsData];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor whiteColor]];
    [self initializeSearchCollections];
    [self setupDisableViewOverlayView];
    self.selectAlleBtn.layer.cornerRadius = 6.0;
    self.selectAllView.layer.cornerRadius = 6.0;
    self.selectAllView.layer.borderWidth = 1.0;
    self.selectAllView.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self hideSelectAllViewFromBottomBar];
}

-(void)apiCallToGetDailyNewsData {
    self.previousBtn.tag = 0;
    self.nextBtn.tag = 0;
    [appDelegate showLoadDialog:@"Latest News.." viewController:self.mainTabVC];
    [[APIManager sharedInstance] getDailyNews:self];
}

- (void)initializeSearchCollections {
    searchedNewsArr = [[NSMutableArray alloc] init];
    searchedNewsToShareArr = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)AppOpenTask:(NSNotification *)notification {
    newsArr = [[NSArray alloc] init];
    [self configureComponentLayout];
    [appDelegate showLoadDialog:@"Latest News.." viewController:self.mainTabVC];
    [[APIManager sharedInstance] getDailyNews:self];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.isSearchEnabled ? searchedNewsArr.count : newsArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DailyNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DailyNewsTVC"];
    
    NSDictionary *newsDict = self.isSearchEnabled ? [searchedNewsArr objectAtIndex:indexPath.row] : [newsArr objectAtIndex:indexPath.row];
    
    NSString *titleStr = [newsDict objectForKey:@"TITLE"];
    NSString *contentStr = [newsDict objectForKey:@"DES"];
    
    UIFont *titleFont = cell.titleLb.font;
    CGSize titleSize = [titleStr boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 59, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: titleFont} context:nil].size;
    
    UIFont *contentFont = cell.contentLb.font;
    CGSize contentSize = [contentStr boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 16, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: contentFont} context:nil].size;
    return titleSize.height + contentSize.height + 24 + 2 + 36;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DailyNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DailyNewsTVC"];
    cell.delegate = self;
    cell.tag = indexPath.row;
    
    NSDictionary *newsDict = self.isSearchEnabled ? [searchedNewsArr objectAtIndex:indexPath.row] : [newsArr objectAtIndex:indexPath.row];
    NSString *titleStr = [[newsDict objectForKey:@"TITLE"] isKindOfClass:[NSNull class]] ? @"" : [newsDict objectForKey:@"TITLE"];
    NSString *contentStr = [[newsDict objectForKey:@"DES"] isKindOfClass:[NSNull class]] ? @"" : [newsDict objectForKey:@"DES"];
    NSString *sourceStr = [[newsDict objectForKey:@"SOURCE"] isKindOfClass:[NSNull class]] ? @"" : [newsDict objectForKey:@"SOURCE"];
    NSString *dateStr = [[newsDict objectForKey:@"DATE"] isKindOfClass:[NSNull class]] ? @"" : [newsDict objectForKey:@"DATE"];
    
    UIFont *titleFont = cell.titleLb.font;
    CGSize titleSize = [titleStr boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 16, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: titleFont} context:nil].size;
    [cell.titleHeightConst setConstant:titleSize.height + 1];

    [cell.titleLb setText:titleStr];
    [cell.contentLb setText:contentStr];
    [cell.shareBt setTag:indexPath.row];
    [cell.sourceLb setText:sourceStr];
    [cell.dateLb setText:dateStr];
    
    if (self.isSearchEnabled) {
        [cell.selectCheckBox setHidden:NO];
        [cell.dateLb setHidden:NO];
        [cell.shareBt setHidden:YES];
        [cell.contentBottomConst setConstant:58.0];
        [searchedNewsToShareArr containsObject:newsDict] ? [cell.selectCheckBox setImage:[UIImage imageNamed:@"icon_check"] forState:UIControlStateNormal] : [cell.selectCheckBox setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else {
        [cell.selectCheckBox setHidden:YES];
        [cell.dateLb setHidden:YES];
        [cell.contentBottomConst setConstant:30.0];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *newsDict = self.isSearchEnabled ? [searchedNewsArr objectAtIndex:indexPath.row] : [newsArr objectAtIndex:indexPath.row];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.mainTabVC showDailyNewsWebView:newsDict];
}

- (IBAction)shareClicked:(id)sender {
    UIButton *shareBt = (UIButton*)sender;
    NSInteger shareIndex = shareBt.tag;
    NSDictionary *newsDict = [newsArr objectAtIndex:shareIndex];

    NSArray *activityItems = [NSArray arrayWithObjects:(NSString*)[newsDict objectForKey:@"TITLE"], [NSURL URLWithString:(NSString*)[newsDict objectForKey:@"LINK"]], nil];
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

- (void)httpSuccess:(NSData *)data {
    
    [appDelegate hideLoadDialog];
    NSError *error;
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if([[resultDict objectForKey:@"state"] isEqualToString:@"success"]) {
        
        if(![[resultDict objectForKey:@"result"] isEqual:[NSNull null]]) {

            [self hideDisableViewOverlay];

            if (self.isSearchEnabled) {
                [searchedNewsArr removeAllObjects];
                [searchedNewsToShareArr removeAllObjects];
                if ([[resultDict objectForKey:@"result"] isKindOfClass:[NSArray class]]) {
                    [searchedNewsArr addObjectsFromArray:[resultDict objectForKey:@"result"]];
                }else {
                    [self showNoDataLabelOnTableViewBackground:@"Sorry! No search result found."];
                }
            }else {
                newsArr = [resultDict objectForKey:@"result"];
            }
        }
        
    }else {
        newsArr = [[NSArray alloc] init];
        [self showNoDataLabelOnTableViewBackground:@"Sorry! No data found."];
        //[appDelegate showAlert:@"McDermott" content:@"Sorry! No data found." controller:self.mainTabVC];
    }
    [self.tableView reloadData];
}

- (void)httpError:(NSError *)error {
    [appDelegate hideLoadDialog];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - DailyNewsCellDelegate Methods

- (void)getSelectedIndexOfCheckBox:(NSInteger)intIndex {
    NSDictionary *newsDict = [searchedNewsArr objectAtIndex:intIndex];
    [searchedNewsToShareArr containsObject:newsDict] ? [searchedNewsToShareArr removeObject:newsDict] : [searchedNewsToShareArr addObject:newsDict];
    [self.tableView reloadData];
}

#pragma mark - Select All Bottom Bar view methods

-(void)showSelectAllViewOnBottomBar {
    [self.nextBtnView setHidden:YES];
    [self.previousBtnView setHidden:YES];
    [self.homeBtn setHidden:YES];
    [self.selectAllView setHidden:NO];
    [self.shareSelectedNewsBtn setHidden:NO];
}

-(void)hideSelectAllViewFromBottomBar {
    [self.nextBtnView setHidden:NO];
    [self.previousBtnView setHidden:NO];
    [self.homeBtn setHidden:NO];
    [self.shareSelectedNewsBtn setHidden:YES];
    [self.selectAllView setHidden:YES];
    [self initializeSearchCollections];
}

#pragma mark - Disable search overlay methods

-(void)setupDisableViewOverlayView {
    disableViewOverlay = [[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height + 40)];
    disableViewOverlay.backgroundColor=[UIColor blackColor];
    disableViewOverlay.alpha = 0;
}

-(void)showDisableViewOverlay {
    disableViewOverlay.alpha = 0;
    [self.view addSubview:disableViewOverlay];
    [UIView beginAnimations:@"FadeIn" context:nil];
    [UIView setAnimationDuration:0.5];
    disableViewOverlay.alpha = 0.6;
    [UIView commitAnimations];
}

-(void)hideDisableViewOverlay {
    [disableViewOverlay removeFromSuperview];
}

#pragma mark - Button tap actions

- (IBAction)selectAllClicked:(UIButton *)sender {
    if (sender.tag) {
        sender.tag = 0;
        [self.selectAlleBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [searchedNewsToShareArr removeAllObjects];
    }else {
        sender.tag = 1;
        [self.selectAlleBtn setImage:[UIImage imageNamed:@"icon_check"] forState:UIControlStateNormal];
        [searchedNewsToShareArr removeAllObjects];
        [searchedNewsToShareArr addObjectsFromArray:searchedNewsArr];
    }
    [self.tableView reloadData];
}

- (IBAction)shareSelectedSearchedNewsClicked:(UIButton *)sender {
    
    if ([searchedNewsToShareArr count]) {
        
        NSMutableArray *activityItems = [[NSMutableArray alloc] init];
        
        [activityItems addObject:[[NSMutableAttributedString alloc] initWithData: [@"<!doctype html><html><body><br>" dataUsingEncoding:NSUnicodeStringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes: nil error: nil ]];
        
        for (int i = 0; i < [searchedNewsToShareArr count]; i++) {
            
            NSDictionary *newsDict = [searchedNewsToShareArr objectAtIndex:i];
        
            NSString *titleString = [NSString stringWithFormat:@"<div style='font-size: 12px; color: #3d86c7;'><a href='%@'>%@</a></div>",(NSString *)[newsDict objectForKey:@"LINK"], (NSString *)[newsDict objectForKey:@"TITLE"]];
            NSString *sourceString = [NSString stringWithFormat:@"<div style='font-weight: bold;'>%@</div>",(NSString *)[newsDict objectForKey:@"SOURCE"]];
            NSString *descString = [NSString stringWithFormat:@"<div style='text-align: justify;'>%@</div>",(NSString *)[newsDict objectForKey:@"DES"]];
            NSString *dateString = [NSString stringWithFormat:@"<div>%@</div>",(NSString *)[newsDict objectForKey:@"DATE"]];
            
            NSString *totalHtml = [NSString stringWithFormat:@"<div style='font-size:10px; font-family: sans-serif; color: #000;'>%@%@%@%@</div>",titleString,sourceString,descString,dateString];
            
            [activityItems addObject:[[NSMutableAttributedString alloc] initWithData: [totalHtml dataUsingEncoding:NSUnicodeStringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes: nil error: nil ]];
        }
        [activityItems addObject:[[NSMutableAttributedString alloc] initWithData: [@"</body></html>" dataUsingEncoding:NSUnicodeStringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes: nil error: nil ]];
        
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        activityViewController.excludedActivityTypes = @[UIActivityTypePostToTwitter];
        activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [activityViewController setValue:[NSString stringWithFormat:@"Searched news for %@",self.newsSearchBar.text] forKey:@"subject"];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [self presentViewController:activityViewController animated:YES completion:nil];
        }else {
            // Change Rect to position Popover
            UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
            [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }else {
        [appDelegate showAlert:@"McDermott" content:@"Please select atleast one news to share." controller:self];
    }
}

- (IBAction)previousClicked:(UIButton *)sender {
    sender.tag = (sender.tag + 1);
    self.nextBtn.tag = (sender.tag - 1);
    // API Call to get filtered News
    [self apiCallToGetFilteredNewsOf_date:[self getPreviousAndNextDateBy:sender.tag]];
}

- (IBAction)nextClicked:(UIButton *)sender {
    if (sender.tag != 0) {
        // API Call to get filtered News
        [self apiCallToGetFilteredNewsOf_date:[self getPreviousAndNextDateBy:sender.tag]];
        self.previousBtn.tag = sender.tag;
        sender.tag = sender.tag - 1;
    }else{
        /*
        if (self.previousBtn.tag == 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [appDelegate showAlert:@"McDermott" content:@"Sorry! You can't see the news of above the today's date." controller:self];
            });
        }*/
        [self apiCallToGetDailyNewsData];
    }
}

- (IBAction)homeClicked:(UIButton *)sender {
    [self apiCallToGetDailyNewsData];
}

#pragma mark - Common methods

-(void)apiCallToGetFilteredNewsOf_date:(NSString *)date {
    [appDelegate showLoadDialog:[NSString stringWithFormat:@"Getting news on %@",date] viewController:self.mainTabVC];
    [[APIManager sharedInstance] getFilteredNews:self dateFilter:date];
}

-(void)apiCallToGetSearchedNewsOf_term:(NSString *)searchTerm {
    [appDelegate showLoadDialog:[NSString stringWithFormat:@"Searching for %@",searchTerm] viewController:self.mainTabVC];
    [[APIManager sharedInstance] getSearchedNews:self searchTerm:searchTerm];
}

-(NSString *)getPreviousAndNextDateBy:(NSInteger)intDayCount {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *comp = [cal components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:now];
    comp.timeZone=[NSTimeZone defaultTimeZone];
    comp.month = comp.month;
    comp.year = comp.year;
    comp.day = comp.day - intDayCount;
    [comp setHour:0];
    [comp setMinute:0];
    [comp setSecond:0];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    return [format stringFromDate:[cal dateFromComponents:comp]];
}

-(void)showNoDataLabelOnTableViewBackground:(NSString *)noDataText {
    UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
    [noDataLabel setText:noDataText];
    [noDataLabel setFont:[UIFont systemFontOfSize:15.0]];
    [noDataLabel setTextAlignment:NSTextAlignmentCenter];
    [noDataLabel setTextColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1]];
    [noDataLabel sizeToFit];
    [self.tableView setBackgroundView:noDataLabel];
}

-(void)hideNoDataLabelFromTableViewBackground {
    [self.tableView setBackgroundView:nil];
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    [self showDisableViewOverlay];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isSearchEnabled = NO;
        [searchBar setText:@""];
        [searchBar resignFirstResponder];
        [searchBar setShowsCancelButton:NO animated:YES];
        [self hideDisableViewOverlay];
        [self hideSelectAllViewFromBottomBar];
        [self apiCallToGetDailyNewsData];
    });
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isSearchEnabled = YES;
        [searchBar resignFirstResponder];
        [searchBar setShowsCancelButton:NO animated:YES];
        [self hideDisableViewOverlay];
        [self showSelectAllViewOnBottomBar];
        // API Call to get searched News
        [self apiCallToGetSearchedNewsOf_term:searchBar.text];
    });
}

@end
