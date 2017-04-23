//
//  UIView+Style.m
//  MuYiOrder
//
//  Created by ug19 on 2017/4/23.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "UIView+Style.h"

@implementation UIView (Style)

- (void)setupTFViewStyle {
    self.layer.cornerRadius = 6.0;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0, 5.0);
    self.layer.shadowRadius = 7.0;
    self.layer.shadowOpacity = 0.05;
}

@end
