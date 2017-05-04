//
//  TopFilterView.m
//  MuYiOrder
//
//  Created by ug19 on 2017/5/4.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "TopFilterView.h"

@interface TopFilterView ()
@property (strong, nonatomic) UIView *moveLine;

@end

@implementation TopFilterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createFilterView {
    for (int i = 0; i < _titles.count; i ++) {
        CGFloat btnW = CGRectGetWidth([UIScreen mainScreen].bounds) / _titles.count;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * btnW, 0.0, btnW, _titleHeight);
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        if (i == 0) {   // 默认选中第一个按钮
            // 初始化 line，宽度计算
            _moveLine = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleHeight, btnW, 2)];
            _moveLine.backgroundColor = [UIColor whiteColor];
            [self addSubview:_moveLine];
        }
        
        [btn addTarget:self action:@selector(selectTopType:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

/** 选择顶部的所有订单、未完成、已完成 */
- (void)selectTopType:(UIButton *)sender {
    CGSize currentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) / _titles.count, _titleHeight);
    CGPoint center = CGPointMake(sender.center.x, _titleHeight);
    CGRect temp = _moveLine.frame;
    temp.origin.x = center.x - currentSize.width / 2;
    temp.origin.y = center.y;
    temp.size.width = currentSize.width;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         _moveLine.frame = temp;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             if ([self.delegate respondsToSelector:@selector(topFilterView:didSelectTitle:atIndex:)]) {
                                 [self.delegate topFilterView:self didSelectTitle:[sender titleForState:UIControlStateNormal] atIndex:sender.tag];
                             }
                         }
                     }];
}

@end
