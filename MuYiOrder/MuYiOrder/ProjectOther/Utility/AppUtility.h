//
//  AppUtility.h
//  TianChengSoundbox
//
//  Created by ug19 on 15/12/23.
//  Copyright © 2015年 Ugood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstant.h"

@interface AppUtility : NSObject

#pragma mark - sign in
/** Determine whether user sign in*/
+ (BOOL)isSignedIn;
/** 登录 */
+ (void)signIn;
/** 登出（并清空保存信息） */
+ (void)signOut;

#pragma mark - DeviceToken
/** 将 NSData 类型的 deviceToken 转化为 NSString 类型 */
+ (NSString *)deviceTokenStringFromData:(NSData *)deviceToken;
/** 保存 NSData 类型的 deviceToken 到 NSUserDefaults */
+ (void)saveDeviceTokenData:(NSData *)deviceToken;
/** 获取 deviceToken */
+ (NSString *)getDeviceToken;
/** 删除 deviceToken */
+ (void)removeDeviceToken;

@end
