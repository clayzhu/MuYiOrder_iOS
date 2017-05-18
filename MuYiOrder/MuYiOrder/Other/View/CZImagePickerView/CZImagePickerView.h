//
//  CZImagePickerView.h
//  MuYiOrder
//
//  Created by ug19 on 2017/5/15.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZImagePickerView;

@protocol CZImagePickerViewDelegate <NSObject>

- (void)czImagePickerView:(CZImagePickerView *)czImagePickerView heightOfView:(CGFloat)height imageListDidPick:(NSArray<UIImage *> *)imageList;

@end

@interface CZImagePickerView : UIView

@property (strong, nonatomic) NSArray<UIImage *> *imageList;
@property (strong, nonatomic) UIImage *addButtonImage;

@property (assign, nonatomic, getter=isEdit) BOOL edit;

- (void)setupImagePickerView;

@end
