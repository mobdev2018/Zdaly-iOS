//
//  DailyNewsTableViewCell.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DailyNewsCellDelegate <NSObject>
- (void)getSelectedIndexOfCheckBox:(NSInteger)intIndex;
@end

@interface DailyNewsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLb;
@property (strong, nonatomic) IBOutlet UILabel *contentLb;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleHeightConst;
@property (strong, nonatomic) IBOutlet UIButton *shareBt;
@property (strong, nonatomic) IBOutlet UILabel *sourceLb;
@property (strong, nonatomic) IBOutlet UILabel *dateLb;
@property (strong, nonatomic) IBOutlet UIButton *selectCheckBox;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentBottomConst;
@property (nonatomic, weak) id<DailyNewsCellDelegate> delegate;
- (IBAction)checkBoxClicked:(UIButton *)sender;
@end
