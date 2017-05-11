//
//  OrderDetailTVC.h
//  MuYiOrder
//
//  Created by ug19 on 2017/4/27.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "BaseTableViewController.h"

/**
 订单详情查看／编辑状态

 - OrderDetailTVCStatusNormal: 查看状态
 - OrderDetailTVCStatusEdit: 编辑状态
 */
typedef NS_ENUM(NSUInteger, OrderDetailTVCStatus) {
    OrderDetailTVCStatusNormal = 0,
    OrderDetailTVCStatusEdit = 1,
};

@interface OrderDetailTVC : BaseTableViewController

@property (assign, nonatomic) OrderDetailTVCStatus orderDetailTVCStatus;

@end
