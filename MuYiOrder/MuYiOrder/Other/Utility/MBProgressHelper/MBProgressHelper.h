//
//  MBProgressHelper.h
//  EnjoyiOS
//
//  Created by ug19 on 16/5/11.
//  Copyright © 2016年 Ugood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

// AppDelegate
#define APPDELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]
// window
#define WINDOW_MAIN [APPDELEGATE window]

typedef void (^MBProgressHelperCompletionBlock)();

@interface MBProgressHelper : NSObject

#pragma mark - ProgressHUD in View
/**
 *  在指定视图上显示一个指定文字的 loading 菊花，在指定时间后消失
 *
 *  @param view    显示 loading 的视图
 *  @param message 显示在 loading 上的文字
 *  @param delay   显示 loading 的时间，delay 秒之后消失
 */
+ (void)showProgressHUDInView:(UIView *)view withMessage:(NSString *)message hideDelay:(NSTimeInterval)delay;
/** 在指定视图上显示一个指定文字的 loading 菊花，在20.0秒后消失 */
+ (void)showProgressHUDInView:(UIView *)view withMessage:(NSString *)message;
/** 在指定视图上显示"加载中"的 loading 菊花，在20.0秒后消失 */
+ (void)showProgressHUDInView:(UIView *)view;
/** 隐藏指定视图上的所有 loading */
+ (void)hideAllHUDsForView:(UIView *)view;
#pragma mark Text HUD
/**
 *  在指定视图上显示一个指定文字的纯文字提示，在指定时间后消失
 *
 *  @param view       显示文字提示的视图
 *  @param message    显示在提示上的文字
 *  @param delay      显示提示的时间，delay 秒之后消失
 *  @param completion Hud 消失后的回调
 */
+ (void)showTextHUDInView:(UIView *)view withMessage:(NSString *)message hideDelay:(NSTimeInterval)delay completionBlock:(MBProgressHelperCompletionBlock)completion;
/**
 *  在指定视图上显示一个指定文字的纯文字提示，2.0秒后消失
 *
 *  @param view    显示文字提示的视图
 *  @param message 显示在提示上的文字
 *  @param completion Hud 消失后的回调
 */
+ (void)showTextHUDInView:(UIView *)view withMessage:(NSString *)message completionBlock:(MBProgressHelperCompletionBlock)completion;
/** 没有网络时提示网络错误，2.0秒后消失 */
+ (void)showNoNetworkErrorTipInView:(UIView *)view completionBlock:(MBProgressHelperCompletionBlock)completion;

#pragma mark - ProgressHUD in Window
+ (void)showProgressHUDWithMessage:(NSString *)message hideDelay:(NSTimeInterval)delay;
+ (void)showProgressHUDWithMessage:(NSString *)message;
+ (void)showProgressHUD;
+ (void)hideProgressHUD;
+ (void)showTextHUDWithMessage:(NSString *)message hideDelay:(NSTimeInterval)delay completionBlock:(MBProgressHelperCompletionBlock)completion;
+ (void)showTextHUDWithMessage:(NSString *)message completionBlock:(MBProgressHelperCompletionBlock)completion;
+ (void)showTextHUDWithMessage:(NSString *)message;
+ (void)showNoNetworkErrorTipCompletionBlock:(MBProgressHelperCompletionBlock)completion;
+ (void)showNoNetworkErrorTip;
/**
 *  在 Window 上显示一个上面图片下面文字的提示
 *
 *  @param image      显示的图片
 *  @param message    显示的文字提示
 *  @param delay      显示提示的时间，delay 秒之后消失
 *  @param completion Hud 消失后的回调
 */
+ (void)showImageHUD:(UIImage *)image message:(NSString *)message hideDelay:(NSTimeInterval)delay completionBlock:(MBProgressHelperCompletionBlock)completion;

/** 展示自定义的 gif 视图 */
+ (void)showGifProgressHUD;

@end
