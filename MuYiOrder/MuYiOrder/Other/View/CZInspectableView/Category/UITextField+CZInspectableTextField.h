//
//  UITextField+CZInspectableTextField.h
//  CZInspectableViewDemo
//
//  Created by Apple on 2017/3/23.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 UITextField 的 Category CZInspectableTextField，添加 UITextField 专有的属性修改，而 UIView 共有的属性已经通过 CZInspectableView Category 自动实现。
 */
@interface UITextField (CZInspectableTextField)

/** placeholder 颜色 */
@property (strong, nonatomic) IBInspectable UIColor *placeholderColor;

/** UITextField 的边框左侧和文字左侧的距离 */
@property (assign, nonatomic) IBInspectable CGFloat leadingSpacing;
/** UITextField 的边框右侧和文字右侧的距离 */
@property (assign, nonatomic) IBInspectable CGFloat taillingSpacing;

@end
