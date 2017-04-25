//
//  MuYiTBC.m
//  MuYiOrder
//
//  Created by Apple on 2017/4/25.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "MuYiTBC.h"

@interface MuYiTBC ()

@end

@implementation MuYiTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.translucent = NO;
    [self setupViewControllers];
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

#pragma mark - Setup
/** 设置 tabBar 的子 vc */
- (void)setupViewControllers {
    // 订单
    UIViewController *vc = [self setWithStoryboardName:@"Order" viewControllerId:@"OrderListVC" title:@"订单" image:@"money" selectedImage:@"money_pressed"];
    BaseNavigationController *nc = [[BaseNavigationController alloc] initWithRootViewController:vc];
    // 产品
    UIViewController *vc2 = [self setWithStoryboardName:@"Product" viewControllerId:@"ProductListVC" title:@"产品" image:@"needle" selectedImage:@"needle_pressed"];
    BaseNavigationController *nc2 = [[BaseNavigationController alloc] initWithRootViewController:vc2];
    
    self.viewControllers = @[nc, nc2];
}

@end
