//
//  ProjectUtility.m
//  Baicheng
//
//  Created by Apple on 2017/4/24.
//  Copyright © 2017年 Ugoodtech. All rights reserved.
//

#import "ProjectUtility.h"
#import "LoginVC.h"
#import "MuYiTBC.h"

@implementation ProjectUtility

+ (UIViewController *)rootViewController {
    if ([AppUtility isSignedIn]) {  // 已登录
        MuYiTBC *tbc = [[MuYiTBC alloc] init];
        return tbc;
    }
    // 未登录
    LoginVC *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginVC"];
    BaseNavigationController *nc = [[BaseNavigationController alloc] initWithRootViewController:vc];
    return nc;
}

+ (NSArray<NSString *> *)deliverStatusList {
    return @[@"待发货", @"待收货", @"已收货"];
}

+ (NSArray<NSString *> *)payStatusList {
    return @[@"待付款", @"已付款"];
}

+ (NSArray<NSString *> *)payWayList {
    return @[@"支付宝", @"微信", @"现金", @"银行卡"];
}

@end
