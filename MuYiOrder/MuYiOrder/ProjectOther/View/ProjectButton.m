//
//  ProjectButton.m
//  EnjoyiOS
//
//  Created by Ug's iMac on 2017/1/3.
//  Copyright © 2017年 Ugood. All rights reserved.
//

#import "ProjectButton.h"
#import "UIImage+Custom.h"

@implementation ProjectButton

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
	[self setBackgroundImage:[UIImage imageWithColor:[UIColor hex_33bc99]] forState:UIControlStateNormal];
	[self setBackgroundImage:[UIImage imageWithColor:[UIColor hex_00bb8c]] forState:UIControlStateHighlighted];
	[self setBackgroundImage:[UIImage imageWithColor:[UIColor hex_00bb8c]] forState:UIControlStateSelected];
	self.layer.cornerRadius = 5.0;
	self.layer.masksToBounds = YES;
}

@end
