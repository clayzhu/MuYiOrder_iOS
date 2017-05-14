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
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), 216.0)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

- (void)setDataSource:(NSArray<NSString *> *)dataSource {
    _dataSource = dataSource;
    [self.pickerView reloadAllComponents];
}

#pragma mark - Setup
- (void)setupPickerView {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    
    [self addSubview:self.pickerView];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataSource[row];
}

#pragma mark - Show and Hide
- (void)showPickerView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect pickerViewFrame = self.pickerView.frame;
                         pickerViewFrame.origin.y = CGRectGetHeight(self.bounds) - 216.0;
                         self.pickerView.frame = pickerViewFrame;
                     }];
}

- (void)hidePickerView {
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect pickerViewFrame = self.pickerView.frame;
                         pickerViewFrame.origin.y = CGRectGetHeight(self.bounds);
                         self.pickerView.frame = pickerViewFrame;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self removeFromSuperview];
                         }
                     }];
}

@end
