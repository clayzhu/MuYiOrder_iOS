//
//  ProductDetailVC.m
//  MuYiOrder
//
//  Created by ug19 on 2017/5/16.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "ProductDetailVC.h"

@interface ProductDetailVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *productNumberView;
@property (weak, nonatomic) IBOutlet UITextField *productNumberTF;

@end

@implementation ProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新花样";
    [self setupBackBtn];
    [self setupNavItem];
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
/** 设置导航栏上按钮 */
- (void)setupNavItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_ok"] style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
}

/** 设置 UI 样式 */
- (void)setupViewStyle {
    [self.productNumberView setupTFViewStyle];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 将 textField 中已经在的内容和将要输入的内容拼接，组成将会出现在 textField 中的字符串
    NSMutableString *inputMS = [textField.text mutableCopy];
    [inputMS replaceCharactersInRange:range withString:string];
    if (inputMS.length == 0) {  // 原本只剩1个数字，删除时替换为0
        textField.text = @"0";
        return NO;
    }
    if (inputMS.length > 1) {
        if ([[inputMS substringToIndex:1] isEqualToString:@"0"]) {  // 原本只有1个0，输入其他数字时，删除原来的0
            [inputMS replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
            textField.text = inputMS;
            return NO;
        }
    }
    return YES;
}

#pragma mark - Action
/** 保存 */
- (void)saveAction {
    
}

/** 加产品数量 */
- (IBAction)plusAction:(UIButton *)sender {
    NSInteger number = [self.productNumberTF.text integerValue];    // 输入框内容
    self.productNumberTF.text = [NSString stringWithFormat:@"%@", @(number + 1)];
}

/** 减产品数量 */
- (IBAction)minusAction:(UIButton *)sender {
    NSInteger number = [self.productNumberTF.text integerValue];   // 输入框内容
    if (number == 0) {   // 输入框内容为0时，不能再减
        return;
    }
    self.productNumberTF.text = [NSString stringWithFormat:@"%@", @(number - 1)];
}

@end
