//
//  UITextField+CZInspectableTextField.m
//  CZInspectableViewDemo
//
//  Created by Apple on 2017/3/23.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "UITextField+CZInspectableTextField.h"

@implementation UITextField (CZInspectableTextField)

- (UIColor *)placeholderColor {
	return [self valueForKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
	[self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (CGFloat)leadingSpacing {
    return CGRectGetWidth(self.leftView.bounds);
}

- (void)setLeadingSpacing:(CGFloat)leadingSpacing {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leadingSpacing, self.bounds.size.height)];
    self.leftView = view;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (CGFloat)taillingSpacing {
    return CGRectGetWidth(self.rightView.bounds);
}

- (void)setTaillingSpacing:(CGFloat)taillingSpacing {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, taillingSpacing, self.bounds.size.height)];
    self.rightView = view;
    self.rightViewMode = UITextFieldViewModeAlways;
}

@end
