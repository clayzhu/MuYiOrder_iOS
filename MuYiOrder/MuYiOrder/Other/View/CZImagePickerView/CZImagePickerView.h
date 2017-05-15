//
//  CZImagePickerView.h
//  MuYiOrder
//
//  Created by ug19 on 2017/5/15.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZImagePickerView : UIView

@property (strong, nonatomic) NSArray<UIImage *> *imageList;
@property (strong, nonatomic) UIImage *addButtonImage;

- (void)setupImagePickerView;

@end
