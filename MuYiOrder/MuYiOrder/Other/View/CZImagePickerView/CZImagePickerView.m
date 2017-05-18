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
@property (assign, nonatomic) NSUInteger indexOfLastButton;
@property (assign, nonatomic) NSUInteger numberOfRows;
@property (assign, nonatomic) NSUInteger numberOfButtonInRow;
@property (assign, nonatomic) CGFloat widthForSingleButton;

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
        
        UIButton *lastButton = [self.imageButtonList lastObject];   // 目前显示的最后一个 button
        CGFloat maxX = CGRectGetMaxX(lastButton.frame) + self.spacingForButton + self.widthForSingleButton; // 计算新加入的 button 如果放在上一个 button 的后面，x 最大的值
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];    // 创建新的 button
        [button setImage:image forState:UIControlStateNormal];
        if (maxX > CGRectGetWidth(self.bounds)) {
            button.frame = CGRectMake(self.spacingForButton,
                                      self.spacingForButton * (self.numberOfRows + 1) + self.widthForSingleButton * self.numberOfRows,
                                      self.widthForSingleButton, self.widthForSingleButton);
        } else {
            button.frame = CGRectMake(self.spacingForButton * (self.indexOfLastButton + 1) + self.widthForSingleButton * self.indexOfLastButton,
                                      self.spacingForButton * self.numberOfRows + self.widthForSingleButton * (self.numberOfRows - 1),
                                      self.widthForSingleButton, self.widthForSingleButton);
        }
        [self.imageButtonList addObject:button];
        [self addSubview:button];
        
        // 重新绘制 addButton 的位置
        CGFloat maxXOfAddButton = CGRectGetMaxX(button.frame) + self.spacingForButton + self.widthForSingleButton; // 计算 addButton 如果放在上一个 button 的后面，x 最大的值
        if (maxXOfAddButton > CGRectGetWidth(self.bounds)) {
            self.addButton.frame = CGRectMake(self.spacingForButton,
                                              self.spacingForButton * (self.numberOfRows + 1) + self.widthForSingleButton * self.numberOfRows,
                                              self.widthForSingleButton, self.widthForSingleButton);
        } else {
            self.addButton.frame = CGRectMake(self.spacingForButton * (self.indexOfLastButton + 1) + self.widthForSingleButton * self.indexOfLastButton,
                                              self.spacingForButton * self.numberOfRows + self.widthForSingleButton * (self.numberOfRows - 1),
                                              self.widthForSingleButton, self.widthForSingleButton);
        }
    }
}

- (NSMutableArray<UIImage *> *)imageListPrivate {
    if (!_imageListPrivate) {
        _imageListPrivate = [NSMutableArray array];
    }
    return _imageListPrivate;
}

- (NSMutableArray<UIButton *> *)imageButtonList {
    if (!_imageButtonList) {
        _imageButtonList = [NSMutableArray array];
    }
    return _imageButtonList;
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

- (NSUInteger)indexOfLastButton {
    NSUInteger remainder = self.imageButtonList.count % self.numberOfButtonInRow; // 取余
    return remainder;
}

- (NSUInteger)numberOfRows {
    NSUInteger divide = self.imageButtonList.count / self.numberOfButtonInRow;    // 除以
    NSUInteger numberOfRows = divide + self.indexOfLastButton > 0 ? 1 : 0;
    return numberOfRows > 0 ? numberOfRows : 1;
}

- (NSUInteger)numberOfButtonInRow {
    return 3;
}

- (CGFloat)widthForSingleButton {
    CGFloat width = (CGRectGetWidth(self.bounds) - self.spacingForButton * (self.numberOfButtonInRow + 1)) / self.numberOfButtonInRow;
    return width;
}

#pragma mark - Setup
- (void)setupImagePickerView {
    self.addButton.frame = CGRectMake(self.spacingForButton, self.spacingForButton, self.widthForSingleButton, self.widthForSingleButton);
    [self addSubview:self.addButton];
}

@end
