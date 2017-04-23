//
//  BaseViewController.h
//  EnjoyiOS
//
//  Created by Ug's iMac on 16/8/31.
//  Copyright © 2016年 Ugood. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 作为一个项目的父 ViewController，可以继承使用一些通用功能 */
@interface BaseViewController : UIViewController <UIGestureRecognizerDelegate>

/** self.title 的字体颜色 */
@property (strong, nonatomic) UIColor *titleColor;
/** 设置为 YES 时，禁用侧滑返回手势 */
@property (nonatomic) BOOL cannotPopByGestureRecognizer;

//@property (assign, nonatomic) CGRect keyboardFrame;
///** 键盘已显示，通过 [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height 获取键盘的高度 */
//- (void)keyboardDidShow:(NSNotification *)notification;

/** 设置 VC 导航栏左侧的返回按钮，为 pop 操作，可自定义返回按钮的图片 */
- (void)setupBackBtnWithBackImage:(UIImage *)backImage pressedImage:(UIImage *)pressedImage;
/** 设置 VC 导航栏左侧的返回按钮，为 pop 操作，使用大部分项目统一的返回按钮图片 */
- (void)setupBackBtn;
/** pop 的返回操作 */
- (void)back;
/** 指示页面返回时是否直接返回到本 tab 的 rootVC */
@property (assign, nonatomic) BOOL popToRootVC;

#pragma mark - 设置导航栏按钮
// 左
- (void)setDismissBtnWithImageName:(NSString *)imageName;
- (void)setBackBtnWithImageName:(NSString *)imageName;
- (void)setLeftBarButtonitemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;
// 右
- (void)setRightBarButtonitemWithTitle:(NSString *)title target:(id)target action:(SEL)action imageName:(NSString *)imageName;
- (void)setRightBarButtonitemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

#pragma mark - 页面 push
- (void)pushToSb:(NSString *)sb vc:(NSString *)vc;
- (void)pushForTabbarToSb:(NSString *)sb vc:(NSString *)vc;
- (void)pushVc:(UIViewController *)vc;
- (void)pushForTabbarVc:(UIViewController *)vc;

#pragma mark - 页面 present
- (void)presentToSb:(NSString *)sb vc:(NSString *)vc completion:(void (^)(void))completion;
- (void)presentForTabbarToSb:(NSString *)sb vc:(NSString *)vc completion:(void (^)(void))completion;
- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion;
- (void)presentForTabbarVc:(UIViewController *)vc completion:(void (^)(void))completion;

///** 判断是否已登录，已登录则处理 handler 请求，未登录则弹出登录页 */
//- (void)loginHandler:(void (^)(void))handler mobile:(NSString *)mobile;
///** 登出，弹出登录页，并在登录后处理 handler 请求 */
//- (void)logoutHandler:(void (^)(void))handler;

@end

@interface UIImage (VCColor)

/** 生成一张所需颜色的图片，大小为(50.0, 50.0) */
+ (UIImage *)imageWithColorForViewController:(UIColor *)color;

@end
