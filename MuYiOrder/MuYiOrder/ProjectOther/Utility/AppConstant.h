//
//  AppConstant.h
//  EnjoyiOS
//
//  Created by ug19 on 16/5/12.
//  Copyright © 2016年 Ugood. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 友盟 Appkey */
FOUNDATION_EXPORT NSString *const kUmengAppKey;
/** 微信 AppID */
FOUNDATION_EXPORT NSString *const kWXAppId;
/** 微信 AppSecret */
FOUNDATION_EXPORT NSString *const kWXAppSecret;

// NotificationCenter Name
/** 用户登录 NotificationCenter Name */
FOUNDATION_EXPORT NSString *const kLoginNotification;

// UserDefaults Key
/** 判断登录的key */
FOUNDATION_EXPORT NSString *const kLogined;
/** 用户 Model 信息 UserDefaults Key */
FOUNDATION_EXPORT NSString *const kUserModel;
/** 登录授权 AccessToken Key */
FOUNDATION_EXPORT NSString *const kAccessToken;
/** phoneTf text */
FOUNDATION_EXPORT NSString *const kPhontTextFieldContent;
/** DeviceToken Key */
FOUNDATION_EXPORT NSString *const kDeviceToken;
/** 非首次打开应用 Key */
FOUNDATION_EXPORT NSString *const kNotFirstOpenApp;

/** 一页数据的数量 */
FOUNDATION_EXPORT NSInteger const countPerPage;

/** 轮盘选择器的高度 */
FOUNDATION_EXPORT CGFloat const pickerViewHeight;
