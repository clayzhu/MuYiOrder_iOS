//
//  OrderDetailTVC.m
//  MuYiOrder
//
//  Created by ug19 on 2017/4/27.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "OrderDetailTVC.h"

@interface OrderDetailTVC ()

@end

@implementation OrderDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    [self setupBackBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Getter and Setter
- (void)setOrderDetailTVCStatus:(OrderDetailTVCStatus)orderDetailTVCStatus {
    _orderDetailTVCStatus = orderDetailTVCStatus;
    if (orderDetailTVCStatus == OrderDetailTVCStatusNormal) {
        // 设置导航栏上按钮：查看状态，编辑按钮
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_edit"] style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
        // 设置导航栏上按钮：编辑状态，保存按钮
    } else if (orderDetailTVCStatus == OrderDetailTVCStatusEdit) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_ok"] style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    }
}

#pragma mark - Setup

#pragma mark - Action
- (void)saveAction {
    
}

@end
