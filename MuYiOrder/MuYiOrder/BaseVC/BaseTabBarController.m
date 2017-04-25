//
//  BaseTabBarController.m
//  Baicheng
//
//  Created by Apple on 2017/4/10.
//  Copyright © 2017年 Ugoodtech. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (UIViewController *)setWithStoryboardName:(NSString *)sbName
                           viewControllerId:(NSString *)vcId
                                      title:(NSString *)title
                                      image:(NSString *)imageName
                              selectedImage:(NSString *)selectedImageName {
    BaseViewController *vc = [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:vcId];
    vc.cannotPopByGestureRecognizer = YES;
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);//图片位置偏移
	[vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];    // 未点中时字体灰色
	[vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hex_33bc99]} forState:UIControlStateSelected];  // 点中时字体绿色
    return vc;
}

@end
