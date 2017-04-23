//
//  BaseNavigationController.m
//  EnjoyiOS
//
//  Created by Ug's iMac on 2016/11/23.
//  Copyright © 2016年 Ugood. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.navigationBar.tintColor = [UIColor whiteColor];
	[self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
	[self.navigationBar setBackgroundImage:[UIImage imageWithColorForNavigationController:[UIColor hex_33bc99]] forBarMetrics:UIBarMetricsDefault];
	// 设置底部阴影（分割线）
	[self.navigationBar setShadowImage:[UIImage imageWithColorForNavigationController:[UIColor clearColor]]];
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

- (UIViewController *)childViewControllerForStatusBarStyle {
	return self.visibleViewController;	// 如果 childVC 设置了 statusBarStyle，则使用 childVC 的设置；另外使用 BaseViewController 和 BaseTableViewController 中 -preferredStatusBarStyle 的设置
}

/*
// 支持在子类中设置单独的选择
- (BOOL)shouldAutorotate {
	return self.visibleViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	return self.visibleViewController.supportedInterfaceOrientations;
}
*/

@end

@implementation UIImage (NCColor)

+ (UIImage *)imageWithColorForNavigationController:(UIColor *)color {
	UIImage *image = [UIImage imageWithColorForNavigationController:color imageSize:CGSizeMake(50.0, 50.0)];
	return image;
}

+ (UIImage *)imageWithColorForNavigationController:(UIColor *)color imageSize:(CGSize)size {
	CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, color.CGColor);
	CGContextFillRect(context, rect);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

@end
