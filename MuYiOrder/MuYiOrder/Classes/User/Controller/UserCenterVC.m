//
//  UserCenterVC.m
//  MuYiOrder
//
//  Created by Apple on 2017/4/26.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "UserCenterVC.h"
#import "ProjectUtility.h"

@interface UserCenterVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *submitView;

@end

@implementation UserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"羊羊羊";
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kUserCenterCell = @"UserCenterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserCenterCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kUserCenterCell];
    }
    cell.textLabel.text = @"cell";
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Action
- (IBAction)submitAction:(UIButton *)sender {
    // 删除登录
    [AppUtility signOut];
    
    UIViewController *vc = [ProjectUtility rootViewController];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
