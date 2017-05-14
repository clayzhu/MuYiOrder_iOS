//
//  CZPickerView.m
//  MuYiOrder
//
//  Created by ug19 on 2017/5/13.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "CZPickerView.h"

@interface CZPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation CZPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Getter and Setter

#pragma mark - Setup
- (void)setupPickerView {
    self.hidden = YES;
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 0;
}

#pragma mark - UIPickerViewDelegate

#pragma mark - Show and Hide
- (void)showPickerView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.hidden = NO;
}

@end
