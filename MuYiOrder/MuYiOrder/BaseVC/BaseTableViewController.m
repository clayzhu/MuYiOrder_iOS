//
//  BaseTableViewController.m
//  EnjoyiOS
//
//  Created by Ug's iMac on 16/8/31.
//  Copyright © 2016年 Ugood. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()
@property (strong, nonatomic) UILabel *titleLbl;

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	NSLog(@"appear:%@", NSStringFromClass(self.class));
	// 右滑屏幕左侧边缘可返回
	if (self.navigationController != nil) {
		self.navigationController.interactivePopGestureRecognizer.delegate = self;
	}
}

//- (void)viewDidLayoutSubviews {
//	[super viewDidLayoutSubviews];
//	[self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0 weight:UIFontWeightMedium],
//																	NSForegroundColorAttributeName:[UIColor blueColor]}
//														 forState:UIControlStateNormal];
//	[self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0 weight:UIFontWeightMedium],
//																	 NSForegroundColorAttributeName:[UIColor blueColor]}
//														  forState:UIControlStateNormal];
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;	// 默认 statusBarStyle 为白色
}

- (void)dealloc {
	NSLog(@"dealloc:%@", NSStringFromClass(self.class));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setupBackBtnWithBackImage:(UIImage *)backImage pressedImage:(UIImage *)pressedImage {
	// 用 UIButton 做返回按钮
	UIImage *leftBackImage = backImage;
	UIButton *leftBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, leftBackImage.size.width + 10.0, 44.0)];
	[leftBackBtn setImage:leftBackImage forState:UIControlStateNormal];
	[leftBackBtn setImage:pressedImage forState:UIControlStateHighlighted];
	[leftBackBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBackBtn];
//	// 用 UIBarButtonItem 做返回按钮
//	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)setupBackBtn {
	[self setupBackBtnWithBackImage:[UIImage imageNamed:@"nav_back"] pressedImage:[UIImage imageNamed:@"nav_back"]];
}

- (void)back {
	if (_popToRootVC) {
		[self.navigationController popToRootViewControllerAnimated:YES];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

#pragma mark - 重写 self.title
- (UILabel *)titleLbl {
	if (!_titleLbl) {
		UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 0, 44)];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.textAlignment = NSTextAlignmentCenter;
		[titleLabel setFont:[UIFont systemFontOfSize:17.0]];
		_titleLbl = titleLabel;
	}
	return _titleLbl;
}

/** 重写 setTitle 方法，防止 tabBar 与 naviBar 冲突 */
- (NSString *)title {
	return self.titleLbl.text;
}

- (void)setTitle:(NSString *)title {
	[self.titleLbl setText:title];
	self.navigationItem.titleView = self.titleLbl;
}

- (void)setTitleColor:(UIColor *)color {
	self.titleLbl.textColor = color;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
	if (self.cannotPopByGestureRecognizer) {
		return NO;
	} else {
		return YES;
	}
}

//- (void)loginHandler:(void (^)(void))handler mobile:(NSString *)mobile {
//	if ([AppUtility isSignedIn]) {
//		if (handler) {	// 已登录则处理 handler 请求
//			handler();
//		}
//	} else {	// 未登录则弹出登录页
//		dispatch_async(dispatch_get_main_queue(), ^{
//			LoginVC *vc = [[UIStoryboard storyboardWithName:@"UserCenter" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginVC"];
//			if (mobile.length > 0) {
//				vc.mobile = mobile;
//			}
//			if (handler) {
//				vc.handler = handler;
//			}
//			NavController *nc = [[NavController alloc] initWithRootViewController:vc];
//			[self presentViewController:nc animated:YES completion:nil];
//		});
//	}
//}
//
//- (void)logoutHandler:(void (^)(void))handler {
//	[MBProgressHelper showTextHUDWithMessage:@"身份信息已过期，请重新登录"];
//	[AppUtility signOut];
//	[self loginHandler:handler mobile:nil];
//}

@end

@implementation UIImage (TVCColor)

+ (UIImage *)imageWithColorForTableViewController:(UIColor *)color {
	CGRect rect = CGRectMake(0.0, 0.0, 50.0, 50.0);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, color.CGColor);
	CGContextFillRect(context, rect);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

@end
