//
//  SpotPricesViewController.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import "SpotPricesViewController.h"
#import "SpotPricesTableViewCell.h"
#import "SpotPricesAdditionalTableViewCell.h"
#import "StockCommodityTableViewCell.h"
#import "ActivityView.h"
#import "APIManager.h"
#import "AppDelegate.h"

@interface SpotPricesViewController () <UITableViewDelegate, UITableViewDataSource, APIManagerListener>
{
    NSMutableArray *spotPricesArr;
    AppDelegate *appDelegate;
}
@end

@implementation SpotPricesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.tableView.tableFooterView = [[UIView alloc] init];
    spotPricesArr = [[NSMutableArray alloc] init];
    [appDelegate showLoadDialog:@"Getting spot prices.." viewController:self.mainTabVC];
    [[APIManager sharedInstance] getSpotPrices:self];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppOpenTask:) name:@"AppOpened" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)AppOpenTask:(NSNotification *)notification {
    spotPricesArr = [[NSMutableArray alloc] init];
    [appDelegate showLoadDialog:@"Getting spot prices.." viewController:self.mainTabVC];
    [[APIManager sharedInstance] getSpotPrices:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return spotPricesArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *spotPriceDict = [spotPricesArr objectAtIndex:indexPath.row];
    if([[spotPriceDict objectForKey:@"type"] isEqualToString:@"0"]) {
        return 70;
    }
    else {
        return 40;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *spotPriceDict = [spotPricesArr objectAtIndex:indexPath.row];
    if([[spotPriceDict objectForKey:@"type"] isEqualToString:@"0"]) {
        StockCommodityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StockCommodityTVC"];
        if(![[spotPriceDict objectForKey:@"Name"] isEqual:[NSNull null]]) {
            [cell.nameLb setText:[spotPriceDict objectForKey:@"Name"]];
        }
        if(![[spotPriceDict objectForKey:@"LastTradePriceOnly"] isEqual:[NSNull null]]) {
            float lastTradePriceOnly = [[spotPriceDict objectForKey:@"LastTradePriceOnly"] floatValue];
            NSString *lastTradePriceOnlyStr = [NSString stringWithFormat:@"%.2f", lastTradePriceOnly];
            CGSize textSize = [lastTradePriceOnlyStr sizeWithAttributes:@{NSFontAttributeName:[cell.originLb font]}];
            if(textSize.width < 48) {
                [cell.originWidthConst setConstant:48];
            }
            else {
                [cell.originWidthConst setConstant:textSize.width];
            }
            [cell.originLb setText:lastTradePriceOnlyStr];
        }
        if(![[spotPriceDict objectForKey:@"Change"] isEqual:[NSNull null]]) {
            [cell.changeLb setText:[spotPriceDict objectForKey:@"Change"]];
        }
        return cell;
    }
    else {
        SpotPricesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpotPricesTVC"];
        if(![[spotPriceDict objectForKey:@"Name"] isEqual:[NSNull null]]) {
            NSString *nameStr = [spotPriceDict objectForKey:@"Name"];
            CGSize textSize = [nameStr sizeWithAttributes:@{NSFontAttributeName:[cell.nameLb font]}];
            if(textSize.width < 73) {
                [cell.nameWidthConst setConstant:73];
            }
            else {
                [cell.nameWidthConst setConstant:textSize.width];
            }

            [cell.nameLb setText:[spotPriceDict objectForKey:@"Name"]];
        }
        if(![[spotPriceDict objectForKey:@"Rate"] isEqual:[NSNull null]]) {
            [cell.rateLb setText:[spotPriceDict objectForKey:@"Rate"]];
        }
        return cell;
    }
}

- (void)httpSuccess:(NSData *)data {
    [appDelegate hideLoadDialog];
    NSError *error;
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSArray *commodityArr = [resultDict objectForKey:@"commodity"];
    NSArray *stockArr = [resultDict objectForKey:@"stock"];
    NSArray *currencyArr = [resultDict objectForKey:@"currency"];
    
    for(int i = 0; i < commodityArr.count; i++) {
        NSDictionary *commodityDict = [commodityArr objectAtIndex:i];
        NSMutableDictionary *addDict = [[NSMutableDictionary alloc] initWithDictionary:commodityDict];
        [addDict setObject:@"0" forKey:@"type"];
        [spotPricesArr addObject:addDict];
    }
    
    for(int i = 0; i < stockArr.count; i++) {
        NSDictionary *stockDict = [stockArr objectAtIndex:i];
        NSMutableDictionary *addDict = [[NSMutableDictionary alloc] initWithDictionary:stockDict];
        [addDict setObject:@"0" forKey:@"type"];
        [spotPricesArr addObject:addDict];
    }
    
    for(int i = 0; i < currencyArr.count; i++) {
        NSDictionary *currencyDict = [currencyArr objectAtIndex:i];
        NSMutableDictionary *addDict = [[NSMutableDictionary alloc] initWithDictionary:currencyDict];
        [addDict setObject:@"1" forKey:@"type"];
        [spotPricesArr addObject:addDict];
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

@end
