//
//  CZBlockButton.m
//  kunpengzulin
//
//  Created by Ug's iMac on 16/9/1.
//  Copyright © 2016年 avery. All rights reserved.
//

#import "CZBlockButton.h"

@implementation CZBlockButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setTouchUpInside:(void (^)(UIButton *))touchUpInside {
	_touchUpInside = touchUpInside;
	[self addTarget:self action:@selector(touchUpInsideSelector:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchUpInsideSelector:(UIButton *)sender {
	if (_touchUpInside) {
		_touchUpInside(sender);
	}
}

- (CALayer *)sublayer {
    if (!_sublayer) {
        _sublayer = [[CALayer alloc] init];
        _sublayer.frame = self.layer.bounds;
        [self.layer addSublayer:_sublayer];
    }
    return _sublayer;
}

@end
