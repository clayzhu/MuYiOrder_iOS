//
//  OrderDetailTVC.m
//  MuYiOrder
//
//  Created by ug19 on 2017/4/27.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "OrderDetailTVC.h"
#import "BaseTextFieldCell.h"

static NSString *kBaseTextFieldCell = @"BaseTextFieldCell";

@interface OrderDetailTVC ()

@end

@implementation OrderDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    [self setupBackBtn];
    [self registerCell];
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
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_edit"] style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
        // 设置导航栏上按钮：编辑状态，保存按钮
    } else if (orderDetailTVCStatus == OrderDetailTVCStatusEdit) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_ok"] style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    }
}

#pragma mark - Setup
- (void)registerCell {
    [self.tableView registerNib:[UINib nibWithNibName:kBaseTextFieldCell bundle:nil] forCellReuseIdentifier:kBaseTextFieldCell];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextFieldCell forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView sectionCornerRadiusWillDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Action
/** 编辑 */
- (void)editAction {
    self.orderDetailTVCStatus = OrderDetailTVCStatusEdit;
}

/** 保存 */
- (void)saveAction {
    self.orderDetailTVCStatus = OrderDetailTVCStatusNormal;
}

@end
