//
//  UIButton+CZInspectableButton.h
//  CZInspectableViewDemo
//
//  Created by Apple on 2017/3/23.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 UIButton 的 Category CZInspectableButton，添加 UIButton 专有的属性修改，而 UIView 共有的属性已经通过 CZInspectableView Category 自动实现。
 */
@interface UIButton (CZInspectableButton)

/** 按钮 UIControlStateNormal 时的背景颜色 */
@property (strong, nonatomic) IBInspectable UIColor *backgroundColorForNormal;
/** 按钮 UIControlStateHighlighted 时的背景颜色 */
@property (strong, nonatomic) IBInspectable UIColor *backgroundColorForHighlighted;
/** 按钮 UIControlStateDisabled 时的背景颜色 */
@property (strong, nonatomic) IBInspectable UIColor *backgroundColorForDisabled;
/** 按钮 UIControlStateSelected 时的背景颜色 */
@property (strong, nonatomic) IBInspectable UIColor *backgroundColorForSelected;

@end
