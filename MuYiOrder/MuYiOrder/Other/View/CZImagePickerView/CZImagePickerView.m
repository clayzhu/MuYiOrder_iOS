//
//  CZImagePickerView.m
//  MuYiOrder
//
//  Created by ug19 on 2017/5/15.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "CZImagePickerView.h"

@interface CZImagePickerView ()

@property (strong, nonatomic) NSMutableArray<UIImage *> *imageListPrivate;
@property (strong, nonatomic) NSMutableArray<UIButton *> *imageButtonList;
@property (strong, nonatomic) UIButton *addButton;

@property (assign, nonatomic) CGFloat spacingForButton;
@property (assign, nonatomic) NSUInteger numberOfButtonInRow;
@property (assign, nonatomic) CGFloat singleButtonWidth;

@end

@implementation CZImagePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize imageList = _imageList;

#pragma mark - Getter and Setter
- (NSArray<UIImage *> *)imageList {
    return [NSArray arrayWithArray:self.imageListPrivate];
}

- (void)setImageList:(NSArray<UIImage *> *)imageList {
    _imageList = imageList;
    for (UIImage *image in imageList) {
        [self.imageListPrivate addObject:image];
    }
}

- (NSMutableArray<UIImage *> *)imageListPrivate {
    if (!_imageListPrivate) {
        _imageListPrivate = [NSMutableArray array];
    }
    return _imageListPrivate;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:(self.addButtonImage == nil ? [UIImage imageNamed:@"addImage_CZImagePickerView"] : self.addButtonImage) forState:UIControlStateNormal];
        _addButton.layer.borderWidth = 0.5;
    }
    return _addButton;
}

- (void)setAddButtonImage:(UIImage *)addButtonImage {
    _addButtonImage = addButtonImage;
    [self.addButton setImage:addButtonImage forState:UIControlStateNormal];
}

- (void)setEdit:(BOOL)edit {
    _edit = edit;
    self.addButton.hidden = !edit;
}

- (CGFloat)spacingForButton {
    return 8.0;
}

- (NSUInteger)numberOfButtonInRow {
    return 3;
}

- (CGFloat)singleButtonWidth {
    CGFloat width = (CGRectGetWidth(self.bounds) - self.spacingForButton * (self.numberOfButtonInRow + 1)) / self.numberOfButtonInRow;
    return width;
}

#pragma mark - Setup
- (void)setupImagePickerView {
    self.addButton.frame = CGRectMake(0.0, 0.0, self.singleButtonWidth, self.singleButtonWidth);
    [self addSubview:self.addButton];
}

@end
