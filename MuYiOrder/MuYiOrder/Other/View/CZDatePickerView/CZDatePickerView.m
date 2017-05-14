//
//  CZDatePickerView.m
//  MuYiOrder
//
//  Created by ug19 on 2017/5/14.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "CZDatePickerView.h"

static CGFloat kPickerViewHeight = 216.0, kToolbarHeight = 44.0;

@interface CZDatePickerView ()

@property (strong, nonatomic) UIView *containerView;

@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *sureButton;

@end

@implementation CZDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Getter and Setter
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), kPickerViewHeight + kToolbarHeight)];
    }
    return _containerView;
}

- (UIToolbar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), kToolbarHeight)];
        
        static CGFloat fixedWidth = 10.0, defaultMargin = 10.0;
        // 左边距
        UIBarButtonItem *fixedLeftItem = [[UIBarButtonItem alloc] init];
        fixedLeftItem.style = UIBarButtonSystemItemFixedSpace;
        fixedLeftItem.width = fixedWidth;
        // 取消按钮
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:self.cancelButton];
        // 中间距离
        UIBarButtonItem *fixedCenterItem = [[UIBarButtonItem alloc] init];
        fixedCenterItem.style = UIBarButtonSystemItemFixedSpace;
        fixedCenterItem.width = CGRectGetWidth(_toolbar.bounds) - 2 * fixedWidth - 2 * CGRectGetWidth(self.cancelButton.bounds) - 4 * defaultMargin;
        // 确定按钮
        UIBarButtonItem *sureItem = [[UIBarButtonItem alloc] initWithCustomView:self.sureButton];
        // 右边距
        UIBarButtonItem *fixedRightItem = [[UIBarButtonItem alloc] init];
        fixedRightItem.style = UIBarButtonSystemItemFixedSpace;
        fixedRightItem.width = fixedWidth;
        _toolbar.items = @[fixedLeftItem, cancelItem, fixedCenterItem, sureItem, fixedRightItem];
    }
    return _toolbar;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setupToolbarButtonStyle:_cancelButton];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.tag = 910;
    }
    return _cancelButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setupToolbarButtonStyle:_sureButton];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        _sureButton.tag = 911;
    }
    return _sureButton;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, kToolbarHeight, CGRectGetWidth(self.bounds), kPickerViewHeight)];
        _datePicker.backgroundColor = [UIColor whiteColor];
    }
    return _datePicker;
}

- (void)setMainColor:(UIColor *)mainColor {
    _mainColor = mainColor;
    self.cancelButton.layer.borderWidth = 0.5;
    self.cancelButton.layer.borderColor = mainColor.CGColor;
    [self.cancelButton setTitleColor:mainColor forState:UIControlStateNormal];
    
    self.sureButton.backgroundColor = mainColor;
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

#pragma mark - Setup
- (void)setupPickerView {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    
    [self.containerView addSubview:self.datePicker];
    [self.containerView addSubview:self.toolbar];
    [self addSubview:self.containerView];
}

/** 设置 toolbar 上按钮的共同样式 */
- (void)setupToolbarButtonStyle:(UIButton *)button {
    button.frame = CGRectMake(0.0, 0.0, 64.0, 32.0);
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [button addTarget:self action:@selector(toolbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 6.0;
    button.layer.masksToBounds = YES;
}

#pragma mark - Show and Hide
- (void)showPickerView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.y = CGRectGetHeight(self.bounds) - kPickerViewHeight - kToolbarHeight;
                         self.containerView.frame = frame;
                     }];
}

- (void)hidePickerView {
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.y = CGRectGetHeight(self.bounds);
                         self.containerView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self removeFromSuperview];
                         }
                     }];
}

#pragma mark - Cancel and Sure Button
- (void)toolbarButtonAction:(UIButton *)sender {
    BOOL isClickSure = NO;
    if (sender.tag == 911) {
        isClickSure = YES;
    }
    if ([self.delegate respondsToSelector:@selector(czDatePickerView:selectedDate:clickSureButton:)]) {
        [self.delegate czDatePickerView:self selectedDate:self.datePicker.date clickSureButton:isClickSure];
    }
    
    [self hidePickerView];
}

@end
