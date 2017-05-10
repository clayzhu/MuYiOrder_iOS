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
@property (strong, nonatomic) NSArray<NSArray<NSString *> *> *cellTextList;

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

- (NSArray<NSArray<NSString *> *> *)cellTextList {
    if (!_cellTextList) {
        _cellTextList = @[@[@"客户", @"电话", @"下单时间", @"收货地址"],
                          @[@"发货状态", @"发货时间", @"物流信息", @"快递单号"],
                          @[@"订单金额", @"付款状态", @"付款渠道"]];
    }
    return _cellTextList;
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
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 3) {
        BaseTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextFieldCell forIndexPath:indexPath];
        cell.textLabel.text = self.cellTextList[indexPath.section][indexPath.row];
        cell.separatorLine.hidden = indexPath.row == self.cellTextList[indexPath.section].count - 1 ? YES : NO; // 每一个 section 的最后一个 cell 不显示 separator
        return cell;
    } else {
        BaseTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextFieldCell forIndexPath:indexPath];
        return cell;
    }
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
