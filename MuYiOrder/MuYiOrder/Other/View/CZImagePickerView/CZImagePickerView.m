//
//  CZImagePickerView.m
//  MuYiOrder
//
//  Created by ug19 on 2017/5/15.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "CZImagePickerView.h"

static NSInteger kDeteleButtonTag = 910;

@interface CZImagePickerView ()

@property (strong, nonatomic) NSMutableArray<UIImage *> *imageListPrivate;
@property (strong, nonatomic) NSMutableArray<UIButton *> *imageButtonList;
@property (strong, nonatomic) UIButton *addButton;

@property (assign, nonatomic) CGFloat spacingForButton;
@property (assign, nonatomic) NSUInteger indexOfLastButton;
@property (assign, nonatomic) NSUInteger numberOfRows;
@property (assign, nonatomic) NSUInteger numberOfButtonInRow;
@property (assign, nonatomic) CGFloat widthForSingleButton;

@property (assign, nonatomic) CGFloat heightOfView;

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
    
    for (NSUInteger i = 0; i < imageList.count; i ++) {
        UIImage *image = imageList[i];
        [self.imageListPrivate addObject:image];    // 添加图片
        
        // 创建新的图片 button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];
        button.tag = i;
        
        // 创建内部删除 button
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setImage:[UIImage imageNamed:@"deleteImage_CZImagePickerView"] forState:UIControlStateNormal];
        deleteButton.frame = CGRectMake(self.widthForSingleButton - 22.0, 0.0, 22.0, 22.0);
        [deleteButton addTarget:self action:@selector(deleteImageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        deleteButton.tag = kDeteleButtonTag;
        deleteButton.hidden = !self.isEdit;
        [button addSubview:deleteButton];
        
        // 创建拖动手势
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragImageButtonAction:)];
        panGesture.enabled = self.isEdit;
        [button addGestureRecognizer:panGesture];
        
        UIButton *lastButton = [self.imageButtonList lastObject];   // 目前显示的最后一个 button
        [self updateFrameOfButton:button fromLastButton:lastButton];
        [self.imageButtonList addObject:button];
        [self addSubview:button];
        
        // 重新绘制 addButton 的位置，方法和上面类似
        [self updateFrameOfButton:self.addButton fromLastButton:button];
    }
    
    UIButton *lastButtonInView = self.isEdit ? self.addButton : [self.imageButtonList lastObject];  // 如果是编辑模式，则最后一个 button 是 addButton；否则，最后一个 button 是选择的图片按钮列表 imageButtonList 的最后一个
    self.heightOfView = CGRectGetMaxY(lastButtonInView.frame) + self.spacingForButton;    // 重新计算 self 的高度
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
    self.addButton.hidden = !edit;  // 添加按钮显示或隐藏
    
    for (UIButton *button in self.imageButtonList) {
        // 每个图片按钮中删除按钮的显示或隐藏
        UIButton *deleteButton = [button viewWithTag:kDeteleButtonTag];
        deleteButton.hidden = !edit;
        // 拖动手势的开关
        UIPanGestureRecognizer *panGesture = [button.gestureRecognizers firstObject];
        panGesture.enabled = edit;
    }
    
    [self updateFrameOfButton:self.addButton fromLastButton:[self.imageButtonList lastObject]]; // 更新添加按钮的位置
    [self addSubview:self.addButton];
    
    UIButton *lastButtonInView = edit ? self.addButton : [self.imageButtonList lastObject];  // 如果是编辑模式，则最后一个 button 是 addButton；否则，最后一个 button 是选择的图片按钮列表 imageButtonList 的最后一个
    self.heightOfView = CGRectGetMaxY(lastButtonInView.frame) + self.spacingForButton;    // 重新计算 self 的高度
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

- (void)setHeightOfView:(CGFloat)heightOfView {
    // 更新整个 view 的高度
    CGRect frame = self.frame;
    frame.size.height = heightOfView;
    self.frame = frame;
    
    if ([self.delegate respondsToSelector:@selector(czImagePickerView:heightOfView:imageListDidPick:)]) {
        [self.delegate czImagePickerView:self heightOfView:heightOfView imageListDidPick:self.imageList];
    }
}

#pragma mark - Setup
/**
 根据上一个按钮的位置来布局当前按钮的位置

 @param button 当前按钮
 @param lastButton 上一个按钮。可为 nil，表示当前设置第一个按钮
 */
- (void)updateFrameOfButton:(UIButton *)button fromLastButton:(UIButton *)lastButton {
    CGFloat maxX = CGRectGetMaxX(lastButton.frame) + self.spacingForButton + self.widthForSingleButton; // 计算新加入的 button 如果放在上一个 button 的后面，x 最大的值
    if (maxX > CGRectGetWidth(self.bounds)) {   // 如果新加入的 button 的 x 最大的值超过 self 的宽度，则另起一行绘制
        button.frame = CGRectMake(self.spacingForButton,
                                  self.spacingForButton * (self.numberOfRows + 1) + self.widthForSingleButton * self.numberOfRows,
                                  self.widthForSingleButton, self.widthForSingleButton);
    } else {    // 在目前显示的最后一个 button 的后面绘制
        button.frame = CGRectMake(self.spacingForButton * (self.indexOfLastButton + 1) + self.widthForSingleButton * self.indexOfLastButton,
                                  self.spacingForButton * self.numberOfRows + self.widthForSingleButton * (self.numberOfRows - 1),
                                  self.widthForSingleButton, self.widthForSingleButton);
    }
}

/** 更新从 index 开始的后面所有按钮的位置 */
- (void)updateFrameOfButtonsFromIndex:(NSUInteger)index {
    NSMutableArray<UIButton *> *imageButtonListTemp = [NSMutableArray arrayWithArray:self.imageButtonList]; // 拷贝一个临时图片按钮数组
    [self.imageButtonList removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, imageButtonListTemp.count - index)]];    // 从原图片按钮数组中，先临时移除现在删除的图片按钮的后面的所有图片按钮
    // 循环更新图片按钮的位置，依次向前填补删除的图片按钮
    for (NSUInteger i = index; i < imageButtonListTemp.count; i ++) {
        UIButton *lastButton = i == 0 ? nil : imageButtonListTemp[i - 1];
        UIButton *nextButton = imageButtonListTemp[i];
        nextButton.tag = i;
        [self updateFrameOfButton:nextButton fromLastButton:lastButton];
        [self.imageButtonList addObject:nextButton];
    }
}

#pragma mark - Action
/** 删除某个图片按钮，并重新调整其他按钮的位置 */
- (void)deleteImageButtonAction:(UIButton *)sender {
    UIButton *superButton = (UIButton *)sender.superview;   // 删除按钮的父图片按钮
    NSUInteger index = superButton.tag;
    [self.imageListPrivate removeObjectAtIndex:index];
    [self.imageButtonList removeObjectAtIndex:index];
    [superButton removeFromSuperview];
    
    [self updateFrameOfButtonsFromIndex:index];
    
    UIButton *lastButton = [self.imageButtonList lastObject];   // 目前显示的最后一个图片按钮
    [self updateFrameOfButton:self.addButton fromLastButton:lastButton];    // 更新添加按钮的位置
    
    UIButton *lastButtonInView = self.isEdit ? self.addButton : [self.imageButtonList lastObject];  // 如果是编辑模式，则最后一个 button 是 addButton；否则，最后一个 button 是选择的图片按钮列表 imageButtonList 的最后一个
    self.heightOfView = CGRectGetMaxY(lastButtonInView.frame) + self.spacingForButton;    // 重新计算 self 的高度
}

/** 拖动某个图片按钮，改变其位置。不能放置到 addButton 的后面 */
- (void)dragImageButtonAction:(UIPanGestureRecognizer *)sender {
    CGPoint offsetPoint = [sender translationInView:self];
    UIButton *button = (UIButton *)sender.view;
    CGFloat centerX = button.center.x + offsetPoint.x;
    CGFloat centerY = button.center.y + offsetPoint.y;
    CGFloat minX = centerX - CGRectGetWidth(button.bounds) / 2;
    CGFloat maxX = centerX + CGRectGetWidth(button.bounds) / 2;
    CGFloat minY = centerY - CGRectGetHeight(button.bounds) / 2;
    CGFloat maxY = centerY + CGRectGetHeight(button.bounds) / 2;
    if (sender.state == UIGestureRecognizerStateChanged) {  // 拖动过程中
        if (minX < 0 || maxX > CGRectGetWidth(self.bounds)) {    // 按钮超过整个 view 的左右两边
            return;
        }
        if (minY < 0 || maxY > CGRectGetHeight(self.bounds)) {  // 按钮超过整个 view 的上下两边
            return;
        }
        button.center = CGPointMake(centerX, centerY);
        [sender setTranslation:CGPointZero inView:self];
        
        // 改变其他按钮的位置
        for (NSUInteger i = 0; i < self.imageButtonList.count; i ++) {
            UIButton *button = self.imageButtonList[i];
        }
    } else if (sender.state == UIGestureRecognizerStateEnded) { // 拖动结束
        
    }
}

@end
