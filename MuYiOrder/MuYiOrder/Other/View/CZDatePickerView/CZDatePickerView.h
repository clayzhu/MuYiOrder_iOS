//
//  CZDatePickerView.h
//  MuYiOrder
//
//  Created by ug19 on 2017/5/14.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZDatePickerView;

@protocol CZDatePickerViewDelegate <NSObject>

/**
 点击“取消”或“确定”按钮后回调的代理方法

 @param czDatePickerView CZDatePickerView 对象，可以通过该对象获取 identifier 等属性的值
 @param date 选择的时间
 @param isClickSure YES-点击了“确定”，NO-点击了“取消”
 */
- (void)czDatePickerView:(CZDatePickerView *)czDatePickerView selectedDate:(NSDate *)date clickSureButton:(BOOL)isClickSure;

@end

@interface CZDatePickerView : UIView

/** 如果一个页面需要使用多个 CZDatePickerView，可以使用 identifier 标记 */
@property (strong, nonatomic) NSString *identifier;
/** 设定主色调 */
@property (strong, nonatomic) UIColor *mainColor;

@property (strong, nonatomic) UIDatePicker *datePicker;

@property (weak, nonatomic) id<CZDatePickerViewDelegate> delegate;

/** 初始化基础样式和控件 */
- (void)setupPickerView;

/** 显示 pickerView */
- (void)showPickerView;
/** 隐藏 pickerView */
- (void)hidePickerView;

@end
