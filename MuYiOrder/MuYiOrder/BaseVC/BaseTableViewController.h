//
//  BaseTableViewController.h
//  EnjoyiOS
//
//  Created by Ug's iMac on 16/8/31.
//  Copyright © 2016年 Ugood. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 作为一个项目的父 TableViewController，可以继承使用一些通用功能 */
@interface BaseTableViewController : UITableViewController <UIGestureRecognizerDelegate>

/** self.title 的字体颜色 */
@property (strong, nonatomic) UIColor *titleColor;
/** 设置为 YES 时，禁用侧滑返回手势 */
@property (nonatomic) BOOL cannotPopByGestureRecognizer;

/** 设置 VC 导航栏左侧的返回按钮，为 pop 操作，可自定义返回按钮的图片 */
- (void)setupBackBtnWithBackImage:(UIImage *)backImage pressedImage:(UIImage *)pressedImage;
/** 设置 VC 导航栏左侧的返回按钮，为 pop 操作，使用大部分项目统一的返回按钮图片 */
- (void)setupBackBtn;
/** pop 的返回操作 */
- (void)back;
/** 指示页面返回时是否直接返回到本 tab 的 rootVC */
@property (assign, nonatomic) BOOL popToRootVC;

///** 判断是否已登录，已登录则处理 handler 请求，未登录则弹出登录页 */
//- (void)loginHandler:(void (^)(void))handler mobile:(NSString *)mobile;
///** 登出，弹出登录页，并在登录后处理 handler 请求 */
//- (void)logoutHandler:(void (^)(void))handler;

@end

@interface UIImage (TVCColor)

/** 生成一张所需颜色的图片，大小为(50.0, 50.0) */
+ (UIImage *)imageWithColorForTableViewController:(UIColor *)color;

@end
