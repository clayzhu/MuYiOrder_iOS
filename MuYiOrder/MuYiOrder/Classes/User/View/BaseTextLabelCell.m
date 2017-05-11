//
//  BaseTextLabelCell.m
//  MuYiOrder
//
//  Created by ug19 on 2017/5/11.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "BaseTextLabelCell.h"

@implementation BaseTextLabelCell

@synthesize textLabel, detailTextLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
