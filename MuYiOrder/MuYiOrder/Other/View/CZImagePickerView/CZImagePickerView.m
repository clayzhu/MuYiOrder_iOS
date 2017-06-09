//
//  CZImagePickerView.m
//  MuYiOrder
//
//  Created by ug19 on 2017/5/15.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "CZImagePickerView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

/** 删除按钮的 tag 值 */
static NSInteger kDeteleButtonTag = 910;
/** 按钮动画更新 frame 的时长 */
static CGFloat kFrameAnimationDuration = 0.3;
/** 拖动按钮变更位置时，和其他按钮的相对位置的感应阈值 */
static CGFloat kDragThresholdValue = 8.0;

@interface CZImagePickerView () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/** 私有的图片数组，用于添加图片，回调给公有的照片数组 */
@property (strong, nonatomic) NSMutableArray<UIImage *> *imageListPrivate;
/** 图片按钮数组 */
@property (strong, nonatomic) NSMutableArray<UIButton *> *imageButtonList;
/** 排在最后的添加照片的按钮 */
@property (strong, nonatomic) UIButton *addButton;

/** 最后一行将要添加的图片按钮位置 */
@property (assign, nonatomic) NSUInteger indexOfNextButton;
/** 图片按钮的行数 */
@property (assign, nonatomic) NSUInteger numberOfRows;
/** 单个按钮的长宽 */
@property (assign, nonatomic) CGFloat widthForSingleButton;
/** self 的高度，每次更新会回调 delegate */
@property (assign, nonatomic) CGFloat heightOfView;

@property (strong, nonatomic) id addButtonTarget;
@property (assign, nonatomic) SEL addButtonAction;

@end

@implementation CZImagePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize imageList = _imageList, spacingForButton = _spacingForButton, numberOfButtonInRow = _numberOfButtonInRow;

#pragma mark - Getter and Setter
- (NSArray<UIImage *> *)imageList {
    return [NSArray arrayWithArray:self.imageListPrivate];
}

- (void)setImageList:(NSArray<UIImage *> *)imageList {
    _imageList = imageList;
    [self.imageListPrivate removeAllObjects];
    [self.imageListPrivate addObjectsFromArray:imageList];
    [self redrawImageButtons];
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
        _addButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_addButton addTarget:self action:@selector(addImageAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (void)setAddButtonImage:(UIImage *)addButtonImage {
    _addButtonImage = addButtonImage;
    [self.addButton setImage:addButtonImage forState:UIControlStateNormal];
}

- (void)setDeleteButtonImage:(UIImage *)deleteButtonImage {
    _deleteButtonImage = deleteButtonImage;
    for (UIButton *button in self.imageButtonList) {
        // 设置每个图片按钮中删除按钮的图片
        UIButton *deleteButton = [button viewWithTag:kDeteleButtonTag];
        [deleteButton setImage:deleteButtonImage forState:UIControlStateNormal];
    }
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
    
    [self addSubview:self.addButton];
    [self updateAddButtonAndSelfFrame];
    [self limitMaxImageButtnsNumber];
}

- (CGFloat)spacingForButton {
    return _spacingForButton > 0.0 ? _spacingForButton : 8.0;
}

- (void)setSpacingForButton:(CGFloat)spacingForButton {
    _spacingForButton = spacingForButton > 0.0 ? spacingForButton : 8.0;
    [self redrawImageButtons];
}

- (NSUInteger)numberOfButtonInRow {
    return _numberOfButtonInRow > 0 ? _numberOfButtonInRow : 3;
}

- (void)setNumberOfButtonInRow:(NSUInteger)numberOfButtonInRow {
    _numberOfButtonInRow = numberOfButtonInRow > 0 ? numberOfButtonInRow : 3;
    [self redrawImageButtons];
}

- (NSUInteger)indexOfNextButton {
    NSUInteger remainder = self.imageButtonList.count % self.numberOfButtonInRow; // 取余
    return remainder;
}

- (NSUInteger)numberOfRows {
    NSUInteger divide = self.imageButtonList.count / self.numberOfButtonInRow;    // 除以
    NSUInteger numberOfRows = divide + (self.indexOfNextButton > 0 ? 1 : 0);
    return numberOfRows > 0 ? numberOfRows : 1;
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

- (void)setMaxImageNumber:(NSUInteger)maxImageNumber {
    _maxImageNumber = maxImageNumber;
    [self limitMaxImageButtnsNumber];
}

#pragma mark - Public
- (void)customAddButtonTarget:(id)target action:(SEL)action {
    self.addButtonTarget = target;
    self.addButtonAction = action;
    [self.addButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Setup
/** 计算某个 index 的按钮的位置，self.addButton 的 index 为 self.imageButtonList.count */
- (CGRect)frameOfButtonAtIndex:(NSUInteger)index {
    NSUInteger column = index % self.numberOfButtonInRow; // 取余
    NSUInteger row = index / self.numberOfButtonInRow;    // 除以
    CGRect frame = CGRectMake(self.spacingForButton * (column + 1) + self.widthForSingleButton * column,
                              self.spacingForButton * (row + 1) + self.widthForSingleButton * row,
                              self.widthForSingleButton, self.widthForSingleButton);
    return frame;
}

/** 动画改变 button 的位置 */
- (void)animateForButton:(UIButton *)button withFrame:(CGRect)frame {
    [UIView animateWithDuration:kFrameAnimationDuration
                     animations:^{
                         button.frame = frame;
                     }];
}

/** 在指定位置创建图片按钮 */
- (void)createButtonWithImage:(UIImage *)image atIndex:(NSUInteger)index {
    // 创建新的图片 button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    button.tag = index;
    
    // 创建内部删除 button
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setImage:(self.deleteButtonImage == nil ? [UIImage imageNamed:@"deleteImage_CZImagePickerView"] : self.deleteButtonImage) forState:UIControlStateNormal];
    deleteButton.frame = CGRectMake(self.widthForSingleButton - 22.0, 0.0, 22.0, 22.0);
    [deleteButton addTarget:self action:@selector(deleteImageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    deleteButton.tag = kDeteleButtonTag;
    deleteButton.hidden = !self.isEdit;
    [button addSubview:deleteButton];
    
    // 创建拖动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragImageButtonAction:)];
    panGesture.enabled = self.isEdit;
    [button addGestureRecognizer:panGesture];
    
    button.frame = [self frameOfButtonAtIndex:index];   // 绘制图片按钮的位置
    [self.imageButtonList addObject:button];
    [self addSubview:button];
}

/** 更新 addButton 和 self 的 frame */
- (void)updateAddButtonAndSelfFrame {
    // 重新绘制 addButton 的位置，方法和上面类似
    self.addButton.frame = [self frameOfButtonAtIndex:self.imageButtonList.count];
    
    UIButton *lastButtonInView = self.isEdit ? self.addButton : [self.imageButtonList lastObject];  // 如果是编辑模式，则最后一个 button 是 addButton；否则，最后一个 button 是选择的图片按钮列表 imageButtonList 的最后一个
    self.heightOfView = CGRectGetMaxY(lastButtonInView.frame) + self.spacingForButton;    // 重新计算 self 的高度
}

/** 重新绘制按钮视图 */
- (void)redrawImageButtons {
    // 重新绘制按钮视图
    for (UIButton *button in self.imageButtonList) {
        [button removeFromSuperview];
    }
    [self.imageButtonList removeAllObjects];
    
    for (NSUInteger i = 0; i < self.imageListPrivate.count; i ++) {
        UIImage *image = self.imageListPrivate[i];
        [self createButtonWithImage:image atIndex:i];
    }
    [self updateAddButtonAndSelfFrame];
    [self limitMaxImageButtnsNumber];
}

/** 根据 maxImageNumber 限制最大可以添加的图片，隐藏 addButton 等 */
- (void)limitMaxImageButtnsNumber {
    if (self.maxImageNumber > 0) {
        if (self.imageButtonList.count >= self.maxImageNumber) {    // 删除多余的图片按钮
            NSRange willRemoveRange = NSMakeRange(self.maxImageNumber, self.imageButtonList.count - self.maxImageNumber);
            NSArray<UIButton *> *willRemoveButtons = [self.imageButtonList objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:willRemoveRange]];
            [self.imageListPrivate removeObjectsInRange:willRemoveRange];
            [self.imageButtonList removeObjectsInArray:willRemoveButtons];
            for (UIButton *button in willRemoveButtons) {
                [button removeFromSuperview];
            }
            // 重新绘制 addButton 的位置，方法和上面类似
            self.addButton.frame = [self frameOfButtonAtIndex:self.imageButtonList.count];
            self.addButton.hidden = YES;
            UIButton *lastButtonInView = [self.imageButtonList lastObject];  // 如果是编辑模式，则最后一个 button 是 addButton；否则，最后一个 button 是选择的图片按钮列表 imageButtonList 的最后一个
            self.heightOfView = CGRectGetMaxY(lastButtonInView.frame) + self.spacingForButton;    // 重新计算 self 的高度
        } else {
            [self updateAddButtonAndSelfFrame];
            self.addButton.hidden = !self.isEdit;
        }
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
    
    // 更新从 index 开始的后面所有按钮的位置
    for (; index < self.imageButtonList.count; index ++) {
        UIButton *button = self.imageButtonList[index];
        [self animateForButton:button withFrame:[self frameOfButtonAtIndex:index]];
        button.tag = index;
    }
    
    if (self.maxImageNumber == 0 || (self.maxImageNumber > 0 && self.maxImageNumber - self.imageButtonList.count > 1)) {    // 没有设置图片上限，或，删除之后图片按钮数量比上限至少少2个（即删除之前 addButton 可见，并且在最大位置）
        [self animateForButton:self.addButton withFrame:[self frameOfButtonAtIndex:self.imageButtonList.count]];    // 动画更新添加按钮的位置
    }
    
    [self updateAddButtonAndSelfFrame];
    [self limitMaxImageButtnsNumber];
}

/** 拖动某个图片按钮，改变其位置。不能放置到 addButton 的后面 */
- (void)dragImageButtonAction:(UIPanGestureRecognizer *)sender {
#warning bug: overlap when drag from up to down to up
    CGPoint offsetPoint = [sender translationInView:self];
    UIButton *button = (UIButton *)sender.view;
    UIImage *image = self.imageListPrivate[button.tag];
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
            UIButton *otherButton = self.imageButtonList[i];
            CGPoint velocity = [sender velocityInView:self];
            if (velocity.x < 0) {   // 向左拖动，则原来左边的按钮向右移动，两个按钮互换位置
                if (otherButton.center.x - kDragThresholdValue <= minX && minX <= otherButton.center.x + kDragThresholdValue && CGRectGetMinY(otherButton.frame) <= centerY && centerY <= CGRectGetMaxY(otherButton.frame)) {   // button 的左边在 otherButton 中线 x 的附近，且 button 的中线 y 在 otherButton 的上下之间
                    if (otherButton.tag == self.imageButtonList.count - 1) {    // 左边的是最后一个按钮。这种情况发生在上排的按钮向下拖动到 addButton 或最后的空白处区域，再往左靠近最后一个按钮。按照按钮向下拖动处理
                        [self.imageListPrivate removeObjectAtIndex:button.tag]; // 先移除 button 原来位置的图片，再插入到新位置中
                        [self.imageListPrivate insertObject:image atIndex:i];
                        [self.imageButtonList removeObjectAtIndex:button.tag];
                        [self.imageButtonList insertObject:button atIndex:i];
                        NSUInteger buttonOldIndex = button.tag; // button 原来的位置
                        button.tag = i; // button 设置新的 tag 值，即新的位置
                        for (NSUInteger j = buttonOldIndex; j < i; j ++) {  // 更新下边的按钮和 button 之间的按钮（不包括 button）的位置
                            UIButton *button = self.imageButtonList[j];
                            [self animateForButton:button withFrame:[self frameOfButtonAtIndex:j]];
                            button.tag = j;
                        }
                        break;
                    }
                    [self.imageListPrivate exchangeObjectAtIndex:i withObjectAtIndex:button.tag];   // 左右两边图片位置互换
                    [self.imageButtonList exchangeObjectAtIndex:i withObjectAtIndex:button.tag];    // 左右两边按钮位置互换
                    otherButton.tag = button.tag;   // 左右两边按钮 tag 互换
                    button.tag = i;
                    [self animateForButton:otherButton withFrame:[self frameOfButtonAtIndex:i + 1]];
                    break;
                }
            }
            if (velocity.x > 0) {   // 向右拖动，则原来右边的按钮向左移动，两个按钮互换位置
                if (otherButton.center.x - kDragThresholdValue <= maxX && maxX <= otherButton.center.x + kDragThresholdValue && CGRectGetMinY(otherButton.frame) <= centerY && centerY <= CGRectGetMaxY(otherButton.frame)) {   // button 的右边在 otherButton 中线 x 的附近，且 button 的中线 y 在 otherButton 的上下之间
                    [self.imageListPrivate exchangeObjectAtIndex:i withObjectAtIndex:button.tag];   // 左右两边图片位置互换
                    [self.imageButtonList exchangeObjectAtIndex:i withObjectAtIndex:button.tag];    // 左右两边按钮位置互换
                    otherButton.tag = button.tag;   // 左右两边按钮 tag 互换
                    button.tag = i;
                    [self animateForButton:otherButton withFrame:[self frameOfButtonAtIndex:i - 1]];
                    break;
                }
            }
            if (velocity.y < 0) {   // 向上拖动，则原来上边的按钮和 button 之间的按钮都向右移动
                if (otherButton.center.y - kDragThresholdValue <= minY && minY <= otherButton.center.y + kDragThresholdValue && CGRectGetMinX(otherButton.frame) <= centerX && centerX <= CGRectGetMaxX(otherButton.frame)) {   // button 的上边在 otherButton 中线 y 的附近，且 button 的中线 x 在 otherButton 的左右之间
                    [self.imageListPrivate removeObjectAtIndex:button.tag]; // 先移除 button 原来位置的图片，再插入到新位置中
                    [self.imageListPrivate insertObject:image atIndex:i];
                    [self.imageButtonList removeObjectAtIndex:button.tag];
                    [self.imageButtonList insertObject:button atIndex:i];
                    NSUInteger buttonOldIndex = button.tag; // button 原来的位置
                    button.tag = i; // button 设置新的 tag 值，即新的位置
                    for (NSUInteger j = i + 1; j <= buttonOldIndex; j ++) { // 更新上边的按钮和 button 之间的按钮（不包括 button）的位置
                        UIButton *button = self.imageButtonList[j];
                        [self animateForButton:button withFrame:[self frameOfButtonAtIndex:j]];
                        button.tag = j;
                    }
                    break;
                }
            }
            if (velocity.y > 0) {   // 向下拖动，则原来下边的按钮和 button 之间的按钮都向左移动
                if (otherButton.center.y - kDragThresholdValue <= maxY && maxY <= otherButton.center.y + kDragThresholdValue && CGRectGetMinX(otherButton.frame) <= centerX && centerX <= CGRectGetMaxX(otherButton.frame)) {   // button 的下边在 otherButton 中线 y 的附近，且 button 的中线 x 在 otherButton 的左右之间
                    [self.imageListPrivate removeObjectAtIndex:button.tag]; // 先移除 button 原来位置的图片，再插入到新位置中
                    [self.imageListPrivate insertObject:image atIndex:i];
                    [self.imageButtonList removeObjectAtIndex:button.tag];
                    [self.imageButtonList insertObject:button atIndex:i];
                    NSUInteger buttonOldIndex = button.tag; // button 原来的位置
                    button.tag = i; // button 设置新的 tag 值，即新的位置
                    for (NSUInteger j = buttonOldIndex; j < i; j ++) {  // 更新下边的按钮和 button 之间的按钮（不包括 button）的位置
                        UIButton *button = self.imageButtonList[j];
                        [self animateForButton:button withFrame:[self frameOfButtonAtIndex:j]];
                        button.tag = j;
                    }
                    break;
                }
            }
        }
    } else if (sender.state == UIGestureRecognizerStateEnded) { // 拖动结束
        [self animateForButton:button withFrame:[self frameOfButtonAtIndex:button.tag]];    // 根据 button 的 tag 值，即得到 button 新的位置，直接动画更新 button 的 frame
    }
}

/** 添加图片 */
- (void)addImageAction:(UIButton *)sender {
    if (self.addButtonTarget && self.addButtonAction) {
        if (!self.addButtonTarget) {
            return;
        }
        IMP imp = [self.addButtonTarget methodForSelector:self.addButtonAction];
        void (*func)(id, SEL) = (void *)imp;
        func(self.addButtonTarget, self.addButtonAction);
    } else {
        [self showActionSheet];
    }
}

#pragma mark - Pick Photo
/** 显示【拍照】【从手机相册选择】的选项 */
- (void)showActionSheet {
    UIViewController *vc = self.presentingViewController == nil ? [UIApplication sharedApplication].keyWindow.rootViewController : self.presentingViewController;
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [ac addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * _Nonnull action) {
                                             if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusDenied) {
                                                 UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:@"请在 iPhone 的“设置-隐私-相机”选项中，允许应用访问您的摄像头。" preferredStyle:UIAlertControllerStyleAlert];
                                                 [ac addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                                                 [vc presentViewController:ac animated:YES completion:nil];
                                                 return;
                                             }
                                             UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                                             imagePicker.delegate = self;
                                             imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                             [vc presentViewController:imagePicker animated:YES completion:nil];
                                         }]];
    [ac addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * _Nonnull action) {
                                             if ([ALAssetsLibrary authorizationStatus] == AVAuthorizationStatusDenied) {
                                                 UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:@"请在 iPhone 的“设置-隐私-照片”选项中，允许应用访问您的手机相册。" preferredStyle:UIAlertControllerStyleAlert];
                                                 [ac addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                                                 [vc presentViewController:ac animated:YES completion:nil];
                                                 return;
                                             }
                                             UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                                             imagePicker.delegate = self;
                                             imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                             [vc presentViewController:imagePicker animated:YES completion:nil];
                                         }]];
    [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [vc presentViewController:ac animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES
                               completion:^{
                                   [self createButtonWithImage:originImage atIndex:self.imageListPrivate.count];
                                   [self.imageListPrivate addObject:originImage];    // 添加图片
                                   [self updateAddButtonAndSelfFrame];
                                   [self limitMaxImageButtnsNumber];
                               }];
}

@end
