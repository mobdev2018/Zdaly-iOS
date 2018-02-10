//
//  DailyNewsViewController.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabViewController.h"

@interface DailyNewsViewController : UIViewController <UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *newsSearchBar;
@property (nonatomic, strong) MainTabViewController *mainTabVC;
@property (strong, nonatomic) IBOutlet UIView *selectAllView;
@property (strong, nonatomic) IBOutlet UIButton *selectAlleBtn;
@property (strong, nonatomic) IBOutlet UIButton *shareSelectedNewsBtn;
@property (strong, nonatomic) IBOutlet UIView *nextBtnView;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIView *previousBtnView;
@property (strong, nonatomic) IBOutlet UIButton *previousBtn;
@property (strong, nonatomic) IBOutlet UIButton *homeBtn;
@property (nonatomic, assign) BOOL isSearchEnabled;
- (IBAction)selectAllClicked:(UIButton *)sender;
- (IBAction)previousClicked:(UIButton *)sender;
- (IBAction)nextClicked:(UIButton *)sender;
- (IBAction)homeClicked:(UIButton *)sender;
- (IBAction)shareSelectedSearchedNewsClicked:(UIButton *)sender;
@end
