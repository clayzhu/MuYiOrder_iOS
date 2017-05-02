//
//  MBProgressHelper.m
//  EnjoyiOS
//
//  Created by ug19 on 16/5/11.
//  Copyright © 2016年 Ugood. All rights reserved.
//

#import "MBProgressHelper.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"

static NSTimeInterval const progressHideDelay = 20.0;
static NSTimeInterval const textHideDelay = 2.0;

@implementation MBProgressHelper

+ (void)showProgressHUDInView:(UIView *)view withMessage:(NSString *)message hideDelay:(NSTimeInterval)delay {
	[MBProgressHUD hideHUDForView:view animated:NO];
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
	hud.mode = MBProgressHUDModeIndeterminate;
	hud.detailsLabel.text = message;
	hud.detailsLabel.font = [UIFont systemFontOfSize:15.0];
	[hud hideAnimated:YES afterDelay:delay];
}

+ (void)showProgressHUDInView:(UIView *)view withMessage:(NSString *)message {
	[MBProgressHelper showProgressHUDInView:view withMessage:message hideDelay:progressHideDelay];	// 20秒后消失
}

+ (void)showProgressHUDInView:(UIView *)view {
	[MBProgressHelper showProgressHUDInView:view withMessage:@"加载中"];
}

+ (void)hideAllHUDsForView:(UIView*)view {
//	[MBProgressHUD hideAllHUDsForView:view animated:YES];
	[MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)showTextHUDInView:(UIView *)view withMessage:(NSString *)message hideDelay:(NSTimeInterval)delay completionBlock:(MBProgressHelperCompletionBlock)completion {
	[MBProgressHUD hideHUDForView:view animated:NO];
	if (message.length == 0) {	// message 字符串为空时，不显示
		return;
	}
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
	if (completion) {
		hud.completionBlock = ^{
			completion();
		};
	}
	hud.mode = MBProgressHUDModeText;
	hud.detailsLabel.text = message;
	hud.detailsLabel.font = [UIFont systemFontOfSize:15.0];
	[hud hideAnimated:YES afterDelay:delay];
}

+ (void)showTextHUDInView:(UIView *)view withMessage:(NSString *)message completionBlock:(MBProgressHelperCompletionBlock)completion {
	[MBProgressHelper showTextHUDInView:view withMessage:message hideDelay:textHideDelay completionBlock:completion];
}

+ (void)showNoNetworkErrorTipInView:(UIView*)view completionBlock:(MBProgressHelperCompletionBlock)completion {
	[MBProgressHelper showTextHUDInView:view withMessage:@"服务器请求失败或网络异常" hideDelay:textHideDelay completionBlock:completion];
}

+ (void)showProgressHUDWithMessage:(NSString *)message hideDelay:(NSTimeInterval)delay {
	[MBProgressHelper showProgressHUDInView:WINDOW_MAIN withMessage:message hideDelay:delay];
}

+ (void)showProgressHUDWithMessage:(NSString *)message {
	[MBProgressHelper showProgressHUDInView:WINDOW_MAIN withMessage:message];
}

+ (void)showProgressHUD {
	[MBProgressHelper showProgressHUDInView:WINDOW_MAIN];
}

+ (void)hideProgressHUD {
	[MBProgressHelper hideAllHUDsForView:WINDOW_MAIN];
}

+ (void)showTextHUDWithMessage:(NSString *)message hideDelay:(NSTimeInterval)delay completionBlock:(MBProgressHelperCompletionBlock)completion {
	[MBProgressHelper showTextHUDInView:WINDOW_MAIN withMessage:message hideDelay:delay completionBlock:completion];
}

+ (void)showTextHUDWithMessage:(NSString *)message completionBlock:(MBProgressHelperCompletionBlock)completion {
	[MBProgressHelper showTextHUDWithMessage:message hideDelay:textHideDelay completionBlock:completion];
}

+ (void)showTextHUDWithMessage:(NSString *)message {
	[MBProgressHelper showTextHUDWithMessage:message completionBlock:nil];
}

+ (void)showNoNetworkErrorTipCompletionBlock:(MBProgressHelperCompletionBlock)completion {
	[MBProgressHelper showNoNetworkErrorTipInView:WINDOW_MAIN completionBlock:completion];
}

+ (void)showNoNetworkErrorTip {
	[MBProgressHelper showNoNetworkErrorTipCompletionBlock:nil];
}

+ (void)showImageHUD:(UIImage *)image message:(NSString *)message hideDelay:(NSTimeInterval)delay completionBlock:(MBProgressHelperCompletionBlock)completion {
	UIImageView *iv = [[UIImageView alloc] initWithImage:image];	// 图片
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:WINDOW_MAIN animated:YES];
	hud.mode = MBProgressHUDModeCustomView;
	hud.customView = iv;
	hud.label.text = message;
	hud.label.adjustsFontSizeToFitWidth = YES;
	if (completion) {
		hud.completionBlock = ^{
			completion();
		};
	}
	[hud hideAnimated:YES afterDelay:delay];
}

+ (void)showGifProgressHUD {
	UIImage  *image = [UIImage sd_animatedGIFNamed:@"loading_white"];
	UIImageView *gifview = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, image.size.width / 2, image.size.height / 2)];
	gifview.image = image;
	
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:WINDOW_MAIN animated:YES];
//	hud.bezelView.backgroundColor = [UIColor colorWithRed:0.22 green:0.22 blue:0.22 alpha:0.5];
	hud.mode = MBProgressHUDModeCustomView;
	hud.customView = gifview;
//	[hud hide:YES afterDelay:progressHideDelay];
	[hud hideAnimated:YES afterDelay:progressHideDelay];
}

@end
