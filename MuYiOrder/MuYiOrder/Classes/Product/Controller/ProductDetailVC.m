//
//  ProductDetailVC.m
//  MuYiOrder
//
//  Created by ug19 on 2017/5/16.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "ProductDetailVC.h"

@interface ProductDetailVC ()

@end

@implementation ProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新花样";
    [self setupBackBtn];
    [self setupNavItem];
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
/** 设置导航栏上按钮 */
- (void)setupNavItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_ok"] style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
}

#pragma mark - Action
/** 保存 */
- (void)saveAction {
    
}

@end
