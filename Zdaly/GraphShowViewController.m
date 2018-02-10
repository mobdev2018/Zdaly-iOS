//
//  GraphShowViewController.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 26..
//  Copyright © 2017년 com. All rights reserved.
//

#import "GraphShowViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "CustomLineView.h"
#import "UIColor+HexString.h"
@interface GraphShowViewController ()
{
    BOOL graphDrawn;
}
@end

@implementation GraphShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeLeft) forKey:@"orientation"];
    graphDrawn = NO;
    self.isPresented = YES;
}

- (void)viewDidLayoutSubviews {
    if(!graphDrawn) {
        [self drawGraph];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backClicked:(id)sender {
    self.isPresented = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareClicked:(id)sender {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - 37), NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - 37));
    }
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    NSArray *activityItems = @[@"", (UIImage*)image];
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


- (void)drawGraph {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    int screenHeight;
    if(self.view.frame.size.height < self.view.frame.size.width) {
        screenHeight = self.view.frame.size.height;
    }
    else {
        screenHeight = self.view.frame.size.width;
    }
    
    int scrollHeight = screenHeight - 146 - 8;
    [self.scrollHeightConst setConstant:scrollHeight];
    
    int barWidth = 20;
    int barSpace = 4;
    int barGroupSpace = 16;
    int startOffset = 64;
    int yAxisHeight = (scrollHeight - 62) - 2;
    int columnCnt = 0;
    
    BOOL isStack = [[self.graphDict objectForKey:@"isStack"] boolValue];
    
    [self.titleLb setText:[self.graphDict objectForKey:@"title"]];
    UIFont *font = [UIFont systemFontOfSize:12.0];
    int barDescColorLbWidth = 30; // Width of bar description color label
    NSArray *configurationArr = [self.graphDict objectForKey:@"configuration"];
    
    float minYAxis;
    float maxYAxis;
    NSMutableArray *yAxisStrArr = [[NSMutableArray alloc] init];
    
    //================================================================
    //=============     Configure Descrption Section     =============
    //================================================================
    
    //----------------Calculate max width of bar description label and column count-------------
    int barDescLbWidth = 0;
    for(int i = 0; i < configurationArr.count; i++) {
        NSDictionary *configurationDict = [configurationArr objectAtIndex:i];
        NSString *title = [configurationDict objectForKey:@"title"];
        CGSize labelSize = [title sizeWithAttributes:@{NSFontAttributeName: font}];
        if(labelSize.width > barDescLbWidth) {
            barDescLbWidth = labelSize.width + 1;
        }
        
        NSString *type = [configurationDict objectForKey:@"type"];
        if([type isEqualToString:@"column"]) {
            columnCnt ++;
        }
    }
    if(isStack) {
        columnCnt = 1;
    }
    
    int topLayerChildCnt;
    if(configurationArr.count % 2 == 0) {
        topLayerChildCnt = (int)configurationArr.count / 2;
    }
    else {
        topLayerChildCnt = (int)configurationArr.count / 2 + 1;
    }
    for(int i = 0; i < configurationArr.count; i++) {
        NSDictionary *configurationDict = [configurationArr objectAtIndex:i];
        NSString *title = [configurationDict objectForKey:@"title"];
        NSString *type = [configurationDict objectForKey:@"type"];
        
        UIColor *fillColors = [configurationDict objectForKey:@"fillColors"] ? [UIColor colorWithHexString:[configurationDict objectForKey:@"fillColors"]] : [appDelegate.graphColorArr objectAtIndex:i];
        
        UIColor *lineColor = [configurationDict objectForKey:@"lineColor"] ? [UIColor colorWithHexString:[configurationDict objectForKey:@"lineColor"]] : [appDelegate.graphColorArr objectAtIndex:i];
        
        UILabel *barDescColorLb = [[UILabel alloc] init];
        UILabel *barDescLb = [[UILabel alloc] init];
        if(i < topLayerChildCnt) {
            if([type isEqualToString:@"column"]) {
                [barDescColorLb setFrame:CGRectMake(8 + i * (barDescColorLbWidth + 4 + barDescLbWidth + 8), 8, barDescColorLbWidth, 12)];
                [barDescColorLb setBackgroundColor:fillColors];
            }
            else {
                [barDescColorLb setFrame:CGRectMake(8 + i * (barDescColorLbWidth + 4 + barDescLbWidth + 8), 14, barDescColorLbWidth, 1)];
                [barDescColorLb setBackgroundColor:lineColor];
                UILabel *circleLb = [[UILabel alloc] initWithFrame:CGRectMake(8 + i * (barDescColorLbWidth + 4 + barDescLbWidth + 8) + (barDescColorLbWidth - 7) / 2, 11, 7, 7)];
                circleLb.layer.cornerRadius = 3.5;
                circleLb.clipsToBounds = YES;
                [circleLb setBackgroundColor:lineColor];
                [self.descScrollView addSubview:circleLb];
            }
            
            [barDescLb setFrame:CGRectMake(8 + i * (barDescColorLbWidth + 4 + barDescLbWidth + 8) + barDescColorLbWidth + 4, 6, barDescLbWidth, 16)];
        }
        else {
            if([type isEqualToString:@"column"]) {
                [barDescColorLb setFrame:CGRectMake(8 + (i - topLayerChildCnt) * (barDescColorLbWidth + 4 + barDescLbWidth + 8), 24, barDescColorLbWidth, 12)];
                [barDescColorLb setBackgroundColor:fillColors];
            }
            else {
                [barDescColorLb setFrame:CGRectMake(8 + (i - topLayerChildCnt) * (barDescColorLbWidth + 4 + barDescLbWidth + 8), 30, barDescColorLbWidth, 1)];
                [barDescColorLb setBackgroundColor:lineColor];
                UILabel *circleLb = [[UILabel alloc] initWithFrame:CGRectMake(8 + (i - topLayerChildCnt) * (barDescColorLbWidth + 4 + barDescLbWidth + 8) + (barDescColorLbWidth - 7) / 2, 27, 7, 7)];
                circleLb.layer.cornerRadius = 3.5;
                circleLb.clipsToBounds = YES;
                [circleLb setBackgroundColor:lineColor];
                [self.descScrollView addSubview:circleLb];
            }
            
            [barDescLb setFrame:CGRectMake(8 + (i - topLayerChildCnt) * (barDescColorLbWidth + 4 + barDescLbWidth + 8) + barDescColorLbWidth + 4, 22, barDescLbWidth, 16)];
        }
        
        //[barDescColorLb setBackgroundColor:[appDelegate.graphColorArr objectAtIndex:i]];
        [barDescLb setFont:font];
        [barDescLb setTextColor:[UIColor darkGrayColor]];
        [barDescLb setText:title];
        
        [self.descScrollView addSubview:barDescColorLb];
        [self.descScrollView addSubview:barDescLb];
    }
    self.descScrollView.contentSize = CGSizeMake(8 + topLayerChildCnt * (barDescColorLbWidth + 4 + barDescLbWidth + 8), 44);
    
    //==================================================
    //==================Draw Bar Graph==================
    //==================================================
    CGFloat barGroupWidth = (columnCnt * (barWidth + barSpace)); //barGroupWidth involves last bar space
    if(columnCnt == 0) {
        barGroupSpace = barGroupSpace + barWidth;
    }
    
    //------------------Configure Chart Bar Value Array------------------//
    NSArray *values = [self.graphDict objectForKey:@"values"];
    
    NSPredicate *maxValPredicate = [NSPredicate predicateWithFormat:@"SELF.Total == %@.@max.Total", values];
    NSArray *maxValDict = [values filteredArrayUsingPredicate:maxValPredicate];
    
    NSPredicate *minValPredicate = [NSPredicate predicateWithFormat:@"SELF.Total == %@.@min.Total", values];
    NSArray *minValDict = [values filteredArrayUsingPredicate:minValPredicate];
    
    CGFloat eachValHeight;
    CGFloat maxBarVal = 0;
    CGFloat minBarVal = 1000000;

    if(isStack) {
        for(int i = 0; i < values.count; i++) {
            NSDictionary *graphGroupValueDict = [values objectAtIndex:i];
            CGFloat sumVal = 0;
            for(int j = 0; j < configurationArr.count; j++) {
                NSDictionary *configurationDict = [configurationArr objectAtIndex:j];
                NSString *title = [configurationDict objectForKey:@"title"];
                
                if([graphGroupValueDict objectForKey:title] != nil) {
                    CGFloat barVal = (CGFloat)[[graphGroupValueDict objectForKey:title] floatValue];
                    sumVal = sumVal + barVal;
                }
            }
            if(sumVal > maxBarVal) {
                maxBarVal = sumVal;
            }
        }
        maxYAxis = maxBarVal + maxBarVal / 50;
        minYAxis = 0;
        
        // New Implementaion added below 15-12-2017
        
        if ([maxValDict count]) {
            CGFloat maxBarValue = [[[maxValDict objectAtIndex:0] valueForKey:@"Total"] floatValue];
            maxYAxis = ((maxBarValue - minYAxis) > 5) ? maxBarValue : (maxBarValue + (maxBarValue * 2) / 100);
        }
    }
    else {
        for(int i = 0; i < values.count; i++) {
            NSDictionary *graphGroupValueDict = [values objectAtIndex:i];
            for(int j = 0; j < configurationArr.count; j++) {
                NSDictionary *configurationDict = [configurationArr objectAtIndex:j];
                NSString *title = [configurationDict objectForKey:@"title"];
                
                if([graphGroupValueDict objectForKey:title] != nil) {
                    CGFloat barVal = (CGFloat)[[graphGroupValueDict objectForKey:title] floatValue];
                    if(barVal > maxBarVal) {
                        maxBarVal = barVal;
                    }
                    if(barVal < minBarVal) {
                        minBarVal = barVal;
                    }
                }
            }
        }
        maxYAxis = maxBarVal + maxBarVal / 50;
        minYAxis = minBarVal - minBarVal / 50;
    }
    

    CGFloat yAxisOffset;
    yAxisOffset = (maxYAxis - minYAxis) / 4;
    
    // Old Code
    /*
    if(maxBarVal == minBarVal) {
        [yAxisStrArr addObject:@"0.0"];
        NSString *minYAxisStr = [NSString stringWithFormat:@"%.1f", minYAxis];
        if(minYAxisStr.length > 5) {
            minYAxisStr = [NSString stringWithFormat:@"%.1fk", minYAxis / 1000];
        }
        [yAxisStrArr addObject:minYAxisStr];
    }
    else {
        for(int i = 0; i < 5;i ++) {
            NSString *yAxisStr = [NSString stringWithFormat:@"%.1f", i * yAxisOffset + minYAxis];
            if(yAxisStr.length > 5) {
                yAxisStr = [NSString stringWithFormat:@"%.1fk", (i * yAxisOffset + minYAxis) / 1000];
            }
            [yAxisStrArr addObject:yAxisStr];
        }
    }*/
    
    // New Implementation goes here 29-12-2017
    
    if(maxBarVal == minBarVal) {
        
        [yAxisStrArr addObject:@"0.0"];
        NSString *minYAxisStr = [NSString stringWithFormat:@"%ld", (long)minYAxis];
        if(minYAxisStr.length >= 5) {
            minYAxisStr = [NSString stringWithFormat:@"%ldk", (long)(minYAxis / 1000)];
        }
        [yAxisStrArr addObject:minYAxisStr];
        
    }else {
        
        if ((maxYAxis - minYAxis) > 5) {
            for(int i = 0; i < 5;i ++) {
                NSString *yAxisStr = [NSString stringWithFormat:@"%ld", (long)(i * yAxisOffset + minYAxis)];
                if(yAxisStr.length >= 5) {
                    yAxisStr = [NSString stringWithFormat:@"%ldk", (long)((i * yAxisOffset + minYAxis) / 1000)];
                }
                [yAxisStrArr addObject:yAxisStr];
            }
        }else {
            for(int i = 0; i < 5;i ++) {
                NSString *yAxisStr = [NSString stringWithFormat:@"%.1f", i * yAxisOffset + minYAxis];
                if(yAxisStr.length >= 5) {
                    yAxisStr = [NSString stringWithFormat:@"%.1fk", (i * yAxisOffset + minYAxis) / 1000];
                }
                [yAxisStrArr addObject:yAxisStr];
            }
        }
    }
    
    if(maxBarVal != 0) {
        eachValHeight = yAxisHeight / (maxYAxis - minYAxis);
        
        //================================================================
        //==================    Configure y Axis View   ==================
        //================================================================
        CGFloat yAxisUnitHeight = yAxisHeight / (yAxisStrArr.count - 1);
        for(int i = 0; i < yAxisStrArr.count; i++) {
            UILabel *axisLb;
            UILabel *axisStrLb;
            UILabel *xBaseLb;
            if(i == yAxisStrArr.count - 1) {
                axisLb = [[UILabel alloc] initWithFrame:CGRectMake(39, (CGFloat)yAxisHeight, 6, 2)];
                axisStrLb = [[UILabel alloc] initWithFrame:CGRectMake(0, (CGFloat)yAxisHeight - 7, 35, 14)];
                xBaseLb = [[UILabel alloc] initWithFrame:CGRectMake(0, (CGFloat)yAxisHeight + 0.5, self.xBaseView.frame.size.width, 1)];
            }
            else {
                axisLb = [[UILabel alloc] initWithFrame:CGRectMake(39, (CGFloat)yAxisUnitHeight * i, 6, 2)];
                axisStrLb = [[UILabel alloc] initWithFrame:CGRectMake(0, (CGFloat)yAxisUnitHeight * i - 7, 35, 14)];
                xBaseLb = [[UILabel alloc] initWithFrame:CGRectMake(0, (CGFloat)yAxisUnitHeight * i + 0.5, self.xBaseView.frame.size.width, 1)];
            }
            [axisLb setBackgroundColor:[UIColor redColor]];
            [axisStrLb setFont:[UIFont systemFontOfSize:10.0]];
            [axisStrLb setText:[yAxisStrArr objectAtIndex:yAxisStrArr.count - 1 - i]];
            [axisStrLb setTextAlignment:NSTextAlignmentRight];
            [xBaseLb setBackgroundColor:[UIColor colorWithRed:200.0 / 255.0 green:200.0 / 255.0 blue:200.0 / 255.0 alpha:1]];
            
            [self.yAxisView addSubview:axisLb];
            [self.yAxisView addSubview:axisStrLb];
            [self.xBaseView addSubview:xBaseLb];
            
        }
        
        
        //========================================================
        //==================Draw Bar & Line Graph=================
        //========================================================
        NSMutableArray *prevValSumArr = [[NSMutableArray alloc] init];
        for(int i = 0; i < values.count; i++) {
            [prevValSumArr addObject:[NSNumber numberWithFloat:0]];
        }
        int columnIndex = 0;
        for(int i = 0; i < configurationArr.count; i++) {
            NSDictionary *configurationDict = [configurationArr objectAtIndex:i];
            NSString *title = [configurationDict objectForKey:@"title"];
            NSString *type = [configurationDict objectForKey:@"type"];
            CGFloat lineAlpha = [[configurationDict objectForKey:@"lineAlpha"] floatValue];
            CGFloat fillAlpha = [[configurationDict objectForKey:@"fillAlphas"] floatValue];
            
            UIColor *fillColors = [configurationDict objectForKey:@"fillColors"] ? [UIColor colorWithHexString:[configurationDict objectForKey:@"fillColors"]] : [appDelegate.graphColorArr objectAtIndex:i];
            
            UIColor *lineColor = [configurationDict objectForKey:@"lineColor"] ? [UIColor colorWithHexString:[configurationDict objectForKey:@"lineColor"]] : [appDelegate.graphColorArr objectAtIndex:i];
            
            if([type isEqualToString:@"column"]) {
                if(isStack) {
                    for(int j = 0; j < values.count; j++) {
                        NSDictionary *barGroupDict = [values objectAtIndex:j];
                        CGFloat barVal = [[barGroupDict objectForKey:title] floatValue];
                        
                        CGFloat sumVal = [[prevValSumArr objectAtIndex:j] floatValue];
                        sumVal = sumVal + barVal;
                        [prevValSumArr setObject:[NSNumber numberWithFloat:sumVal] atIndexedSubscript:j];
                        
                        UILabel *barLb = [[UILabel alloc] initWithFrame:CGRectMake(startOffset + j * (barGroupWidth + barGroupSpace), yAxisHeight - sumVal * eachValHeight, barWidth, barVal * eachValHeight)];
                        //[barLb setBackgroundColor:[appDelegate.graphColorArr objectAtIndex:i]];
                        [barLb setBackgroundColor:fillColors];
                        [barLb setAlpha:fillAlpha];
                        [self.scrollView addSubview:barLb];
                    }
                }
                else {
                    for(int j = 0; j < values.count; j++) {
                        NSDictionary *barGroupDict = [values objectAtIndex:j];
                        CGFloat barVal = [[barGroupDict objectForKey:title] floatValue] - minYAxis;
                        if(barVal < 0) {
                            barVal = 0;
                        }
                        
                        UILabel *barLb = [[UILabel alloc] initWithFrame:CGRectMake(startOffset + columnIndex * (barWidth + barSpace) + j * (barGroupWidth + barGroupSpace), yAxisHeight - barVal * eachValHeight, barWidth, barVal * eachValHeight)];
                        //[barLb setBackgroundColor:[appDelegate.graphColorArr objectAtIndex:i]];
                        [barLb setBackgroundColor:fillColors];
                        [barLb setAlpha:fillAlpha];
                        [self.scrollView addSubview:barLb];
                    }
                    columnIndex ++;
                }
            }
            else {
                NSMutableArray *linePointArr = [[NSMutableArray alloc] init];
                for(int j = 0; j < values.count; j++) {
                    
                    NSDictionary *barGroupDict = [values objectAtIndex:j];
                    CGFloat lineVal = [[barGroupDict objectForKey:title] floatValue] - minYAxis;
                    if(lineVal < 0) {
                        lineVal = 0;
                    }
                    CGFloat middlePosInBars = startOffset + (barGroupWidth + barGroupSpace) * j + (barGroupWidth - barSpace) / 2; //barGroupWidth involves last bar space
                    
                    if(j == 0) {
                        [linePointArr addObject:[NSValue valueWithCGPoint:CGPointMake(middlePosInBars, yAxisHeight)]];
                    }
                    
                    [linePointArr addObject:[NSValue valueWithCGPoint:CGPointMake(middlePosInBars, yAxisHeight - lineVal * eachValHeight)]];
                    
                    if(j == values.count - 1) {
                        [linePointArr addObject:[NSValue valueWithCGPoint:CGPointMake(middlePosInBars, yAxisHeight)]];
                    }
                }
                CustomLineView *customLineView = [[CustomLineView alloc] initWithPointArrayAndFrame:linePointArr frame:CGRectMake(0, 0, startOffset + (barGroupWidth + barGroupSpace) * values.count, self.scrollView.frame.size.height) color:lineColor lineAlpha: lineAlpha fillAlpha: fillAlpha];
                [customLineView setBackgroundColor:[UIColor clearColor]];
                [self.scrollView addSubview:customLineView];
            }
        }
        
        
        //===========================================
        //==================Draw DOT=================
        //===========================================
        for(int i = 0; i < configurationArr.count; i++) {
            NSDictionary *configurationDict = [configurationArr objectAtIndex:i];
            NSString *title = [configurationDict objectForKey:@"title"];
            NSString *type = [configurationDict objectForKey:@"type"];
            
            UIColor *lineColor = [configurationDict objectForKey:@"lineColor"] ? [UIColor colorWithHexString:[configurationDict objectForKey:@"lineColor"]] : [appDelegate.graphColorArr objectAtIndex:i];
            
            if([type isEqualToString:@"line"]) {
                for(int j = 0; j < values.count; j++) {
                    NSDictionary *barGroupDict = [values objectAtIndex:j];
                    CGFloat lineVal = [[barGroupDict objectForKey:title] floatValue] - minYAxis;
                    if(lineVal < 0) {
                        lineVal = 0;
                    }
                    CGFloat middlePosInBars = startOffset + (barGroupWidth + barGroupSpace) * j + (barGroupWidth - barSpace) / 2; //barGroupWidth involves last bar space
                    
                    UILabel *dotLb = [[UILabel alloc] initWithFrame:CGRectMake(middlePosInBars - 3.5, yAxisHeight - lineVal * eachValHeight - 3.5, 7, 7)];
                    [dotLb setBackgroundColor:lineColor];
                    dotLb.layer.cornerRadius = 3.5;
                    dotLb.clipsToBounds = YES;
                    [self.scrollView addSubview:dotLb];
                }
            }
        }
        
        
        //int barIndex = 0;
        for(int i = 0; i < values.count; i++) {
            NSDictionary *graphGroupValueDict = [values objectAtIndex:i];
            
            NSString *dateStr = [graphGroupValueDict objectForKey:@"ValueDateString"];
            CGFloat middlePosInBars = startOffset + (barGroupWidth + barGroupSpace) * i + (barGroupWidth - barSpace) / 2; //barGroupWidth involves last bar space
            UILabel *dateStickLb = [[UILabel alloc] initWithFrame:CGRectMake(middlePosInBars - 1, yAxisHeight + 2, 2, 6)];
            [dateStickLb setBackgroundColor:[UIColor lightGrayColor]];
            
            UILabel *dateLb = [[UILabel alloc] initWithFrame:CGRectMake(middlePosInBars - 33 * 1.7 + 4.5, yAxisHeight + 33 * 0.7, 66, 13)];  //0.7 sqrt(2)
            [dateLb setText:dateStr];
            [dateLb setFont:[UIFont systemFontOfSize:10.0]];
            
            CGFloat radians = atan2f(dateLb.transform.b, dateLb.transform.a);
            CGFloat degrees = radians * (180 / M_PI);
            CGAffineTransform transform = CGAffineTransformMakeRotation((-45 + degrees) * M_PI / 180);
            dateLb.transform = transform;
            
            [self.scrollView addSubview:dateStickLb];
            [self.scrollView addSubview:dateLb];
        }
        self.scrollView.contentSize = CGSizeMake(startOffset + values.count * (barGroupWidth + barGroupSpace) , self.scrollView.frame.size.height);
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentSize.width - 1, self.scrollView.contentSize.height - 1, 1, 1) animated:YES];
    }
    graphDrawn = YES;
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
