//
//  OrderDetailTVC.m
//  MuYiOrder
//
//  Created by ug19 on 2017/4/27.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "OrderDetailTVC.h"
#import "BaseTextFieldCell.h"
#import "BaseTextLabelCell.h"
#import "BaseTextFieldWithUnitCell.h"
#import "CZPickerView.h"

static NSString *kBaseTextFieldCell = @"BaseTextFieldCell";
static NSString *kBaseTextLabelCell = @"BaseTextLabelCell";
static NSString *kBaseTextFieldWithUnitCell = @"BaseTextFieldWithUnitCell";

@interface OrderDetailTVC () <UITextFieldDelegate>
/** cell 标题 */
@property (strong, nonatomic) NSArray<NSArray<NSString *> *> *cellTitleList;
/** cell 内容 */
@property (strong, nonatomic) NSMutableArray<NSMutableArray<NSString *> *> *cellContentList;

@property (strong, nonatomic) CZPickerView *czPickerView;

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
    [self.tableView reloadData];
}

- (NSArray<NSArray<NSString *> *> *)cellTitleList {
    if (!_cellTitleList) {
        _cellTitleList = @[@[@"客户", @"电话", @"下单时间", @"收货地址"],
                          @[@"发货状态", @"发货时间", @"物流信息", @"快递单号"],
                          @[@"订单金额", @"付款状态", @"付款渠道"]];
    }
    return _cellTitleList;
}

- (NSMutableArray<NSMutableArray<NSString *> *> *)cellContentList {
    if (!_cellContentList) {
        _cellContentList = [NSMutableArray array];
        for (NSArray *array in self.cellTitleList) {
            NSMutableArray *subMA = [NSMutableArray array];
            for (NSUInteger i = 0; i < array.count; i ++) {
                [subMA addObject:@""];
            }
            [_cellContentList addObject:subMA];
        }
    }
    return _cellContentList;
}

- (CZPickerView *)czPickerView {
    if (!_czPickerView) {
        _czPickerView = [[CZPickerView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
        [_czPickerView setupPickerView];
    }
    return _czPickerView;
}

#pragma mark - Setup
- (void)registerCell {
    [self.tableView registerNib:[UINib nibWithNibName:kBaseTextFieldCell bundle:nil] forCellReuseIdentifier:kBaseTextFieldCell];
    [self.tableView registerNib:[UINib nibWithNibName:kBaseTextLabelCell bundle:nil] forCellReuseIdentifier:kBaseTextLabelCell];
    [self.tableView registerNib:[UINib nibWithNibName:kBaseTextFieldWithUnitCell bundle:nil] forCellReuseIdentifier:kBaseTextFieldWithUnitCell];
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
        NSString *cellTitle = self.cellTitleList[indexPath.section][indexPath.row]; // cell 标题
        NSString *cellContent = self.cellContentList[indexPath.section][indexPath.row]; // cell 内容
        
        switch (indexPath.section) {
            case 0: // 客户、电话、下单时间、收货地址
            {
                switch (indexPath.row) {
                    case 0: // 客户
                    {
                        BaseTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextFieldCell forIndexPath:indexPath];
                        cell.textLabel.text = cellTitle;
                        cell.textField.text = cellContent;
                        cell.textField.delegate = self;
                        cell.textField.tag = indexPath.section * 10 + indexPath.row;
                        cell.textField.keyboardType = UIKeyboardTypeDefault;
                        cell.textField.enabled = self.orderDetailTVCStatus;
                        cell.separatorLine.hidden = NO; // 每一个 section 的最后一个 cell 不显示 separator，前几个 cell 显示
                        return cell;
                    }
                        break;
                    case 1: // 电话
                    {
                        BaseTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextFieldCell forIndexPath:indexPath];
                        cell.textLabel.text = cellTitle;
                        cell.textField.text = cellContent;
                        cell.textField.delegate = self;
                        cell.textField.tag = indexPath.section * 10 + indexPath.row;
                        cell.textField.keyboardType = UIKeyboardTypePhonePad;
                        cell.textField.enabled = self.orderDetailTVCStatus;
                        cell.separatorLine.hidden = NO; // 每一个 section 的最后一个 cell 不显示 separator，前几个 cell 显示
                        return cell;
                    }
                        break;
                    case 2: // 下单时间
                    {
                        BaseTextLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextLabelCell forIndexPath:indexPath];
                        cell.textLabel.text = cellTitle;
                        cell.detailTextLabel.text = cellContent;
                        cell.editingIndicatorLine.hidden = !self.orderDetailTVCStatus;
                        cell.separatorLine.hidden = NO; // 每一个 section 的最后一个 cell 不显示 separator，前几个 cell 显示
                        return cell;
                    }
                        break;
                    case 3: // 收货地址
                    {
                        if (self.orderDetailTVCStatus == OrderDetailTVCStatusNormal) {  // 查看模式下，label 多行显示
                            BaseTextLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextLabelCell forIndexPath:indexPath];
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            cell.textLabel.text = cellTitle;
                            cell.detailTextLabel.text = cellContent;
                            cell.editingIndicatorLine.hidden = YES;
                            cell.separatorLine.hidden = YES; // 每一个 section 的最后一个 cell 不显示 separator，前几个 cell 显示
                            return cell;
                        } else {    // 编辑模式下，textField 单行编辑
                            BaseTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextFieldCell forIndexPath:indexPath];
                            cell.textLabel.text = cellTitle;
                            cell.textField.text = cellContent;
                            cell.textField.delegate = self;
                            cell.textField.tag = indexPath.section * 10 + indexPath.row;
                            cell.textField.keyboardType = UIKeyboardTypeDefault;
                            cell.textField.enabled = YES;
                            cell.separatorLine.hidden = YES; // 每一个 section 的最后一个 cell 不显示 separator，前几个 cell 显示
                            return cell;
                        }
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            case 1: // 发货状态、发货时间、物流信息、快递单号
            {
                switch (indexPath.row) {
                    case 0: // 发货状态
                    {
                        BaseTextLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextLabelCell forIndexPath:indexPath];
                        cell.textLabel.text = cellTitle;
                        cell.detailTextLabel.text = cellContent;
                        cell.editingIndicatorLine.hidden = !self.orderDetailTVCStatus;
                        cell.separatorLine.hidden = NO; // 每一个 section 的最后一个 cell 不显示 separator，前几个 cell 显示
                        return cell;
                    }
                        break;
                    case 1: // 发货时间
                    {
                        BaseTextLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextLabelCell forIndexPath:indexPath];
                        cell.textLabel.text = cellTitle;
                        cell.detailTextLabel.text = cellContent;
                        cell.editingIndicatorLine.hidden = !self.orderDetailTVCStatus;
                        cell.separatorLine.hidden = NO; // 每一个 section 的最后一个 cell 不显示 separator，前几个 cell 显示
                        return cell;
                    }
                        break;
                    case 2: // 物流信息
                    {
                        BaseTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextFieldCell forIndexPath:indexPath];
                        cell.textLabel.text = cellTitle;
                        cell.textField.text = cellContent;
                        cell.textField.delegate = self;
                        cell.textField.tag = indexPath.section * 10 + indexPath.row;
                        cell.textField.keyboardType = UIKeyboardTypeDefault;
                        cell.textField.enabled = self.orderDetailTVCStatus;
                        cell.separatorLine.hidden = NO; // 每一个 section 的最后一个 cell 不显示 separator，前几个 cell 显示
                        return cell;
                    }
                        break;
                    case 3: // 快递单号
                    {
                        BaseTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextFieldCell forIndexPath:indexPath];
                        cell.textLabel.text = cellTitle;
                        cell.textField.text = cellContent;
                        cell.textField.delegate = self;
                        cell.textField.tag = indexPath.section * 10 + indexPath.row;
                        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                        cell.textField.enabled = self.orderDetailTVCStatus;
                        cell.separatorLine.hidden = YES; // 每一个 section 的最后一个 cell 不显示 separator，前几个 cell 显示
                        return cell;
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            case 2: // 订单金额、付款状态、付款渠道
            {
                switch (indexPath.row) {
                    case 0: // 订单金额
                    {
                        BaseTextFieldWithUnitCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextFieldWithUnitCell forIndexPath:indexPath];
                        cell.textLabel.text = cellTitle;
                        cell.textField.text = cellContent;
                        cell.textField.delegate = self;
                        cell.textField.tag = indexPath.section * 10 + indexPath.row;
                        cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
                        cell.textField.enabled = self.orderDetailTVCStatus;
                        cell.unitLabel.text = @"软妹币";
                        cell.separatorLine.hidden = NO; // 每一个 section 的最后一个 cell 不显示 separator，前几个 cell 显示
                        return cell;
                    }
                        break;
                    case 1: // 付款状态
                    {
                        BaseTextLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextLabelCell forIndexPath:indexPath];
                        cell.textLabel.text = cellTitle;
                        cell.detailTextLabel.text = cellContent;
                        cell.editingIndicatorLine.hidden = !self.orderDetailTVCStatus;
                        cell.separatorLine.hidden = NO; // 每一个 section 的最后一个 cell 不显示 separator，前几个 cell 显示
                        return cell;
                    }
                        break;
                    case 2: // 付款渠道
                    {
                        BaseTextLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextLabelCell forIndexPath:indexPath];
                        cell.textLabel.text = cellTitle;
                        cell.detailTextLabel.text = cellContent;
                        cell.editingIndicatorLine.hidden = !self.orderDetailTVCStatus;
                        cell.separatorLine.hidden = YES; // 每一个 section 的最后一个 cell 不显示 separator，前几个 cell 显示
                        return cell;
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            default:
                break;
        }
    } else {
        BaseTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextFieldCell forIndexPath:indexPath];
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView sectionCornerRadiusWillDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 1:
            switch (indexPath.row) {
                case 0: // 发货状态
                {
                    [self.czPickerView showPickerView];
                }
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSUInteger section = textField.tag / 10;
    NSUInteger row = textField.tag % 10;
    [self.cellContentList[section] replaceObjectAtIndex:row withObject:textField.text];
}

#pragma mark - Action
/** 编辑 */
- (void)editAction {
    self.orderDetailTVCStatus = OrderDetailTVCStatusEdit;
}

/** 保存 */
- (void)saveAction {
    [self.view endEditing:YES];
    self.orderDetailTVCStatus = OrderDetailTVCStatusNormal;
}

@end
