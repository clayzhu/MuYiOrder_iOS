//
//  OrderListVC.m
//  MuYiOrder
//
//  Created by Apple on 2017/4/25.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "OrderListVC.h"
#import "TopFilterView.h"

@interface OrderListVC () <TopFilterViewDelegate>
@property (weak, nonatomic) IBOutlet TopFilterView *topFilterView;

@end

@implementation OrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"都是钱";
    [self setupNavItem];
    [self setupTopFilterView];
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"new_pressed"] style:UIBarButtonItemStylePlain target:self action:@selector(addNewOrder)];
}

/** 设置顶部筛选视图 */
- (void)setupTopFilterView {
    self.topFilterView.titles = @[@"所有订单", @"未完成", @"已完成"];
    self.topFilterView.titleHeight = 42.0;
    [self.topFilterView createFilterView];
    self.topFilterView.delegate = self;
}

#pragma mark - Action
/** 添加新订单 */
- (void)addNewOrder {
    
}

#pragma mark TopFilterViewDelegate
- (void)topFilterView:(TopFilterView *)filterView didSelectTitle:(NSString *)title atIndex:(NSInteger)index {
    
}

@end
