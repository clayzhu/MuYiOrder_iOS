//
//  CZPickerView.h
//  MuYiOrder
//
//  Created by ug19 on 2017/5/13.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZPickerView;

@protocol CZPickerViewDelegate <NSObject>

- (void)czPickerView:(CZPickerView *)czPickerView selectedRow:(NSUInteger)index clickSureButton:(BOOL)isClickSure;

@end

@interface CZPickerView : UIView

@property (strong, nonatomic) NSString *identifier;

@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray<NSString *> *dataSource;
@property (assign, nonatomic) NSUInteger selectedRow;

@property (strong, nonatomic) UIColor *mainColor;

@property (weak, nonatomic) id<CZPickerViewDelegate> delegate;

- (void)setupPickerView;

- (void)showPickerView;
- (void)hidePickerView;

@end
