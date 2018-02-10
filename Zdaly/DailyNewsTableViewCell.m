//
//  DailyNewsTableViewCell.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import "DailyNewsTableViewCell.h"

@implementation DailyNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectCheckBox.layer.cornerRadius = 6.0;
    self.selectCheckBox.layer.borderWidth = 2.0;
    self.selectCheckBox.layer.borderColor = [[UIColor blackColor] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkBoxClicked:(UIButton *)sender {
    if (sender.tag) {
        sender.tag = 0;
        [self.selectCheckBox setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else {
        sender.tag = 1;
        [self.selectCheckBox setImage:[UIImage imageNamed:@"icon_check"] forState:UIControlStateNormal];
        if ([self.delegate conformsToProtocol:@protocol(DailyNewsCellDelegate)]) {
            [self.delegate getSelectedIndexOfCheckBox:self.tag];
        }
    }
}


@end
