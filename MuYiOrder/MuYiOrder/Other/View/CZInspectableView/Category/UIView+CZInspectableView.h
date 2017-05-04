//
//  UIView+CZInspectableView.h
//  CZInspectableViewDemo
//
//  Created by Apple on 2017/3/23.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE

/** 
 使用 IBInspectable 可以在 IB 的 Attributes Inspector 中创建如 cornerRadius 等原本并不支持操作的属性，
 使用 IB_DESIGNABLE 可以在 IB 中直接看到修改上述属性后的渲染效果。
 使用 UIView 的 Category，并且继承一个 UIView、UILabel 等的子类，可以自动使用这些效果。
 不继承的话，修改有效，但 IB 上看不到实时渲染。
 需要更多属性时，可以扩展自定义属性，格式参照下面的 defineValue。
 */
@interface UIView (CZInspectableView)

/** 设置超过子图层的部分裁减掉 */
@property (assign, nonatomic) IBInspectable BOOL masksToBounds;
/** 圆角 */
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
/** 边框宽度 */
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
/** 边框颜色 */
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

/** 阴影颜色 */
@property (strong, nonatomic) IBInspectable UIColor *shadowColor;
/** 阴影透明度 */
@property (assign, nonatomic) IBInspectable CGFloat shadowOpacity;
/** 阴影偏移 */
@property (assign, nonatomic) IBInspectable CGSize shadowOffset;
/** 阴影圆角 */
@property (assign, nonatomic) IBInspectable CGFloat shadowRadius;

/** 自定义属性 */
//@property (assign, nonatomic) IBInspectable CGFloat defineValue;

@end
