//
//  KeyTrendsViewController.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import "KeyTrendsViewController.h"
#import "KeyTrendsTableViewCell.h"
#import "GraphShowViewController.h"
#import "ActivityView.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface KeyTrendsViewController () <UITableViewDelegate, UITableViewDataSource, APIManagerListener>
{
    int tabIndex;
    NSMutableArray *industryArr;
    NSMutableArray *pricesArr;
    NSMutableArray *economyArr;
    AppDelegate *appDelegate;
    
    NSMutableArray *headerTitleArr;
    NSMutableArray *headerButtonsArr;
    NSMutableDictionary *headerWithDataDict;
}
@end

@implementation KeyTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.underlineWidthConst setConstant: self.view.frame.size.width / 3];
    tabIndex = 0;
    [self getEachTabGraphInfo];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppOpenTask:) name:@"AppOpened" object:nil];
}

- (void)AppOpenTask:(NSNotification *)notification {
    [self getEachTabGraphInfo];
}

- (void)getEachTabGraphInfo {
    
    headerTitleArr = [[NSMutableArray alloc] init];
    headerButtonsArr = [[NSMutableArray alloc] init];
    headerWithDataDict = [[NSMutableDictionary alloc] init];
    
    industryArr = [[NSMutableArray alloc] init];
    pricesArr = [[NSMutableArray alloc] init];
    economyArr = [[NSMutableArray alloc] init];
    [appDelegate showLoadDialog:@"Getting trends.." viewController:self.mainTabVC];
    [[APIManager sharedInstance] getKeyTrends:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /*
    if(tabIndex == 0) {
        return industryArr.count;
    }
    else if(tabIndex == 1) {
        return pricesArr.count;;
    }
    else {
        return economyArr.count;
    }*/
    return [headerTitleArr count] ? [[headerWithDataDict objectForKey:[headerTitleArr objectAtIndex:tabIndex]] count] : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 320;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KeyTrendsTableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:@"KeyTrendsTVC"];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"GraphView" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    /*
    NSDictionary *graphDict;
    if(tabIndex == 0) {
        graphDict = [industryArr objectAtIndex:indexPath.row];
    }
    else if(tabIndex == 1) {
        graphDict = [pricesArr objectAtIndex:indexPath.row];
    }
    else {
        graphDict = [economyArr objectAtIndex:indexPath.row];
    }
    */
    NSDictionary *graphDict = [[headerWithDataDict objectForKey:[headerTitleArr objectAtIndex:tabIndex]] objectAtIndex:indexPath.row];
    cell.graphDict = graphDict;
    cell.keyTrendsVC = self;
    return cell;
}

- (IBAction)zoomClicked:(id)sender {
    UIStoryboard *mainBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GraphShowViewController *graphShowVC = [mainBoard instantiateViewControllerWithIdentifier:@"GraphShowVC"];
    [self presentViewController:graphShowVC animated:YES completion:nil];
}


- (IBAction)firstTabClicked:(id)sender {
    tabIndex = 0;
    [self.underlineLeftConst setConstant:0];
    [self setTabButton];
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (IBAction)secondTabClicked:(id)sender {
    tabIndex = 1;
    UIButton *secondTabBt = (UIButton*)sender;
    [self.underlineLeftConst setConstant:secondTabBt.frame.origin.x];
    [self setTabButton];
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:YES];
}

- (IBAction)thirdTabClicked:(id)sender {
    tabIndex = 2;
    UIButton *thirdTabBt = (UIButton*)sender;
    [self.underlineLeftConst setConstant:thirdTabBt.frame.origin.x];
    [self setTabButton];
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)setTabButton {
    if(tabIndex == 0) {
        [self.firstTabBt setTitleColor:[UIColor colorWithRed:0.903512 green:0.258715 blue:0.263742 alpha:1] forState:UIControlStateNormal];
        [self.secondTabBt setTitleColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1] forState:UIControlStateNormal];
        [self.thirdTabBt setTitleColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1] forState:UIControlStateNormal];
    }
    else if(tabIndex == 1) {
        [self.firstTabBt setTitleColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1] forState:UIControlStateNormal];
        [self.secondTabBt setTitleColor:[UIColor colorWithRed:0.903512 green:0.258715 blue:0.263742 alpha:1] forState:UIControlStateNormal];
        [self.thirdTabBt setTitleColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1] forState:UIControlStateNormal];
    }
    else {
        [self.firstTabBt setTitleColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1] forState:UIControlStateNormal];
        [self.secondTabBt setTitleColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1] forState:UIControlStateNormal];
        [self.thirdTabBt setTitleColor:[UIColor colorWithRed:0.903512 green:0.258715 blue:0.263742 alpha:1] forState:UIControlStateNormal];
    }
}

- (void)httpSuccess:(NSData *)data {
    int maxColorCnt = 0;
    [appDelegate hideLoadDialog];
    NSError *error;
    NSArray *graphArr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    for(int i = 0; i < graphArr.count; i++) {
        NSDictionary *graphDict = [graphArr objectAtIndex:i];
        NSArray *configurationArr = [graphDict objectForKey:@"configuration"];
        if(configurationArr.count > maxColorCnt) {
            maxColorCnt = (int)configurationArr.count;
        }
        if(![[graphDict objectForKey:@"type"] isEqual:[NSNull null]]) {
            if([[graphDict objectForKey:@"type"] isEqualToString:@"Industry"]) {
                [industryArr addObject:graphDict];
            }
            else if([[graphDict objectForKey:@"type"] isEqualToString:@"Prices"]) {
                [pricesArr addObject:graphDict];
            }
            else {
                [economyArr addObject:graphDict];
            }
        }
        
        //New Implementation Goes here
        
        NSString *type = [[NSString alloc] initWithString:[graphDict objectForKey:@"type"]];
        if(![type isEqual:[NSNull null]] && ![type isEqualToString:@""]) {
            if (![headerTitleArr containsObject:type]){
                [headerTitleArr addObject:type];
                NSIndexSet *indexes = [graphArr indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                    return [obj[@"type"] isEqualToString:type];
                }];
                if (indexes.count != 0) {
                    [headerWithDataDict setObject:[graphArr objectsAtIndexes:indexes] forKey:type];
                }
            }
        }
    }
    
    [self createDynamicScrollView];
    
    if(maxColorCnt > appDelegate.graphColorArr.count) {
        [appDelegate addColorsToGraphColorArr:maxColorCnt - (int)appDelegate.graphColorArr.count];
    }
    [self.tableView reloadData];
}

- (void)httpError:(NSError *)error {
    [appDelegate hideLoadDialog];
}

#pragma mark - Dynamic ScrollView Methods

-(void)createDynamicScrollView {
    NSUInteger i;
    int xCoord = 2;
    int yCoord = 0;
    int buttonHeight = 48;
    int buffer = 5;
    UIColor *rColor = [UIColor colorWithRed:0.903512 green:0.258715 blue:0.263742 alpha:1];
    UIColor *bColor = [UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1];
    
    for (i = 0; i < [headerTitleArr count]; i++) {
        
        NSString *title = [[NSString alloc] initWithString:[headerTitleArr objectAtIndex:i]];
        CGSize textSize = [title sizeWithAttributes:@{ NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
        
        UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
        barButton.frame = CGRectMake(xCoord, yCoord, textSize.width, buttonHeight);
        barButton.tag = i;
        [barButton setTitle:title forState:UIControlStateNormal];
        barButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [barButton addTarget:self action:@selector(dynamicHeaderTap:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, barButton.frame.size.height - 4, barButton.frame.size.width, 4)];
        if (i == 0) {
            lineView.backgroundColor = rColor;
            [barButton setTitleColor:rColor forState:UIControlStateNormal];
        }else {
            [barButton setTitleColor:bColor forState:UIControlStateNormal];
            [barButton setBackgroundColor:[UIColor whiteColor]];
            lineView.backgroundColor = [UIColor whiteColor];
        }
        [barButton addSubview:lineView];

        [headerButtonsArr addObject:barButton];
        [self.headerScrollView addSubview:barButton];
        
        xCoord += textSize.width + buffer;
    }
    [self.headerScrollView setContentSize:CGSizeMake(xCoord - 2, self.headerScrollView.frame.size.height)];
    tabIndex = 0;
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)dynamicHeaderTap:(UIButton *)sender {
    UIColor *rColor = [UIColor colorWithRed:0.903512 green:0.258715 blue:0.263742 alpha:1];
    UIColor *bColor = [UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1];
    for (NSUInteger i = 0; i < [headerButtonsArr count]; i++) {
        UIButton *eachBtn = (UIButton *)[headerButtonsArr objectAtIndex:i];
        [eachBtn setTitleColor:bColor forState:UIControlStateNormal];
        [[eachBtn.subviews objectAtIndex:1] setBackgroundColor:[UIColor whiteColor]];
    }
    [sender setTitleColor:rColor forState:UIControlStateNormal];
    [[sender.subviews objectAtIndex:1] setBackgroundColor:rColor];
    tabIndex = (int)sender.tag;
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
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
