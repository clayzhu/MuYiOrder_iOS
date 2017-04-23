//
//  CZBlockButton.h
//  kunpengzulin
//
//  Created by Ug's iMac on 16/9/1.
//  Copyright © 2016年 avery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZBlockButton : UIButton

/** 点击事件以 block 形式定义，参数 sender 为按钮 */
@property (copy, nonatomic) void (^touchUpInside)(UIButton *sender);

/**
 如果要同时设置圆角和阴影，需要将其中一个效果设置在这个 sublayer 上。
 调用即自动初始化，并被添加到 self.layer 中
 */
@property (strong, nonatomic) CALayer *sublayer;

@end
