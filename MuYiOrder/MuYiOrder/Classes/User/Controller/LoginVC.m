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
- (void)setupViewStyle {
    [self.usernameView setupTFViewStyle];
    [self.pwdView setupTFViewStyle];
    [self.submitView setupTFViewStyle];
}

#pragma mark - Action
- (IBAction)submitAction:(UIButton *)sender {
//    MuYiTBC *tbc = [[MuYiTBC alloc] init];
//    [self presentViewController:tbc animated:YES completion:nil];
    
    BmobObject *user = [BmobObject objectWithClassName:@"_User"];
    [user saveAllWithDictionary:@{@"username":@"Clay", @"password":@"qqqqqq"}];
    [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        NSLog(@"");
    }];
    NSLog(@"");
}

@end
