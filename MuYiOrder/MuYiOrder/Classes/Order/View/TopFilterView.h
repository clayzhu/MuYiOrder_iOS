//
//  TopFilterView.h
//  MuYiOrder
//
//  Created by ug19 on 2017/5/4.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopFilterView : UIView

@property (strong, nonatomic) NSArray<NSString *> *titles;
@property (assign, nonatomic) CGFloat titleHeight;

/** 绘制筛选视图，需要先设置上面的属性 */
- (void)createFilterView;

@end
