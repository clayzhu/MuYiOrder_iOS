//
//  ProjectUtility.h
//  Baicheng
//
//  Created by Apple on 2017/4/24.
//  Copyright © 2017年 Ugoodtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectUtility : NSObject

/** 根据是否登录设置默认 vc */
+ (UIViewController *)rootViewController;

#pragma mark - 常量列表
/** 发货状态常量列表 */
+ (NSArray<NSString *> *)deliverStatusList;
/** 付款状态常量列表 */
+ (NSArray<NSString *> *)payStatusList;
/** 付款渠道常量列表 */
+ (NSArray<NSString *> *)payWayList;

@end
