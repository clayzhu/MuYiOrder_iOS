//
//  ProjectTextField.m
//  MuYiOrder
//
//  Created by ug19 on 2017/4/23.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "ProjectTextField.h"
#import "UITextField+CZInspectableTextField.h"

@implementation ProjectTextField

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.placeholderColor = [UIColor hex_9097ab];
    self.leadingSpacing = 20.0;
    self.taillingSpacing = 20.0;
    self.textColor = [UIColor hex_444A5A];
    self.font = [UIFont systemFontOfSize:18.0];
}

@end
