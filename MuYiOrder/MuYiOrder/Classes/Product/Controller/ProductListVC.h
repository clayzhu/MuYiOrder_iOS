//
//  ProductListVC.h
//  MuYiOrder
//
//  Created by Apple on 2017/4/25.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "BaseViewController.h"

/**
 进入 ProductListVC 的模式

 - ProductListVCTypeNormal: 普通模式，通过 tabBar 进入
 - ProductListVCTypePick: 选择产品模式，通过订单详情页进入
 */
typedef NS_ENUM(NSUInteger, ProductListVCType) {
    ProductListVCTypeNormal,
    ProductListVCTypePick,
};

@interface ProductListVC : BaseViewController

@property (assign, nonatomic) ProductListVCType productListVCType;

@end
