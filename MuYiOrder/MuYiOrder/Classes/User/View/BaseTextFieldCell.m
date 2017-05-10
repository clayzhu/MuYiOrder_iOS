//
//  BaseTextFieldCell.m
//  MuYiOrder
//
//  Created by ug19 on 2017/5/4.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "BaseTextFieldCell.h"

@implementation BaseTextFieldCell

@synthesize textLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.textField addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];    // KVO 观察 textField 是否可以编辑
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.textField) {
        if ([keyPath isEqualToString:@"enabled"]) {
            self.editingIndicatorLine.hidden = ![change[NSKeyValueChangeNewKey] boolValue]; // textField 可以编辑时，显示底部横线；不可以编辑时，则隐藏
        }
    }
}

- (void)dealloc {
    [self.textField removeObserver:self forKeyPath:@"enabled"];
}

@end
