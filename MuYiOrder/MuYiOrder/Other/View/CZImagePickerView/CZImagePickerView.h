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

@optional
- (void)czImagePickerView:(CZImagePickerView *)czImagePickerView heightOfView:(CGFloat)height imageListDidPick:(NSArray<UIImage *> *)imageList;

@end

@interface CZImagePickerView : UIView

/** 图片数组，可以设置一组默认图片 */
@property (strong, nonatomic) NSArray<UIImage *> *imageList;
/** 设置添加按钮的图片 */
@property (strong, nonatomic) UIImage *addButtonImage;
/** 设置每个图片按钮中删除按钮的图片 */
@property (strong, nonatomic) UIImage *deleteButtonImage;
#warning functions need to be developed
/** 设置 CZImagePickerView 是否可以编辑。YES-编辑模式，NO-查看模式 */
@property (assign, nonatomic, getter=isEdit) BOOL edit; // editable
/** 设置 CZImagePickerView 是否可以拖动更换图片位置。YES-可拖动模式，NO-静态模式模式 */
@property (assign, nonatomic, getter=isPanable) BOOL panable;

/** 按钮之间、按钮和边框的间距。默认为8.0 */
@property (assign, nonatomic) CGFloat spacingForButton;
/** 一行的图片按钮数量。默认为3 */
@property (assign, nonatomic) NSUInteger numberOfButtonInRow;
/** 允许添加的图片上限 */
@property (assign, nonatomic) NSUInteger maxImageNumber;
#warning functions need to be developed
/** 按钮在视图中 x 的偏移 */
@property (assign, nonatomic) CGFloat offsetXOfButtonInView;
/** 按钮在视图中 y 的偏移 */
@property (assign, nonatomic) CGFloat offsetYOfButtonInView;
/** 单个按钮视图的高度 */
@property (assign, nonatomic) CGFloat heightOfButtonView;

@property (weak, nonatomic) id<CZImagePickerViewDelegate> delegate;
/** 弹出 UIAlertController, UIImagePickerController 的 viewController。默认为 App 的 rootViewController */
@property (strong, nonatomic) UIViewController *presentingViewController;
/** 遍历 App 层级，获取当前 UIViewController */
@property (strong, nonatomic) UIViewController *currentViewController;

/** 设置添加按钮的自定义的执行方法 */
- (void)customAddButtonTarget:(id)target action:(SEL)action;

@end
