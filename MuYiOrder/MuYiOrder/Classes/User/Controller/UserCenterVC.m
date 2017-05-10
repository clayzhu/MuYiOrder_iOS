//
//  UserCenterVC.m
//  MuYiOrder
//
//  Created by Apple on 2017/4/26.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "UserCenterVC.h"
#import "ProjectUtility.h"
#import "BaseTextFieldCell.h"

static NSString *kBaseTextFieldCell = @"BaseTextFieldCell";

@interface UserCenterVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *submitView;

@end

@implementation UserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"羊羊羊";
    [self setupViewStyle];
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

#pragma mark - Setup
/** 设置 UI 样式 */
- (void)setupViewStyle {
    [self.submitView setupTFViewStyle];
}

- (void)registerCell {
    [self.tableView registerNib:[UINib nibWithNibName:kBaseTextFieldCell bundle:nil] forCellReuseIdentifier:kBaseTextFieldCell];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseTextFieldCell forIndexPath:indexPath];
    cell.textLabel.text = @"金库";
    cell.textField.text = @"0.00 软妹币";
    cell.textField.enabled = NO;
    cell.separatorLine.hidden = YES;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView sectionCornerRadiusWillDisplayCell:cell forRowAtIndexPath:indexPath];
}

#pragma mark - Action
- (IBAction)submitAction:(UIButton *)sender {
    // 删除登录
    [AppUtility signOut];
    
    UIViewController *vc = [ProjectUtility rootViewController];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
