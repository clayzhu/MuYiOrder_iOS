//
//  CZPickerView.h
//  MuYiOrder
//
//  Created by ug19 on 2017/5/13.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZPickerView : UIView

@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray<NSString *> *dataSource;
@property (assign, nonatomic) NSUInteger selectedRow;
@property (strong, nonatomic) NSString *identifier;

- (void)setupPickerView;

- (void)showPickerView;
- (void)hidePickerView;

@end
