//
//  CZDatePickerView.h
//  MuYiOrder
//
//  Created by ug19 on 2017/5/14.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZDatePickerView : UIView

/** 如果一个页面需要使用多个 CZDatePickerView，可以使用 identifier 标记 */
@property (strong, nonatomic) NSString *identifier;
/** 设定主色调 */
@property (strong, nonatomic) UIColor *mainColor;

@property (strong, nonatomic) UIDatePicker *datePicker;

/** 初始化基础样式和控件 */
- (void)setupPickerView;

/** 显示 pickerView */
- (void)showPickerView;
/** 隐藏 pickerView */
- (void)hidePickerView;

@end
