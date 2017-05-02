//
//  LoginVC.m
//  MuYiOrder
//
//  Created by ug19 on 2017/4/23.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "LoginVC.h"
#import "MuYiTBC.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UIView *usernameView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;

@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@property (weak, nonatomic) IBOutlet UIView *submitView;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MuYi楊";
    [self setupViewStyle];
    [self setupDefaultViewData];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Setup
/** 设置 UI 样式 */
- (void)setupViewStyle {
    [self.usernameView setupTFViewStyle];
    [self.pwdView setupTFViewStyle];
    [self.submitView setupTFViewStyle];
}

- (void)setupDefaultViewData {
    self.usernameTF.text = @"muyiyang";
    self.pwdTF.text = @"muyiyang";
}

#pragma mark - Request
/** 请求登录 */
- (void)requestLogin {
    [BmobUser loginWithUsernameInBackground:self.usernameTF.text password:self.pwdTF.text
                                      block:^(BmobUser *user, NSError *error) {
                                          if (user) {
                                              MuYiTBC *tbc = [[MuYiTBC alloc] init];
                                              [self presentViewController:tbc animated:YES completion:nil];
                                          } else {
                                              NSLog(@"error:%@", error);
                                          }
                                      }];
}

#pragma mark - Action
- (IBAction)submitAction:(UIButton *)sender {
    if ([CZString isEmpty:self.usernameTF.text]) {
//        [MBProgressHelper showTextHUDWithMessage:@"请输入您的用户名"];
        return;
    }
    if ([CZString isEmpty:self.pwdTF.text]) {
//        [MBProgressHelper showTextHUDWithMessage:@"请输入您的登录密码"];
        return;
    }
    [self.view endEditing:YES];
    
    [self requestLogin];
}

@end
