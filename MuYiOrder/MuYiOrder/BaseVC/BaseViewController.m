//
//  BaseViewController.m
//  EnjoyiOS
//
//  Created by Ug's iMac on 16/8/31.
//  Copyright © 2016年 Ugood. All rights reserved.
//

#import "BaseViewController.h"
//#import "LoginVC.h"
//#import "NavController.h"
//#import "MLInputDodger.h"

@interface BaseViewController ()
@property (strong, nonatomic) UILabel *titleLbl;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	NSLog(@"appear:%@", NSStringFromClass(self.class));
	// 监听键盘弹出的通知
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
	// 右滑屏幕左侧边缘可返回
	if (self.navigationController != nil) {
		self.navigationController.interactivePopGestureRecognizer.delegate = self;
	}
}

//- (void)viewDidAppear:(BOOL)animated {
//	[super viewDidAppear:animated];
//	[self setInputDodger];
//}

//- (void)viewWillDisappear:(BOOL)animated {
//	[super viewWillDisappear:animated];
//	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
//}

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
	return UIStatusBarStyleDefault;	// 默认 statusBarStyle 为黑色
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

//- (void)keyboardDidShow:(NSNotification *)notification {
//	_keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//}

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
	[self setupBackBtnWithBackImage:[UIImage imageNamed:@"nav_back_normal"] pressedImage:[UIImage imageNamed:@"nav_back_pressed"]];
}

- (void)back {
	if (_popToRootVC) {
		[self.navigationController popToRootViewControllerAnimated:YES];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

/** 设置键盘弹出收起 */
//- (void)setInputDodger {
//	self.view.shiftHeightAsDodgeViewForMLInputDodger = 20.f;
//	[self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
//}

#pragma mark - 设置导航按钮
- (void)setBackBtnWithImageName:(NSString *)imageName {
	[self setLeftBarButtonitemWithTitle:@"" target:self action:@selector(popVc) imageName:imageName];
}
- (void)setDismissBtnWithImageName:(NSString *)imageName {
	[self setLeftBarButtonitemWithTitle:@"" target:self action:@selector(dismissVc) imageName:imageName];
}
- (void)popVc {
	[self.navigationController popViewControllerAnimated:YES];
}
- (void)dismissVc {
	[self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setLeftBarButtonitemWithTitle:(NSString *)title target:(id)target action:(SEL)action imageName:(NSString *)imageName {
	UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
	[leftBtn setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	self.navigationItem.leftBarButtonItem = leftBtn;
}
- (void)setRightBarButtonitemWithTitle:(NSString *)title target:(id)target action:(SEL)action imageName:(NSString *)imageName {
	UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
	[rightBtn setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)setRightBarButtonitemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action {
	[self setRightBarButtonitemWithTitle:@"" target:target action:action imageName:imageName];
}

- (void)setLeftBarButtonitemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action {
	[self setLeftBarButtonitemWithTitle:@"" target:target action:action imageName:imageName];
}

#pragma mark - 页面 push
- (void)pushToSb:(NSString *)sb vc:(NSString *)vc {
	self.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:[[UIStoryboard storyboardWithName:sb bundle:nil] instantiateViewControllerWithIdentifier:vc] animated:YES];
}

- (void)pushForTabbarToSb:(NSString *)sb vc:(NSString *)vc {
	self.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:[[UIStoryboard storyboardWithName:sb bundle:nil] instantiateViewControllerWithIdentifier:vc] animated:YES];
	self.hidesBottomBarWhenPushed = NO;
}

- (void)pushVc:(UIViewController *)vc {
	self.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:vc animated:YES];
}

- (void)pushForTabbarVc:(UIViewController *)vc {
	self.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:vc animated:YES];
	self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 页面 present
- (void)presentToSb:(NSString *)sb vc:(NSString *)vc completion:(void (^)(void))completion {
	self.hidesBottomBarWhenPushed = YES;
	[self presentViewController:[[UIStoryboard storyboardWithName:sb bundle:nil] instantiateViewControllerWithIdentifier:vc] animated:YES completion:completion];
}

- (void)presentForTabbarToSb:(NSString *)sb vc:(NSString *)vc completion:(void (^)(void))completion {
	self.hidesBottomBarWhenPushed = YES;
	[self presentViewController:[[UIStoryboard storyboardWithName:sb bundle:nil] instantiateViewControllerWithIdentifier:vc] animated:YES completion:completion];
	self.hidesBottomBarWhenPushed = NO;
}

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion {
	self.hidesBottomBarWhenPushed = YES;
	[self presentViewController:vc animated:YES completion:completion];
}

- (void)presentForTabbarVc:(UIViewController *)vc completion:(void (^)(void))completion {
	self.hidesBottomBarWhenPushed = YES;
	[self presentViewController:vc animated:YES completion:completion];
	self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 重写 self.title
- (UILabel *)titleLbl {
	if (!_titleLbl) {
		UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 0, 44)];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.textColor = [UIColor blackColor];
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

@implementation UIImage (VCColor)

+ (UIImage *)imageWithColorForViewController:(UIColor *)color {
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
